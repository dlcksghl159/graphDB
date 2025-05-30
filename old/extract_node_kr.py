import os
import json
import openai
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

        
        # OpenAI GPT 호출
        response = client.chat.completions.create(
            model="gpt-4o",
            response_format={ "type": "json_object" },
            messages=[
                {"role": "system", "content": system_msg},
                {"role": "user", "content": prompt}
            ]
        )

            
        # 응답 내용 가져오기
        gpt_output = response.choices[0].message.content

        parsed_json = parse_json(gpt_output)

        result_path = result_dir+"/result"

        with open(result_path+f'_{i}.json', "w", encoding="utf-8") as f:
                json.dump(parsed_json, f, ensure_ascii=False, indent=4)

        result_path += '.json'

        if not os.path.exists(result_path):
            # 파일이 없으면 새로 생성 + parsed_json 저장
            with open(result_path, "w", encoding="utf-8") as f:
                json.dump(parsed_json, f, ensure_ascii=False, indent=4)
            old_result = None
        else:
            # 파일이 있으면 기존 스키마 로드
            with open(result_path, "r", encoding="utf-8") as f:
                old_result = json.load(f)
            merged_result = merge_json(old_result, parsed_json, node_key=("label", "name"))
            with open(result_path, "w", encoding="utf-8") as f:
                json.dump(merged_result, f, ensure_ascii=False, indent=4)
        
        deduplicate(result_path)

        print(f"[{i}] node 추출 완료")
            
        i += 1
if __name__ == "__main__": 
    main(purpose = "기업판매")
