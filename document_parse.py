import os
import json
import requests
from dotenv import load_dotenv

output_dir = "./output/parsed_document"
os.makedirs(output_dir, exist_ok=True)

load_dotenv()   
api_key = os.getenv("UPSTAGE_API_KEY")

filename = "./data/document/news.pdf"  # 파일 경로

url = "https://api.upstage.ai/v1/document-digitization"
headers = {"Authorization": f"Bearer {api_key}"}
files = {"document": open(filename, "rb")}
data = {"ocr": "force", "model": "document-parse"}

response = requests.post(url, headers=headers, files=files, data=data)

# 결과를 JSON 파일로 저장
with open(f"{output_dir}/parsed_result.json", "w", encoding="utf-8") as f:
    json.dump(response.json(), f, ensure_ascii=False, indent=2)

print(f"✅ 결과가 parsed_result.json 파일에 저장되었습니다.")


with open(f"{output_dir}/parsed_result.json", "r", encoding="utf-8") as f:
    data = json.load(f)

# 2. HTML 부분만 추출
html_content = data["content"].get("html", "")

# 3. 텍스트 파일로 저장
with open(f"{output_dir}/html_content.txt", "w", encoding="utf-8") as f:
    f.write(html_content)