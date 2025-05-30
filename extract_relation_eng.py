import os
import json
import openai
from util import merge_json, parse_json
from dotenv import load_dotenv
from deduplication import deduplicate

def extract():
    result_dir = "./output/result"
    chunks_dir = "./output/chunked_document"

    # 1. JSON 파일 로딩
    with open(f"{result_dir}/result.json", "r", encoding="utf-8") as f:
        result_json = json.load(f)
        nodes = result_json["nodes"]

    load_dotenv()
    api_key = os.getenv("OPENAI_API_KEY")

    client = openai.OpenAI(api_key=api_key)

    purpose = input('목적 입력 : ')

    system_msg = (
        "You extract relation using entitiy from text for knowledge graphs used in RAG systems. "
        "Respond with valid JSON only."
    )

    i = 0
    while True:
        filename = f"{chunks_dir}/chunked_output_{i}.txt"
        
        if not os.path.exists(filename):
            print(f"📁 파일 없음: {filename} → 종료합니다.")
            break

        with open(filename, "r", encoding="utf-8") as f:
            content = f.read()
            # print(f"✅ chunked_output_{i}.txt 내용:\n{content}\n")


        prompt = f"""
        Text:
        {content}

        Entities (Nodes):
        {nodes}
        
        Extract all meaningful *relations* between the given entities mentioned in the text above.

        Instructions:
        - Do **not** modify or invent entities. Use the provided nodes *exactly as they are*.
        - For each relation, identify the correct `start_node` and `end_node` by matching the `name` field in the given nodes.
        - Set the `relationship` field using only **SCREAMING_SNAKE_CASE**
        - Add appropriate key-value pairs in the `properties` field based on contextual information in the text.
        - Be accurate and specific. Use information from the text only.

        Output Format (JSON):
        {{
            "nodes": {nodes},  # Keep the nodes exactly the same
            "relations": [
                {{
                    "start_node": "<ExactEntityName>",
                    "relationship": "<RELATION_TYPE>",
                    "end_node": "<ExactEntityName>",
                    "properties": {{
                        "key1": "value1",
                        "key2": "value2"
                    }}
                }},
                ...
            ]
        }}

        """


        
        # OpenAI GPT 호출
        response = client.chat.completions.create(
            model="gpt-4o",
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

        if not os.path.exists(result_path):
            # 파일이 없으면 새로 생성 + parsed_json 저장
            with open(result_path, "w", encoding="utf-8") as f:
                json.dump(parsed_json, f, ensure_ascii=False, indent=4)
            print("✅ result.json이 없어서 새로 생성했습니다.")
            old_result = None
        else:
            # 파일이 있으면 기존 스키마 로드
            with open(result_path, "r", encoding="utf-8") as f:
                old_result = json.load(f)
            print("📄 기존 result.json을 old_result로 불러왔습니다.")
            merged_result = merge_json(old_result, parsed_json, node_key=("label", "name"))
            with open(result_path, "w", encoding="utf-8") as f:
                json.dump(merged_result, f, ensure_ascii=False, indent=4)
            print("✅ 병합된 result 저장 완료: result.json")
        
        deduplicate(result_path)
            
        i += 1

if __name__ == "__main__": 
    extract()
