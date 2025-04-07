import os
import json
import hashlib
import requests
import openai

api_key = "up_lQV4sikxTIxBWw1mhqDec6WI6cu49"  # 실제 키로 바꿔주세요
filename = "./report.pdf"  # 파일 경로
# filename = "./fake_document.pdf"
output_file = "parsed_result.json"  # 저장할 JSON 파일 이름

url = "https://api.upstage.ai/v1/document-digitization"
headers = {"Authorization": f"Bearer {api_key}"}
files = {"document": open(filename, "rb")}
data = {"ocr": "force", "model": "document-parse"}

response = requests.post(url, headers=headers, files=files, data=data)

# 결과를 JSON 파일로 저장
with open(output_file, "w", encoding="utf-8") as f:
    json.dump(response.json(), f, ensure_ascii=False, indent=2)

print(f"✅ 결과가 '{output_file}' 파일에 저장되었습니다.")

#----------------------------------------------------------------------------------
# 1. JSON 파일 로딩
with open("parsed_result.json", "r", encoding="utf-8") as f:
    data = json.load(f)

# 2. HTML 부분만 추출
html_content = data["content"].get("html", "")

# 3. 텍스트 파일로 저장
with open("html_content.txt", "w", encoding="utf-8") as f:
    f.write(html_content)


purpose = input('목적 입력: ')

# GPT 프롬프트 구성
prompt = f'''{html_content}\n\nGive me Json Schema of Node types and Relations types 
to make a knowledge graph for RAG system '{purpose}', 
using this text, in the form of  
{ 
    {"nodes": [{"label":"", "properties":{}},] },  
    { "relations": [{"start_node":"", "relationship":"", "end_node":"", "properties":{}}, ]}
}.  You just have to decide keys of properties and put "" as value.'''

system_msg = (
    "You extract entity/relation schemas from text for knowledge graphs used in RAG systems. "
    "Respond with valid JSON only."
)

client = openai.OpenAI(api_key="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")

# OpenAI GPT 호출
response = client.chat.completions.create(
    model="o1-2024-12-17",
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



# 결과를 JSON 파일로 저장
with open("schema.json", "w", encoding="utf-8") as f:
    json.dump(parsed_json, f, ensure_ascii=False, indent=4)

print("✅ JSON 파일로 저장 완료: schema.json")
# --------------------------------------------------------------------------

# 1. JSON 파일 로딩
with open("parsed_result.json", "r", encoding="utf-8") as f:
    data = json.load(f)

# 2. HTML 부분만 추출
html_content = data["content"].get("html", "")

# 1. JSON 파일 로딩
with open("schema.json", "r", encoding="utf-8") as f:
    schema_json = json.load(f)

purpose = input('목적 입력 : ')

system_msg = (
    "You extract entity/relation from text for knowledge graphs used in RAG systems. "
    "Respond with valid JSON only."
)

prompt = f'''
Text : {html_content}, 
Schema : {schema_json}, 
Extract specific nodes and relations in JSON format from the given text using the given schema for a knowledge graph 
to be used in a RAG system focused on '{purpose}'. 
'''

client = openai.OpenAI(api_key="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")

# OpenAI GPT 호출
response = client.chat.completions.create(
    model="o1-2024-12-17",
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

# 결과 저장 (비어 있지 않은 경우)
if parsed_json:
    with open("results.json", "w", encoding="utf-8") as f:
        json.dump(parsed_json, f, ensure_ascii=False, indent=4)
    print("✅ JSON 파일로 저장 완료: results.json")
