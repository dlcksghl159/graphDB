import os
import json
import hashlib
import requests
import openai

# api_key = "up_lQV4sikxTIxBWw1mhqDec6WI6cu49"  
# filename = "./obzen.pdf"  # 파일 경로
# # filename = "./fake_document.pdf"
# output_file = "parsed_result.json"  # 저장할 JSON 파일 이름

# url = "https://api.upstage.ai/v1/document-digitization"
# headers = {"Authorization": f"Bearer {api_key}"}
# files = {"document": open(filename, "rb")}
# data = {"ocr": "force", "model": "document-parse"}

# response = requests.post(url, headers=headers, files=files, data=data)

# # 결과를 JSON 파일로 저장
# with open(output_file, "w", encoding="utf-8") as f:
#     json.dump(response.json(), f, ensure_ascii=False, indent=2)

# print(f"✅ 결과가 '{output_file}' 파일에 저장되었습니다.")

# #----------------------------------------------------------------------------------
# # 1. JSON 파일 로딩
# with open("parsed_result.json", "r", encoding="utf-8") as f:
#     data = json.load(f)

# # 2. HTML 부분만 추출
# html_content = data["content"].get("html", "")

# # 3. 텍스트 파일로 저장
# with open("html_content.txt", "w", encoding="utf-8") as f:
#     f.write(html_content)

# # -----------------------------------------------------------------------------------
# #문서 chunking 
# from bs4 import BeautifulSoup
# import re

# def split_html_by_sentence(html: str, chunk_size: int = 3000) -> list[str]:
#     soup = BeautifulSoup(html, "html.parser")
    
#     # 텍스트 블록들 HTML 그대로 유지
#     blocks = []
#     for tag in soup.find_all(["h1", "h2", "h3", "p", "table", "ul", "ol", "figure"]):
#         blocks.append(str(tag))

#     # 문장 기준 청크 나누기
#     chunks = []
#     current_chunk = ""

#     sentence_end_pattern = re.compile(r"(?<=[.!?。])\s|(?<=</p>)|(?<=</table>)")

#     for block in blocks:
#         current_chunk += block

#         if len(current_chunk) >= chunk_size:
#             # 문장 기준으로 나누기
#             split_points = sentence_end_pattern.split(current_chunk)
#             temp_chunk = ""
#             for part in split_points:
#                 temp_chunk += part
#                 if len(temp_chunk) >= chunk_size:
#                     chunks.append(temp_chunk.strip())
#                     temp_chunk = ""
#             current_chunk = temp_chunk

#     if current_chunk.strip():
#         chunks.append(current_chunk.strip())

#     return chunks

# # 사용 예시
# with open("html_content.txt", "r", encoding="utf-8") as f:
#     html_text = f.read()

# chunks = split_html_by_sentence(html_text)

# for i, chunk in enumerate(chunks):
#     print(f"\n### Chunk {i+1} ###\n{chunk}\n")  # 앞부분만 출력

# # docs를 텍스트 파일로 저장
# for i, chunk in enumerate(chunks):
#     with open(f"chunked_output_{i}.txt", "w", encoding="utf-8") as f:
#         f.write(f"{chunk}")



# # --------------------------------------------------------------------------------


import os
purpose = input('목적 입력: ')

system_msg = (
    "You extract entity/relation schemas from text for knowledge graphs used in RAG systems. "
    "Respond with valid JSON only."
)

client = openai.OpenAI(api_key="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")

from collections import defaultdict

def merge_schema_with_relations(old_schema: dict, new_schema: dict) -> dict:
    # --- 노드 병합 ---
    def build_node_dict(nodes):
        result = {}
        for node in nodes:
            label = node["label"]
            properties = node.get("properties", {})
            if label in result:
                result[label].update(properties)
            else:
                result[label] = properties.copy()
        return result

    old_nodes = build_node_dict(old_schema.get("nodes", []))
    new_nodes = build_node_dict(new_schema.get("nodes", []))
    all_labels = set(old_nodes.keys()).union(new_nodes.keys())

    merged_nodes = []
    for label in all_labels:
        merged_props = {**old_nodes.get(label, {}), **new_nodes.get(label, {})}
        merged_nodes.append({
            "label": label,
            "properties": merged_props
        })

    # --- 관계 병합 ---
    def rel_key(rel):
        return (rel["start_node"], rel["relationship"], rel["end_node"])

    old_rels_dict = {rel_key(r): r.get("properties", {}) for r in old_schema.get("relations", [])}
    new_rels_dict = {rel_key(r): r.get("properties", {}) for r in new_schema.get("relations", [])}
    all_keys = set(old_rels_dict.keys()).union(new_rels_dict.keys())

    merged_relations = []
    for key in all_keys:
        start_node, relationship, end_node = key
        merged_props = {**old_rels_dict.get(key, {}), **new_rels_dict.get(key, {})}
        merged_relations.append({
            "start_node": start_node,
            "relationship": relationship,
            "end_node": end_node,
            "properties": merged_props
        })

    return {
        "nodes": merged_nodes,
        "relations": merged_relations
    }



i = 0
while True:
    filename = f"chunked_output_{i}.txt"
    
    if not os.path.exists(filename):
        print(f"📁 파일 없음: {filename} → 종료합니다.")
        break

    with open(filename, "r", encoding="utf-8") as f:
        content = f.read()

    # GPT 프롬프트 구성
    prompt = f'''{content}\n\nGive me Json Schema of Node types and Relations types 
    to make a knowledge graph for RAG system '{purpose}', 
    using this text, in the form of  
    { 
        {"nodes": [{"label":"", "properties":{}},] },  
        { "relations": [{"start_node":"", "relationship":"", "end_node":"", "properties":{}}, ]}
    }.  You just have to decide keys of properties and for each property keys you should put "" as value.'''

    
    # OpenAI GPT 호출
    response = client.chat.completions.create(
        model="gpt-4o",
        messages=[
            {"role": "system", "content": system_msg},
            {"role": "user", "content": prompt}
        ]
    )

    # 결과 출력
    print("📄 GPT 응답:")
    print(response.choices[0].message.content)

    # 응답 내용 가져오기
    gpt_output = response.choices[0].message.content

    import re

    # GPT 응답 중 JSON 구조만 추출 (Lazy match, 전체 내용)
    match = re.search(r'\{\s*"nodes"\s*:\s*\[.*?\],\s*"relations"\s*:\s*\[.*?\]\s*\}', gpt_output, re.DOTALL)
    if match:
        json_data = match.group()
        try:
            parsed_json = json.loads(json_data)
        except json.JSONDecodeError as e:
            print("❌ JSON 파싱 실패:", e)
            parsed_json = {}
    else:
        print("❌ JSON 구조가 감지되지 않음")
        parsed_json = {}

    schema_path = "schema.json"

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
        merged_schema = merge_schema_with_relations(old_schema, parsed_json)
        print("old schema")
        print(old_schema)
        print("schema")
        print(parsed_json)
        print("new schema")
        print(merged_schema)
        with open(schema_path, "w", encoding="utf-8") as f:
            json.dump(merged_schema, f, ensure_ascii=False, indent=4)
        print("✅ 병합된 schema 저장 완료: schema.json")

    
    i += 1






# --------------------------------------------------------------------------
# 1. JSON 파일 로딩
with open("schema.json", "r", encoding="utf-8") as f:
    schema_json = json.load(f)

purpose = input('목적 입력 : ')

system_msg = (
    "You extract entity/relation from text for knowledge graphs used in RAG systems. "
    "Respond with valid JSON only."
)


client = openai.OpenAI(api_key="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")


i = 0
while True:
    filename = f"chunked_output_{i}.txt"
    
    if not os.path.exists(filename):
        print(f"📁 파일 없음: {filename} → 종료합니다.")
        break

    with open(filename, "r", encoding="utf-8") as f:
        content = f.read()
        print(f"✅ chunked_output_{i}.txt 내용:\n{content}\n")

    prompt = f'''
    Text : {content}, 
    Schema : {schema_json}, 
    Extract specific nodes and relations in JSON format from the given text using the given schema for a knowledge graph 
    to be used in a RAG system focused on '{purpose}'. 
    '''

    
    # OpenAI GPT 호출
    response = client.chat.completions.create(
        model="gpt-4o",
        messages=[
            {"role": "system", "content": system_msg},
            {"role": "user", "content": prompt}
        ]
    )

    
    # 결과 출력
    print("📄 GPT 응답:")
    print(response.choices[0].message.content)

        
    # 응답 내용 가져오기
    gpt_output = response.choices[0].message.content

    import re


    # JSON 구조 감지 및 추출 (전체 JSON 블록을 greedy하게 탐지)
    match = re.search(r'\{\s*"nodes"\s*:\s*\[.*\],\s*"relations"\s*:\s*\[.*\]\s*\}', gpt_output, re.DOTALL)

    parsed_json = {}

    if match:
        json_data = match.group()
        
        # JSON 정리 (불필요한 공백, 줄 바꿈 제거 가능)
        json_data = json_data.strip()

        try:
            # JSON 문자열을 딕셔너리로 파싱
            parsed_json = json.loads(json_data)
        except json.JSONDecodeError as e:
            print("❌ JSON 파싱 실패:", e)
            print("⚠️ 추출된 JSON 원본:\n", json_data)
    else:
        print("❌ JSON 구조가 감지되지 않음")
        print("⚠️ GPT 출력 원문:\n", gpt_output)

    result_path = 'result,json'

    if not os.path.exists(result_path):
        # 파일이 없으면 새로 생성 + parsed_json 저장
        with open(result_path, "w", encoding="utf-8") as f:
            json.dump(parsed_json, f, ensure_ascii=False, indent=4)
        print("✅ schema.json이 없어서 새로 생성했습니다.")
        old_schema = None
    else:
        # 파일이 있으면 기존 스키마 로드
        with open(result_path, "r", encoding="utf-8") as f:
            old_schema = json.load(f)
        print("📄 기존 schema.json을 old_schema로 불러왔습니다.")
        merged_schema = merge_schema_nodes_by_label(old_schema, parsed_json)
        print("old schema")
        print(old_schema)
        print("schema")
        print(parsed_json)
        print("new schema")
        print(merged_schema)
        with open(result_path, "w", encoding="utf-8") as f:
            json.dump(merged_schema, f, ensure_ascii=False, indent=4)
        print("✅ 병합된 schema 저장 완료: schema.json")

        
    i += 1













