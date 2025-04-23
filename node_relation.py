import os
import json
import openai
from util import merge_json, parse_json
from dotenv import load_dotenv
from dereplication import dereplicate

result_dir = "./output/result"
os.makedirs(result_dir, exist_ok=True)

chunks_dir = "./output/chunked_document"
schema_dir = "./output/schema"

# 1. JSON 파일 로딩
with open(f"{schema_dir}/schema.json", "r", encoding="utf-8") as f:
    schema_json = json.load(f)

load_dotenv()
api_key = os.getenv("OPENAI_API_KEY")

client = openai.OpenAI(api_key=api_key)

purpose = input('목적 입력 : ')

system_msg = (
    "You extract entity/relation from text for knowledge graphs used in RAG systems. "
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

    Schema:
    {schema_json}

    Your task is to extract specific nodes and relations from the given text according to the schema provided.

    ### Objective:
    Build a structured JSON representation for a knowledge graph that will be used in a RAG (Retrieval-Augmented Generation) system focused on **'{purpose}'**.

    ### Guidelines:
    - Match each extracted value with its corresponding data type as defined in the schema.
    - All string values must be **nouns** or **noun phrases**.
    - For **relations**, replace `NodeLabel` in `start_node` and `end_node` with the actual node **name** from the extracted data.
    - Ensure the output strictly follows the structure defined in the schema.
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

    result_path = result_dir+"/result"

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
    
    dereplicate(result_path)
        
    i += 1

