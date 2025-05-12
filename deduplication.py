import os
import json
import openai
from util import parse_json
from dotenv import load_dotenv

def deduplicate(data_path):

    # 1. JSON 파일 로딩
    with open(data_path, "r", encoding="utf-8") as f:
        result_json = json.load(f)

    root, ext = os.path.splitext(data_path)
    path = f"{root}_origin{ext}"

    with open(path, "w", encoding="utf-8") as f:
        json.dump(result_json, f, ensure_ascii=False, indent=4)

    load_dotenv()
    api_key = os.getenv("OPENAI_API_KEY")

    client = openai.OpenAI(api_key=api_key)


    system_msg = (
        "You remove overlapping information from given entity/relations for knowledge graphs used in RAG systems. "
        "Respond with valid JSON only."
    )



    prompt = f"""
    {result_json}

    Deduplicate overlapping and vague information in the given set of entities and relations.

    ### Instructions:
    - Identify and remove redundant, vague, or less informative entries.
    - **Avoid generalized nodes** (e.g., "Asia", "Southeast Asia") when specific nodes (e.g., "Vietnam", "Thailand") are present and better represent the context.
    - Retain only the version that is more specific, complete, and contextually relevant.
    - Replace ambiguous phrases (e.g., "starting with") with the actual entities they refer to.
    - Ensure consistency and avoid duplication in the final output.
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


    with open(data_path, "w", encoding="utf-8") as f:
        json.dump(parsed_json, f, ensure_ascii=False, indent=4)
        print("✅ dereplicated result 저장 완료")


