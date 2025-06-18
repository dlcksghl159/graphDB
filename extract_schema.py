# filename: schema_extract_mp.py
import os, json, glob
import multiprocessing as mp
from dotenv import load_dotenv
import openai

from util import merge_json, parse_json   # 기존 util 그대로 사용

# ────────────────────────────────────────────────────────────────
# 1. 전역 설정 ─ 프로세스들에서 공유 (읽기 전용)
# ────────────────────────────────────────────────────────────────
OUTPUT_ROOT   = os.getenv("OUTPUT_ROOT", "output")
SCHEMA_DIR    = os.path.join(OUTPUT_ROOT, "schema")
CHUNKS_DIR    = os.path.join(OUTPUT_ROOT, "chunked_document")
os.makedirs(SCHEMA_DIR, exist_ok=True)

# 시스템 프롬프트 (전역 상수)
SYSTEM_MSG = (
    "당신은 RAG 시스템용 지식 그래프 스키마(엔티티/관계 타입)를 텍스트에서 추출합니다. "
    "반드시 올바른 JSON 형식으로만 응답하세요."
)

# ────────────────────────────────────────────────────────────────
# 2. 워커 함수 – 프로세스마다 실행
# ────────────────────────────────────────────────────────────────
def _process_chunk(args: tuple[int, str, str]) -> dict:
    """
    파라미터
      idx      : chunk 인덱스
      purpose  : 사용자 입력 목적
      system   : 시스템 프롬프트
    반환값
      parsed_json (dict) – 추출된 스키마
    """
    idx, purpose, system = args

    # 각 프로세스에서 환경-변수, OpenAI client 초기화
    load_dotenv()
    api_key = os.getenv("OPENAI_API_KEY")
    client  = openai.OpenAI(api_key=api_key)

    fname = f"{CHUNKS_DIR}/chunked_output_{idx}.txt"
    with open(fname, "r", encoding="utf-8") as f:
        content = f.read()

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

    resp = client.chat.completions.create(
        model="gpt-4.1",
        response_format={"type": "json_object"},
        messages=[
            {"role": "system", "content": system},
            {"role": "user", "content": prompt}
        ]
    )

    parsed = parse_json(resp.choices[0].message.content)

    # 개별 결과 저장
    out_path = os.path.join(SCHEMA_DIR, f"schema_{idx}.json")
    with open(out_path, "w", encoding="utf-8") as f:
        json.dump(parsed, f, ensure_ascii=False, indent=2)

    print(f"[{idx}] schema 추출 완료")
    return parsed


# ────────────────────────────────────────────────────────────────
# 3. 메인 – 파일 목록 수집 → 병렬 실행 → 머지
# ────────────────────────────────────────────────────────────────
def extract_mp(max_workers: int = 15, purpose = "기업 판매"):
    # 처리할 chunk 파일 인덱스 계산
    files = sorted(glob.glob(os.path.join(CHUNKS_DIR, "chunked_output_*.txt")))
    if not files:
        print("⚠️  chunked_document 폴더에 파일이 없습니다.")
        return

    indices = [int(os.path.splitext(os.path.basename(f))[0].split("_")[-1]) for f in files]

    # Pool 실행
    print(f"🚀 멀티프로세싱 시작 (workers={max_workers}, 총 {len(indices)}개)…")
    with mp.Pool(processes=max_workers) as pool:
        all_schemas = pool.map(_process_chunk, [(i, purpose, SYSTEM_MSG) for i in indices])

    # ----------- 최종 머지 -----------
    merged_path = os.path.join(SCHEMA_DIR, "schema.json")
    merged = {}
    for sc in all_schemas:                # 순서 상관없이 head-tail 머지
        merged = merge_json(merged, sc, node_key=("label",))

    with open(merged_path, "w", encoding="utf-8") as f:
        json.dump(merged, f, ensure_ascii=False, indent=2)

    print(f"🎉 모든 스키마 추출 및 병합 완료 → {merged_path}")

def main(purpose="종합 뉴스 분석"):
    extract_mp(max_workers=10, purpose=purpose)

# ────────────────────────────────────────────────────────────────
if __name__ == "__main__":
    main()
    # CPU가 많아도 API rate-limit을 고려해 4~6개 정도가 안전
    