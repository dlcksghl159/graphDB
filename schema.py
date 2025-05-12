import os
import json
import openai
from dotenv import load_dotenv

from util import merge_json, parse_json

def extract():
    OUTPUT_ROOT = os.getenv("OUTPUT_ROOT", "output")
    schema_dir  = os.path.join(OUTPUT_ROOT, "schema")
    chunks_dir  = os.path.join(OUTPUT_ROOT, "chunked_document")
    os.makedirs(schema_dir, exist_ok=True)

    load_dotenv()   
    api_key = os.getenv("OPENAI_API_KEY")

    client = openai.OpenAI(api_key=api_key)

    purpose = input("지식 그래프 구축 목적을 입력하세요: ")

    system_msg = (
        "당신은 RAG 시스템용 지식 그래프 스키마(엔티티/관계 타입)를 텍스트에서 추출합니다. "
        "반드시 올바른 JSON 형식으로만 응답하세요."
    )

    from collections import defaultdict



    i = 0
    while True:
        filename = f"{chunks_dir}/chunked_output_{i}.txt"
        
        if not os.path.exists(filename):
            print(f"파일 없음: {filename} → 종료합니다.")
            break

        with open(filename, "r", encoding="utf-8") as f:
            content = f.read()

        # GPT 프롬프트 구성
        prompt = f"""
        주어진 텍스트 내용을 바탕으로 **'{purpose}'** 목적의 RAG 시스템을 구축하기 위한 지식 그래프의 **스키마(Schema)**를 JSON 형식으로 정의하세요.

        ### 작성 지침:
        1. `nodes`에는 **지식 그래프에 반드시 포함되어야 할 주요 개체 유형**(Node)을 정의합니다.
        2. 각 Node는 `label`, `name`, `properties` 필드를 포함해야 하며, `properties`의 각 항목 값은 `"string"`, `"int"` 등 **데이터 타입 문자열**로 기입합니다.
        3. `relations`에는 개체 간의 **관계 유형(Relation)**을 정의하며, `start_node`, `end_node`에는 **노드의 라벨(label)**만 기입합니다.
        4. **불필요하게 복잡한 속성은 생략**하고, **RAG 시스템 구축에 꼭 필요한 정보만 간결하게 포함**하세요.
        5. 최종 출력은 **올바른 JSON 형식**으로 작성하세요. 추가 설명 없이 **JSON만 출력**하세요.

        ### 출력 형식 예시:
        {{
        "nodes": [
            {{"label": "NODE_LABEL", "name": "String", "properties": {{"key": "데이터타입"}}}}
        ],
        "relations": [
            {{"start_node": "NodeLabel", "relationship": "RELATION_NAME", "end_node": "NodeLabel", "properties": {{"key": "데이터타입"}}}}
        ]
        }}

        ### 텍스트:
        {content}
        """

        # OpenAI GPT 호출
        response = client.chat.completions.create(
            model="o1",
            response_format={ "type": "json_object" },
            messages=[
                {"role": "system", "content": system_msg},
                {"role": "user", "content": prompt}
            ]
        )


        # 응답 내용 가져오기
        gpt_output = response.choices[0].message.content
        parsed_json = parse_json(gpt_output)
        schema_path = schema_dir+'/schema'
        
        with open(schema_path+f'_{i}.json', "w", encoding="utf-8") as f:
            json.dump(parsed_json, f, ensure_ascii=False, indent=4)
            
        schema_path += '.json'

        if not os.path.exists(schema_path):
            # 파일이 없으면 새로 생성 + parsed_json 저장
            with open(schema_path, "w", encoding="utf-8") as f:
                json.dump(parsed_json, f, ensure_ascii=False, indent=4)
            old_schema = None
        else:
            # 파일이 있으면 기존 스키마 로드
            with open(schema_path, "r", encoding="utf-8") as f:
                old_schema = json.load(f)
            merged_schema = merge_json(old_schema, parsed_json, node_key=("label",))
            with open(schema_path, "w", encoding="utf-8") as f:
                json.dump(merged_schema, f, ensure_ascii=False, indent=4)
        print(f"[{i}] scheam 추출 완료")
        
        i += 1

if __name__ == "__main__": 
    extract()
