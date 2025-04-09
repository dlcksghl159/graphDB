import os
import json
import openai
from dotenv import load_dotenv

from util import merge_json, parse_json

schema_dir = "./output/schema"
os.makedirs(schema_dir, exist_ok=True)

chunks_dir = "./output/chunked_document"


load_dotenv()   
api_key = os.getenv("OPENAI_API_KEY")

client = openai.OpenAI(api_key=api_key)

purpose = input('목적 입력: ')

system_msg = (
    "You extract entity/relation schemas from text for knowledge graphs used in RAG systems. "
    "Respond with valid JSON only."
)

from collections import defaultdict



i = 0
while True:
    filename = f"{chunks_dir}/chunked_output_{i}.txt"
    
    if not os.path.exists(filename):
        print(f"📁 파일 없음: {filename} → 종료합니다.")
        break

    with open(filename, "r", encoding="utf-8") as f:
        content = f.read()

    # GPT 프롬프트 구성
    prompt = content + '''\n\nGive me Json Schema of Node types and Relations types 
            to make a knowledge graph for RAG system "'''+purpose+'''", 
            using this text, in the form of  
            {
                "nodes": [{"label": "NODE_LABEL", "name": String, "properties": {} }],  
                "relations": [{"start_node": NodeLabel, "relationship": "RELATION_NAME", "end_node": NodeLabel, "properties":{} }]
            }.  
            You just have to decide keys of properties and for each property key you should put its data type as value.
            For relations, you should treat Node Labels as type.
            '''
    # OpenAI GPT 호출
    response = client.chat.completions.create(
        model="o1",
        messages=[
            {"role": "system", "content": system_msg},
            {"role": "user", "content": prompt}
        ]
    )


    # 응답 내용 가져오기
    gpt_output = response.choices[0].message.content
    parsed_json = parse_json(gpt_output)
    schema_path = schema_dir+'/schema.json'
    
    with open(schema_path+f'_{i}.json', "w", encoding="utf-8") as f:
        json.dump(parsed_json, f, ensure_ascii=False, indent=4)

    if not os.path.exists(schema_path):
        # 파일이 없으면 새로 생성 + parsed_json 저장
        with open(schema_path, "w", encoding="utf-8") as f:
            json.dump(parsed_json, f, ensure_ascii=False, indent=4)
        print("✅ schema.json이 없어서 새로 생성했습니다.")
        old_schema = None
    else:
        # 파일이 있으면 기존 스키마 로드
        with open(schema_path, "r", encoding="utf-8") as f:
            old_schema = json.load(f)
        print("📄 기존 schema.json을 old_schema로 불러왔습니다.")
        merged_schema = merge_json(old_schema, parsed_json, node_key=("label",))
        with open(schema_path, "w", encoding="utf-8") as f:
            json.dump(merged_schema, f, ensure_ascii=False, indent=4)
        print("✅ 병합된 schema 저장 완료: schema.json")

    

    
    i += 1

