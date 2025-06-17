import os, json, glob
import multiprocessing as mp
from dotenv import load_dotenv
import openai
from typing import Dict, List, Set
from util import merge_json, parse_json

# ────────────────────────────────────────────────────────────────
# 대폭 확장된 스키마 추출 - 더 많은 관계 타입과 패턴 지원
# ────────────────────────────────────────────────────────────────
OUTPUT_ROOT = os.getenv("OUTPUT_ROOT", "output")
SCHEMA_DIR = os.path.join(OUTPUT_ROOT, "schema")
CHUNKS_DIR = os.path.join(OUTPUT_ROOT, "chunked_document")
os.makedirs(SCHEMA_DIR, exist_ok=True)

# 확장된 뉴스 도메인 스키마 템플릿 (PDF 제안사항 반영)
ENHANCED_NEWS_DOMAIN_SCHEMA = {
    "nodes": [
        {"label": "PERSON", "name": "String", "properties": {"full_name": "string", "role": "string", "nationality": "string", "age": "string"}},
        {"label": "COMPANY", "name": "String", "properties": {"full_name": "string", "industry": "string", "headquarters": "string", "founded": "string", "ceo": "string"}},
        {"label": "ORGANIZATION", "name": "String", "properties": {"type": "string", "description": "string", "headquarters": "string"}},
        {"label": "LOCATION", "name": "String", "properties": {"type": "string", "country": "string", "region": "string"}},
        {"label": "EVENT", "name": "String", "properties": {"date": "string", "type": "string", "description": "string", "location": "string"}},
        {"label": "PRODUCT", "name": "String", "properties": {"category": "string", "description": "string", "launch_date": "string", "company": "string"}},
        {"label": "TECHNOLOGY", "name": "String", "properties": {"category": "string", "description": "string", "field": "string"}},
        {"label": "PROJECT", "name": "String", "properties": {"description": "string", "start_date": "string", "status": "string"}},
        {"label": "INVESTMENT", "name": "String", "properties": {"amount": "string", "date": "string", "type": "string"}},
        {"label": "AGREEMENT", "name": "String", "properties": {"type": "string", "date": "string", "description": "string"}}
    ],
    "relations": [
        # 고용 관계
        {"start_node": "PERSON", "relationship": "WORKS_FOR", "end_node": "COMPANY", "properties": {"position": "string", "since": "string"}},
        {"start_node": "PERSON", "relationship": "CEO_OF", "end_node": "COMPANY", "properties": {"since": "string"}},
        {"start_node": "PERSON", "relationship": "FOUNDER_OF", "end_node": "COMPANY", "properties": {"date": "string"}},
        {"start_node": "PERSON", "relationship": "BOARD_MEMBER_OF", "end_node": "COMPANY", "properties": {"role": "string"}},
        
        # 위치 관계
        {"start_node": "COMPANY", "relationship": "HEADQUARTERED_IN", "end_node": "LOCATION", "properties": {}},
        {"start_node": "COMPANY", "relationship": "LOCATED_IN", "end_node": "LOCATION", "properties": {}},
        {"start_node": "EVENT", "relationship": "HELD_IN", "end_node": "LOCATION", "properties": {}},
        {"start_node": "PERSON", "relationship": "LIVES_IN", "end_node": "LOCATION", "properties": {}},
        
        # 비즈니스 관계
        {"start_node": "COMPANY", "relationship": "ACQUIRED", "end_node": "COMPANY", "properties": {"date": "string", "amount": "string"}},
        {"start_node": "COMPANY", "relationship": "PARTNERED_WITH", "end_node": "COMPANY", "properties": {"type": "string", "date": "string"}},
        {"start_node": "COMPANY", "relationship": "INVESTED_IN", "end_node": "COMPANY", "properties": {"amount": "string", "date": "string"}},
        {"start_node": "COMPANY", "relationship": "COMPETES_WITH", "end_node": "COMPANY", "properties": {"market": "string"}},
        {"start_node": "COMPANY", "relationship": "SUBSIDIARY_OF", "end_node": "COMPANY", "properties": {}},
        
        # 제품/기술 관계
        {"start_node": "COMPANY", "relationship": "PRODUCES", "end_node": "PRODUCT", "properties": {}},
        {"start_node": "COMPANY", "relationship": "DEVELOPS", "end_node": "TECHNOLOGY", "properties": {}},
        {"start_node": "PERSON", "relationship": "INVENTED", "end_node": "TECHNOLOGY", "properties": {"date": "string"}},
        {"start_node": "PRODUCT", "relationship": "USES", "end_node": "TECHNOLOGY", "properties": {}},
        
        # 이벤트 관계
        {"start_node": "PERSON", "relationship": "PARTICIPATED_IN", "end_node": "EVENT", "properties": {"role": "string"}},
        {"start_node": "COMPANY", "relationship": "SPONSORED", "end_node": "EVENT", "properties": {}},
        {"start_node": "PERSON", "relationship": "ATTENDED", "end_node": "EVENT", "properties": {}},
        {"start_node": "PERSON", "relationship": "SPOKE_AT", "end_node": "EVENT", "properties": {"topic": "string"}},
        
        # 프로젝트 관계
        {"start_node": "COMPANY", "relationship": "LEADS", "end_node": "PROJECT", "properties": {}},
        {"start_node": "PERSON", "relationship": "MANAGES", "end_node": "PROJECT", "properties": {}},
        {"start_node": "COMPANY", "relationship": "COLLABORATES_ON", "end_node": "PROJECT", "properties": {}},
        
        # 방문/만남 관계
        {"start_node": "PERSON", "relationship": "VISITED", "end_node": "COMPANY", "properties": {"date": "string", "purpose": "string"}},
        {"start_node": "PERSON", "relationship": "MET_WITH", "end_node": "PERSON", "properties": {"date": "string", "purpose": "string"}},
        
        # 투자 관계
        {"start_node": "COMPANY", "relationship": "RECEIVED_INVESTMENT", "end_node": "INVESTMENT", "properties": {}},
        {"start_node": "PERSON", "relationship": "MADE_INVESTMENT", "end_node": "INVESTMENT", "properties": {}},
        
        # 계약/협정 관계
        {"start_node": "COMPANY", "relationship": "SIGNED", "end_node": "AGREEMENT", "properties": {}},
        {"start_node": "PERSON", "relationship": "NEGOTIATED", "end_node": "AGREEMENT", "properties": {}}
    ]
}

# 한국어 관계 표현 매핑 (PDF 제안사항)
KOREAN_RELATION_PATTERNS = {
    "WORKS_FOR": ["일하다", "근무하다", "고용되다", "재직하다", "소속되다", "다니다"],
    "CEO_OF": ["대표이사", "최고경영자", "CEO", "사장", "대표"],
    "FOUNDER_OF": ["창립하다", "창업하다", "설립하다", "창설하다"],
    "HEADQUARTERED_IN": ["본사", "본부", "사옥", "본점"],
    "LOCATED_IN": ["위치하다", "자리하다", "있다"],
    "ACQUIRED": ["인수하다", "매입하다", "사들이다", "인수합병"],
    "PARTNERED_WITH": ["협력하다", "파트너십", "제휴하다", "협업하다"],
    "INVESTED_IN": ["투자하다", "출자하다", "자금조달"],
    "VISITED": ["방문하다", "찾아가다", "들르다"],
    "MET_WITH": ["만나다", "면담하다", "회동하다", "미팅"],
    "PARTICIPATED_IN": ["참가하다", "참여하다", "출석하다"],
    "ATTENDED": ["참석하다", "출석하다", "참관하다"],
    "SPOKE_AT": ["발표하다", "연설하다", "강연하다", "기조연설"]
}

ENHANCED_SYSTEM_MSG = """당신은 한국어 뉴스 기사에서 포괄적인 지식 그래프 스키마를 추출하는 전문가입니다.
다양한 관계 타입을 인식하고 한국어 표현을 표준 관계로 매핑합니다.
비즈니스, 기술, 정치, 사회 관계를 모두 포함합니다.
반드시 올바른 JSON 형식으로만 응답하세요."""

def _enhanced_process_chunk(args: tuple[int, str, str]) -> dict:
    """향상된 청크별 스키마 추출 - 확장된 관계 타입 지원"""
    idx, purpose, system = args
    
    load_dotenv()
    api_key = os.getenv("OPENAI_API_KEY")
    client = openai.OpenAI(api_key=api_key)
    
    fname = f"{CHUNKS_DIR}/chunked_output_{idx}.txt"
    with open(fname, "r", encoding="utf-8") as f:
        content = f.read()
    
    # 관계 패턴 가이드 생성
    relation_guide = ""
    for rel_type, korean_patterns in KOREAN_RELATION_PATTERNS.items():
        relation_guide += f"- {rel_type}: {', '.join(korean_patterns)}\n"
    
    prompt = f"""주어진 한국어 뉴스 기사 텍스트에서 **'{purpose}'** 목적의 확장된 지식 그래프 스키마를 추출하세요.

### 확장된 기본 스키마 (참고 및 확장):
{json.dumps(ENHANCED_NEWS_DOMAIN_SCHEMA, ensure_ascii=False, indent=2)}

### 한국어 관계 표현 가이드:
{relation_guide}

### 스키마 설계 원칙:
1. **포괄적 관계**: 단순한 WORKS_FOR를 넘어 CEO_OF, FOUNDER_OF, BOARD_MEMBER_OF 등 구체적 관계
2. **비즈니스 관계**: ACQUIRED, PARTNERED_WITH, INVESTED_IN, COMPETES_WITH, SUBSIDIARY_OF
3. **이벤트 관계**: PARTICIPATED_IN, ATTENDED, SPOKE_AT, SPONSORED
4. **위치 관계**: HEADQUARTERED_IN (본사), LOCATED_IN (일반), HELD_IN (이벤트)
5. **프로젝트 관계**: LEADS, MANAGES, COLLABORATES_ON

### 확장 지침:
- 텍스트에서 발견되는 새로운 관계 패턴을 추가하세요
- 한국어 표현을 영어 표준 관계명으로 매핑하세요
- 시간, 금액, 위치 등 관계의 속성(properties)을 포함하세요
- 암시적 관계도 명시적으로 스키마에 포함하세요

### 예시:
- "삼성전자를 창업한 이병철" → FOUNDER_OF 관계 필요
- "구글과 파트너십 체결" → PARTNERED_WITH 관계 필요
- "AI 컨퍼런스에서 기조연설" → SPOKE_AT 관계 필요

### 텍스트:
{content}

### 확장된 스키마 (JSON):"""

    resp = client.chat.completions.create(
        model="gpt-4o",
        response_format={"type": "json_object"},
        messages=[
            {"role": "system", "content": system},
            {"role": "user", "content": prompt}
        ],
        temperature=0.2
    )
    
    parsed = parse_json(resp.choices[0].message.content)
    
    # 개별 결과 저장
    out_path = os.path.join(SCHEMA_DIR, f"schema_{idx}.json")
    with open(out_path, "w", encoding="utf-8") as f:
        json.dump(parsed, f, ensure_ascii=False, indent=2)
    
    print(f"[{idx}] 확장된 스키마 추출 완료")
    return parsed

def validate_and_refine_enhanced_schema(merged_schema: Dict) -> Dict:
    """확장된 스키마 검증 및 정제"""
    load_dotenv()
    api_key = os.getenv("OPENAI_API_KEY")
    client = openai.OpenAI(api_key=api_key)
    
    # 한국어 관계 매핑 정보 제공
    korean_mapping_info = json.dumps(KOREAN_RELATION_PATTERNS, ensure_ascii=False, indent=2)
    
    prompt = f"""다음은 한국어 뉴스 기사에서 추출한 확장된 스키마입니다. 
이를 검토하고 다음 기준에 따라 정제하고 표준화하세요:

### 정제 기준:
1. **관계 통합**: 유사한 의미의 관계를 표준명으로 통일
   - EMPLOYED_BY, WORKS_AT → WORKS_FOR
   - HEADQUARTERED_IN, BASED_IN → HEADQUARTERED_IN (본사의 경우)
   - COLLABORATED_WITH → PARTNERED_WITH

2. **한국어 매핑**: 한국어 관계 표현을 표준 영어명으로 변환
{korean_mapping_info}

3. **관계 계층화**: 더 구체적인 관계를 우선
   - CEO_OF는 WORKS_FOR보다 구체적
   - FOUNDER_OF는 일반적 소속보다 구체적

4. **속성 표준화**: 날짜, 금액, 위치 등 일관된 형식
   - date → "YYYY-MM-DD" 또는 "YYYY" 형식
   - amount → 숫자와 단위 표준화

5. **중복 제거**: 의미상 동일한 노드/관계 제거

### 현재 스키마:
{json.dumps(merged_schema, ensure_ascii=False, indent=2)}

### 정제된 확장 스키마 (JSON):"""

    resp = client.chat.completions.create(
        model="gpt-4o",
        response_format={"type": "json_object"},
        messages=[
            {"role": "system", "content": "스키마 정제 및 표준화 전문가로서 포괄적이고 일관된 스키마를 생성합니다."},
            {"role": "user", "content": prompt}
        ],
        temperature=0.1
    )
    
    return parse_json(resp.choices[0].message.content)

def extract_enhanced_schema_mp(max_workers: int = 4, purpose: str = "종합 뉴스 분석"):
    """확장된 멀티프로세싱 스키마 추출"""
    files = sorted(glob.glob(os.path.join(CHUNKS_DIR, "chunked_output_*.txt")))
    if not files:
        print("⚠️ chunked_document 폴더에 파일이 없습니다.")
        return
    
    indices = [int(os.path.splitext(os.path.basename(f))[0].split("_")[-1]) for f in files]
    
    # 1단계: 병렬 추출
    print(f"🚀 1단계: 확장된 스키마 추출 (workers={max_workers}, 총 {len(indices)}개)")
    with mp.Pool(processes=max_workers) as pool:
        all_schemas = pool.map(_enhanced_process_chunk, [(i, purpose, ENHANCED_SYSTEM_MSG) for i in indices])
    
    # 병합 (확장된 기본 스키마에서 시작)
    merged = ENHANCED_NEWS_DOMAIN_SCHEMA.copy()
    for sc in all_schemas:
        merged = merge_json(merged, sc, node_key=("label",))
    
    # 중간 저장
    temp_path = os.path.join(SCHEMA_DIR, "schema_merged_enhanced.json")
    with open(temp_path, "w", encoding="utf-8") as f:
        json.dump(merged, f, ensure_ascii=False, indent=2)
    
    # 2단계: 검증 및 정제
    print("🔍 2단계: 확장된 스키마 검증 및 정제")
    refined = validate_and_refine_enhanced_schema(merged)
    
    # 최종 저장
    final_path = os.path.join(SCHEMA_DIR, "schema.json")
    with open(final_path, "w", encoding="utf-8") as f:
        json.dump(refined, f, ensure_ascii=False, indent=2)
    
    # 통계 출력
    node_count = len(refined.get('nodes', []))
    relation_count = len(refined.get('relations', []))
    
    print(f"✅ 확장된 스키마 추출 완료 → {final_path}")
    print(f"📊 확장된 노드 타입: {node_count}개")
    print(f"📊 확장된 관계 타입: {relation_count}개")
    
    # 관계 타입별 분류 출력
    relation_types = [rel['relationship'] for rel in refined.get('relations', [])]
    from collections import Counter
    relation_stats = Counter(relation_types)
    
    print("📈 관계 타입 분포:")
    for rel_type, count in relation_stats.most_common(10):
        print(f"   {rel_type}: {count}")

def main(purpose="종합 뉴스 분석"):
    extract_enhanced_schema_mp(max_workers=min(4, os.cpu_count() or 2), purpose=purpose)

if __name__ == "__main__":
    main()