import os
import json
import openai
from util import merge_json, parse_json
from dotenv import load_dotenv
from deduplication import deduplicate

result_dir = "./output/result"
chunks_dir = "./output/chunked_document"
os.makedirs(result_dir, exist_ok=True)

# 1. JSON 파일 로딩
with open(f"{result_dir}/result.json", "r", encoding="utf-8") as f:
    result_json = json.load(f)
    nodes = result_json["nodes"]

load_dotenv()
api_key = os.getenv("OPENAI_API_KEY")

client = openai.OpenAI(api_key=api_key)

purpose = input('지식 그래프 구축 목적을 입력하세요: ')

system_msg = (
    "당신은 RAG 시스템에 사용되는 지식 그래프 작성을 위해 텍스트에서 엔티티를 활용하여 관계를 추출하는 역할을 합니다. "
    "반드시 올바른 JSON 형식으로만 응답하세요."
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
        model="gpt-4o",
        messages=[
            {"role": "system", "content": system_msg},
            {"role": "user", "content": prompt}
        ],
        response_format="json"
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
        old_result = None
    else:
        # 파일이 있으면 기존 스키마 로드
        with open(result_path, "r", encoding="utf-8") as f:
            old_result = json.load(f)
        merged_result = merge_json(old_result, parsed_json, node_key=("label", "name"))
        with open(result_path, "w", encoding="utf-8") as f:
            json.dump(merged_result, f, ensure_ascii=False, indent=4)
        
    
    deduplicate(result_path)
    print(f"[{i}] relation 추출 완료")
        
    i += 1

