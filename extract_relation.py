import os
import json
import openai
from util import merge_json, parse_json
from dotenv import load_dotenv
from deduplication import deduplicate
from tqdm import tqdm
from concurrent.futures import ThreadPoolExecutor, as_completed

def process_file(filename, chunks_dir, result_dir, system_msg, nodes, api_key):
        client = openai.OpenAI(api_key=api_key)
        i = int(filename.split('_')[-1].split('.')[0])  # chunked_output_0.txt → 0

        # 파일 경로 설정
        filename = os.path.join(chunks_dir, filename)

        # 파일이 존재하지 않으면 종료
        
        if not os.path.exists(filename):
            print(f"파일 없음: {filename} → 종료합니다.")
            return

        with open(filename, "r", encoding="utf-8") as f:
            content = f.read()


        prompt = f""" 

        주어진 텍스트에 언급된 엔티티 간의 의미 있는 *관계*를 모두 추출하세요.

        ### 지침:
        - 엔티티를 수정하거나 새로 만들지 마세요. 제공된 노드를 *그대로* 사용하세요.
        - 각 관계마다 `start_node`와 `end_node`는 노드의 `name` 필드를 정확히 일치시켜 지정하세요.
        - `relationship` 필드는 반드시 **SCREAMING_SNAKE_CASE**로 작성하세요.
        - `properties` 필드에는 텍스트 문맥에서 추론 가능한 핵심 정보를 적절한 키-값 쌍으로 추가하세요.
        - 오로지 텍스트에 기반하여 정확하고 구체적으로 작성하세요.

        ### 출력 형식(JSON):
        {{
            "nodes": {nodes},  # 노드를 그대로 유지
            "relations": [
                {{
                    "start_node": "<정확한엔티티이름>",
                    "relationship": "<RELATION_TYPE>",
                    "end_node": "<정확한엔티티이름>",
                    "properties": {{
                        "key1": "value1",
                        "key2": "value2"
                    }}
                }}
                ...
            ]
        }}

        ### 텍스트:
        {content}

        ### 엔티티(노드):
        {nodes}
        """


        
        # OpenAI GPT 호출
        response = client.chat.completions.create(
            model="gpt-4.1",
            response_format={"type": "json_object"},# json_schema
            messages=[
                {"role": "system", "content": system_msg},
                {"role": "user", "content": prompt}
            ]
        )

            
        # 응답 내용 가져오기
        gpt_output = response.choices[0].message.content

        parsed_json = parse_json(gpt_output)

        result_path = result_dir+"/result_naive"

        with open(result_path+f'_{i}.json', "w", encoding="utf-8") as f:
                json.dump(parsed_json, f, ensure_ascii=False, indent=4)

        result_path += '.json'

        # if not os.path.exists(result_path):
        #     # 파일이 없으면 새로 생성 + parsed_json 저장
        #     with open(result_path, "w", encoding="utf-8") as f:
        #         json.dump(parsed_json, f, ensure_ascii=False, indent=4)
        #     old_result = None
        # else:
        #     # 파일이 있으면 기존 스키마 로드
        #     with open(result_path, "r", encoding="utf-8") as f:
        #         old_result = json.load(f)
        #     merged_result = merge_json(old_result, parsed_json, node_key=("label", "name"))
        #     with open(result_path, "w", encoding="utf-8") as f:
        #         json.dump(merged_result, f, ensure_ascii=False, indent=4)
            
        
        # deduplicate(result_path)
        print(f"[{i}] relation 추출 완료")

def main(purpose = "기업판매"):
    OUTPUT_ROOT = os.getenv("OUTPUT_ROOT", "output")  # 기본값: "output"

    result_dir  = os.path.join(OUTPUT_ROOT, "result")
    chunks_dir  = os.path.join(OUTPUT_ROOT, "chunked_document")

    os.makedirs(result_dir, exist_ok=True)

    # 1. JSON 파일 로딩
    with open("output/result/result.json", "r", encoding="utf-8") as f:
        result_json = json.load(f)
        nodes = result_json["nodes"]

    load_dotenv()
    api_key = os.getenv("OPENAI_API_KEY")

    system_msg = (
        "당신은 RAG 시스템에 사용되는 지식 그래프 작성을 위해 텍스트에서 엔티티를 활용하여 관계를 추출하는 역할을 합니다. "
        "반드시 올바른 JSON 형식으로만 응답하세요."
    )

    i = 0
    file_names = os.listdir(chunks_dir)
    with ThreadPoolExecutor(max_workers=16) as executor:
        futures = {
            executor.submit(process_file, filename, chunks_dir, result_dir, system_msg, nodes, api_key): filename
            for filename in file_names if filename.endswith('.txt')
        }
        
        for future in tqdm(as_completed(futures), total=len(futures), desc="Processing files"):
            try:
                future.result()  # 결과를 기다림
            except Exception as e:
                print(f"Error processing {futures[future]}: {e}")

    # 최종 결과 병합
    result_path = os.path.join(result_dir, "result.json")
    for i in range(len(file_names)):
        chunked_result_path = os.path.join(result_dir, f"result_naive_{i}.json")
        if os.path.exists(chunked_result_path):
            with open(chunked_result_path, "r", encoding="utf-8") as f:
                chunked_data = json.load(f)
            if i == 0:
                final_result = chunked_data
            else:
                final_result = merge_json(final_result, chunked_data, node_key=("label", "name"))
    
    # if result path exists, load it and concat.
    if os.path.exists(result_path):
        with open(result_path, "r", encoding="utf-8") as f:
            existing_data = json.load(f)
        existing_data["relations"].extend(final_result["relations"])
        existing_data["nodes"].extend(final_result["nodes"])
    with open(result_path, "w", encoding="utf-8") as f:
        json.dump(final_result, f, ensure_ascii=False, indent=4)

    # 중복 제거
    deduplicate(result_path)
    print(f"✅ 관계 추출 완료: {result_path}") 




if __name__ == "__main__": 
    main(purpose = "기업판매")