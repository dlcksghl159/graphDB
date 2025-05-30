import os
import json
import openai
from tqdm import tqdm
from util import merge_json, parse_json
from dotenv import load_dotenv
from deduplication import deduplicate

def main(purpose = "기업판매"):
    # 공통 출력 루트 (main.py에서 미리: os.environ["OUTPUT_ROOT"] = "output_..." 로 설정)
    OUTPUT_ROOT = os.getenv("OUTPUT_ROOT", "output")   # 기본값: "output"

    result_dir  = os.path.join(OUTPUT_ROOT, "result")
    chunks_dir  = os.path.join(OUTPUT_ROOT, "chunked_document")
    schema_dir  = os.path.join(OUTPUT_ROOT, "schema")

    os.makedirs(result_dir, exist_ok=True)

    # 1. JSON 파일 로딩
    with open(f"{schema_dir}/schema.json", "r", encoding="utf-8") as f:
        schema_json = json.load(f)

    load_dotenv()
    api_key = os.getenv("OPENAI_API_KEY")

    client = openai.OpenAI(api_key=api_key)

    system_msg = (
        "당신은 RAG 시스템에 사용될 지식 그래프 구축을 위해 텍스트에서 엔티티와 관계를 추출합니다. "
        "반드시 유효한 JSON 형식으로만 응답하세요."
    )

    i = 0
    while True:
        filename = f"{chunks_dir}/chunked_output_{i}.txt"
        
        if not os.path.exists(filename):
            print(f"파일 없음: {filename} → 종료합니다.")
            break

        with open(filename, "r", encoding="utf-8") as f:
            content = f.read()

    prompt = f"""
    ### 작업 목표
    주어진 스키마에 따라 텍스트에서 의미 있는 노드와 관계를 추출하여 **'{purpose}'** 에 초점을 맞춘 RAG(검색 증강 생성) 시스템용 지식 그래프를 JSON 형태로 구축하세요.

    ### 지침
    - 추출한 값은 스키마에 정의된 데이터 타입과 일치해야 합니다.
    - 모든 문자열 값은 **명사** 혹은 **명사구** 여야 합니다.
    - 노드의 **name** 필드는 간결하고 명확해야 하며, 설명을 포함하지 마세요.
    - 일반적인(추상적인) 개념에 대해서는 노드를 생성하지 마세요.
    - **relations**에서 `start_node`와 `end_node`의 `NodeLabel`을 실제 노드 **name** 으로 대체하세요.
    - 출력은 반드시 스키마에서 정의한 구조를 엄격히 따르세요.

    ### 텍스트:
    {content}

    ### 스키마:
    {schema_json}
    """
    print(f"[{idx}] {filename} 처리 중...")
    response = client.chat.completions.create(
        model="gpt-4o",
        response_format={ "type": "json_object" },
        messages=[
            {"role": "system", "content": system_msg},
            {"role": "user", "content": prompt}
        ]
    )

    gpt_output = response.choices[0].message.content
    parsed_json = parse_json(gpt_output)
    result_path = os.path.join(result_dir, f'result_{idx}.json')

    with open(result_path, "w", encoding="utf-8") as f:
        json.dump(parsed_json, f, ensure_ascii=False, indent=4)

    print(f"[{idx}] node 추출 완료 ({filename})")
    return result_path, parsed_json

def main(purpose="기업판매"):
    OUTPUT_ROOT = os.getenv("OUTPUT_ROOT", "output")
    result_dir = os.path.join(OUTPUT_ROOT, "result")
    chunks_dir = os.path.join(OUTPUT_ROOT, "chunked_document")
    schema_dir = os.path.join(OUTPUT_ROOT, "schema")
    os.makedirs(result_dir, exist_ok=True)

    with open(f"{schema_dir}/schema.json", "r", encoding="utf-8") as f:
        schema_json = json.load(f)

    load_dotenv()
    api_key = os.getenv("OPENAI_API_KEY")

    system_msg = (
        "당신은 RAG 시스템에 사용될 지식 그래프 구축을 위해 텍스트에서 엔티티와 관계를 추출합니다. "
        "반드시 유효한 JSON 형식으로만 응답하세요."
    )

    file_list = sorted(os.listdir(chunks_dir))  # ex) ['chunked_output_0.txt', ...]
    n_files = len(file_list)

    # 5개씩 병렬 처리
    chunk_size = 20
    pbar = tqdm(range(0, n_files, chunk_size), desc="Processing batches", unit="batch")
    for start_idx in pbar:
        batch_files = file_list[start_idx:start_idx+chunk_size]
        futures = []
        with ThreadPoolExecutor(max_workers=chunk_size) as executor:
            for i, filename in enumerate(batch_files):
                idx = start_idx + i
                future = executor.submit(process_file, idx, filename, chunks_dir, result_dir, schema_json, api_key, system_msg, purpose)
                futures.append(future)
            # 결과 모으기
            results = []
            for future in as_completed(futures):
                result = future.result()
                if result is not None:
                    results.append(result)
        # 배치 끝나면 deduplicate (원한다면 여기서도 수행 가능)

    # 병합 및 중복 제거 (전체 결과 기준)
    result_path = os.path.join(result_dir, "result.json")
    dedup_list = []
    for idx in range(n_files):
        pbar.set_description(f"Merging result_{idx}.json")
        path = os.path.join(result_dir, f"result_{idx}.json")
        if os.path.exists(path):
            with open(path, "r", encoding="utf-8") as f:
                parsed_json = json.load(f)
            dedup_list.append(parsed_json)
    while len(dedup_list) > 1:
        # 병합 작업
        print(f"병합 중: {len(dedup_list)}개의 JSON 파일")
        process_count = len(dedup_list) // 2
        merged_list = []
        with ThreadPoolExecutor(max_workers=process_count) as executor:
            futures = []
            for i in range(0, len(dedup_list), 2):
                if i + 1 < len(dedup_list):
                    future = executor.submit(merge_json, dedup_list[i], dedup_list[i + 1], node_key=("label", "name"))
                    futures.append(future)
                else:
                    merged_list.append(dedup_list[i])
            for future in as_completed(futures):
                merged_result = future.result()
                merged_list.append(merged_result)
        dedup_list = merged_list
        # 최종 병합 결과 저장
    if dedup_list:
        merged_result = dedup_list[0]
        # 최종 병합 결과를 result.json에 저장
        with open(result_path, "w", encoding="utf-8") as f:
            json.dump(merged_result, f, ensure_ascii=False, indent=4)
        deduplicate(result_path)

        print(f"[{i}] node 추출 완료")
            
        i += 1
if __name__ == "__main__": 
    main(purpose = "기업판매")
