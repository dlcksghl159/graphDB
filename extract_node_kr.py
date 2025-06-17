import os
import json
import openai
import re
from tqdm import tqdm
from util import merge_json, parse_json
from dotenv import load_dotenv
from concurrent.futures import ThreadPoolExecutor, as_completed
from typing import Dict, List, Set, Tuple
import hashlib

# 확장된 동의어 사전 (PDF 제안사항 반영)
ENHANCED_SYNONYM_DICT = {
    # 회사명 정규화 (기존 + 확장)
    "google": ["구글", "Google", "GOOGLE", "구글코리아", "Google Korea", "구글리", "구굴"],
    "samsung": ["삼성", "Samsung", "SAMSUNG", "삼성전자", "Samsung Electronics", "삼성그룹"],
    "naver": ["네이버", "Naver", "NAVER", "네이버클라우드", "Naver Cloud", "NHN"],
    "kakao": ["카카오", "Kakao", "KAKAO", "카카오톡", "KakaoTalk", "카카오뱅크"],
    "apple": ["애플", "Apple", "APPLE", "애플코리아"],
    "microsoft": ["마이크로소프트", "Microsoft", "MS", "엠에스"],
    "meta": ["메타", "Meta", "페이스북", "Facebook"],
    "tesla": ["테슬라", "Tesla", "TESLA"],
    "lg": ["LG", "엘지", "엘지전자", "LG전자"],
    
    # 위치명 정규화 (확장)
    "미국": ["USA", "U.S.", "United States", "미합중국", "아메리카"],
    "중국": ["China", "PRC", "중화인민공화국"],
    "일본": ["Japan", "JP", "재팬"],
    "영국": ["UK", "United Kingdom", "England", "잉글랜드"],
    "한국": ["Korea", "South Korea", "대한민국", "ROK"],
    
    # 기술 용어
    "ai": ["AI", "인공지능", "Artificial Intelligence"],
    "iot": ["IoT", "사물인터넷", "Internet of Things"]
}

# 역방향 매핑 생성 (대소문자 무시)
REVERSE_SYNONYM = {}
for canonical, synonyms in ENHANCED_SYNONYM_DICT.items():
    for syn in synonyms:
        REVERSE_SYNONYM[syn.lower()] = canonical

# 한국어 이름 패턴 (개선된 정규식)
KOREAN_NAME_PATTERNS = [
    r'[가-힣]{2,4}(?:\s+[가-힣]{1,2})*',  # 일반 한국어 이름
    r'[가-힣]+\s*(?:회장|사장|대표|부사장|이사|팀장|과장|부장|실장|센터장)',  # 직책 포함
]

def enhanced_normalize_entity_name(name: str, entity_type: str, context: str = "") -> str:
    """향상된 엔티티 이름 정규화 (PDF 제안사항 반영)"""
    name = name.strip()
    
    # 회사/조직명의 경우 동의어 처리
    if entity_type in ["COMPANY", "ORGANIZATION"]:
        normalized = REVERSE_SYNONYM.get(name.lower())
        if normalized:
            return normalized.capitalize()
        
        # 컨텍스트 기반 정규화 (예: "삼성"이 전자제품 맥락에서 나오면 "삼성전자"로)
        if "삼성" in name and any(tech in context for tech in ["전자", "스마트폰", "반도체", "디스플레이"]):
            return "삼성전자"
    
    # 인물명의 경우 공백 정규화 및 직책 분리
    if entity_type == "PERSON":
        # 한글 이름의 경우 띄어쓰기 제거
        if re.match(r'^[가-힣\s]+$', name):
            # 직책 분리
            for pattern in ["회장", "사장", "대표", "부사장", "이사", "팀장", "과장", "부장", "실장"]:
                if pattern in name:
                    clean_name = name.replace(pattern, "").strip()
                    return clean_name
            return name.replace(' ', '')
    
    # 위치명의 경우 표준화
    if entity_type in ["LOCATION", "COUNTRY"]:
        normalized = REVERSE_SYNONYM.get(name.lower())
        if normalized:
            return normalized
    
    return name

def extract_with_ner_fallback(text: str, existing_entities: Set[str]) -> List[Dict]:
    """NER 기반 폴백 엔티티 추출 (PDF 제안사항)"""
    additional_entities = []
    
    # 한국어 이름 패턴 매칭
    for pattern in KOREAN_NAME_PATTERNS:
        matches = re.finditer(pattern, text)
        for match in matches:
            candidate = match.group().strip()
            # 기존 엔티티와 중복 확인
            if candidate not in existing_entities and len(candidate) >= 2:
                # 직책이 포함된 경우 PERSON으로 분류
                if any(title in candidate for title in ["회장", "사장", "대표", "부사장", "이사"]):
                    role = None
                    for title in ["회장", "사장", "대표", "부사장", "이사"]:
                        if title in candidate:
                            role = title
                            break
                    clean_name = candidate.replace(role or "", "").strip()
                    additional_entities.append({
                        "label": "PERSON",
                        "name": clean_name,
                        "properties": {"role": role} if role else {}
                    })
    
    # 대문자 영어 단어 (회사명 후보)
    english_company_pattern = r'\b[A-Z][A-Za-z]+(?:\s+[A-Z][A-Za-z]+)*\b'
    matches = re.finditer(english_company_pattern, text)
    for match in matches:
        candidate = match.group().strip()
        if candidate not in existing_entities and len(candidate) >= 3:
            # 일반적인 영어 단어는 제외
            common_words = {'THE', 'AND', 'OR', 'BUT', 'FOR', 'WITH', 'THIS', 'THAT'}
            if candidate.upper() not in common_words:
                additional_entities.append({
                    "label": "COMPANY",
                    "name": candidate,
                    "properties": {}
                })
    
    return additional_entities

class EnhancedEntityTracker:
    """향상된 엔티티 추적기 (별칭 지원)"""
    def __init__(self):
        self.entities = {}  # fingerprint -> entity
        self.name_to_fingerprints = {}  # name -> set of fingerprints
        self.aliases = {}  # fingerprint -> set of aliases
        
    def add_entity(self, entity: Dict, context: str = "") -> bool:
        """엔티티 추가 (별칭 정보 포함)"""
        original_name = entity['name']
        fingerprint = self.generate_entity_fingerprint(entity, context)
        
        if fingerprint in self.entities:
            # 기존 엔티티의 속성 업데이트 및 별칭 추가
            existing = self.entities[fingerprint]
            for key, value in entity.get('properties', {}).items():
                if key not in existing.get('properties', {}):
                    existing['properties'][key] = value
            
            # 별칭 추가
            if fingerprint not in self.aliases:
                self.aliases[fingerprint] = set()
            self.aliases[fingerprint].add(original_name)
            return False
        
        # 정규화된 이름으로 저장
        entity['name'] = enhanced_normalize_entity_name(entity['name'], entity['label'], context)
        self.entities[fingerprint] = entity
        
        # 별칭 초기화
        if fingerprint not in self.aliases:
            self.aliases[fingerprint] = set()
        self.aliases[fingerprint].add(original_name)
        if original_name != entity['name']:
            self.aliases[fingerprint].add(entity['name'])
        
        # 이름별 인덱스 업데이트
        name_lower = entity['name'].lower()
        if name_lower not in self.name_to_fingerprints:
            self.name_to_fingerprints[name_lower] = set()
        self.name_to_fingerprints[name_lower].add(fingerprint)
        
        return True
    
    def generate_entity_fingerprint(self, entity: Dict, context: str = "") -> str:
        """엔티티의 고유 지문 생성 (컨텍스트 고려)"""
        normalized_name = enhanced_normalize_entity_name(entity['name'], entity['label'], context)
        fingerprint = f"{entity['label']}:{normalized_name}".lower()
        return hashlib.md5(fingerprint.encode()).hexdigest()
    
    def get_all_entities(self) -> List[Dict]:
        """모든 엔티티를 별칭 정보와 함께 반환"""
        result = []
        for fingerprint, entity in self.entities.items():
            if fingerprint in self.aliases:
                entity['properties']['aliases'] = list(self.aliases[fingerprint])
            result.append(entity)
        return result

# 전역 추적기
enhanced_entity_tracker = EnhancedEntityTracker()

def enhanced_process_file(idx, filename, chunks_dir, result_dir, schema_json, api_key, system_msg, purpose, existing_names):
    """향상된 파일별 노드 추출 (Few-shot 예시 포함)"""
    client = openai.OpenAI(api_key=api_key)
    filename_path = os.path.join(chunks_dir, filename)
    
    if not os.path.exists(filename_path):
        print(f"파일 없음: {filename_path} → 건너뜀")
        return None
    
    with open(filename_path, "r", encoding="utf-8") as f:
        content = f.read()
    
    # Few-shot 예시 추가 (PDF 제안사항)
    few_shot_example = """
### 예시:
입력 텍스트: "삼성전자의 이재용 회장이 미국 실리콘밸리에 있는 구글 본사를 방문하여 AI 기술 협력에 대해 논의했다."
출력:
{
  "nodes": [
    {"label": "PERSON", "name": "이재용", "properties": {"role": "회장"}},
    {"label": "COMPANY", "name": "삼성전자", "properties": {"industry": "전자"}},
    {"label": "LOCATION", "name": "실리콘밸리", "properties": {"country": "미국"}},
    {"label": "COMPANY", "name": "구글", "properties": {"industry": "기술"}},
    {"label": "CONCEPT", "name": "AI기술협력", "properties": {"type": "기술협력"}}
  ],
  "relations": [
    {"start_node": "이재용", "relationship": "WORKS_FOR", "end_node": "삼성전자", "properties": {"position": "회장"}},
    {"start_node": "구글", "relationship": "LOCATED_IN", "end_node": "실리콘밸리", "properties": {}},
    {"start_node": "이재용", "relationship": "VISITED", "end_node": "구글", "properties": {"purpose": "AI기술협력논의"}}
  ]
}
"""
    
    existing_names_str = ""
    if existing_names:
        existing_names_str = f"""
### 이미 추출된 엔티티 (일관성 유지):
{', '.join(sorted(existing_names)[:50])}
"""
    
    prompt = f"""당신은 한국어 뉴스 기사에서 **'{purpose}'** 목적의 지식 그래프를 위한 고품질 노드와 관계를 추출하는 전문가입니다.

### 스키마:
{json.dumps(schema_json, ensure_ascii=False, indent=2)}

{few_shot_example}

### 핵심 지침:
1. **엔티티 통합**: 동일 개체의 다른 표현을 인식하고 통일
   - "구글"과 "Google" → "구글"로 통일
   - "삼성"과 "삼성전자" → 문맥상 같으면 "삼성전자"

2. **완전한 추출**: 모든 중요한 엔티티 포착
   - 대명사 참조 해결 ("그", "그녀", "이 회사" 등)
   - 문맥상 언급된 모든 인물, 회사, 장소, 이벤트

3. **관계 추출**: 명시적/암시적 관계 모두 포함
   - 직접적 관계: "A가 B에서 일한다"
   - 암시적 관계: "A 회장" → A WORKS_FOR [회사]

4. **속성 풍부화**: 가능한 한 많은 컨텍스트 정보 포함
   - 직책, 위치, 날짜, 역할 등

{existing_names_str}

### 텍스트:
{content}

### 출력 (JSON):"""

    print(f"[{idx}] {filename} 처리 중...")
    
    response = client.chat.completions.create(
        model="gpt-4o",  # 더 강력한 모델 사용 (PDF 제안)
        response_format={"type": "json_object"},
        messages=[
            {"role": "system", "content": system_msg},
            {"role": "user", "content": prompt}
        ],
        temperature=0.1  # 더 일관된 출력을 위해 낮춤
    )
    
    gpt_output = response.choices[0].message.content
    parsed_json = parse_json(gpt_output)
    
    # LLM 추출 결과
    llm_entities = set()
    normalized_nodes = []
    for node in parsed_json.get('nodes', []):
        node['name'] = enhanced_normalize_entity_name(node['name'], node['label'], content)
        if enhanced_entity_tracker.add_entity(node, content):
            normalized_nodes.append(node)
        llm_entities.add(node['name'])
    
    # NER 폴백으로 추가 엔티티 추출 (PDF 제안사항)
    additional_entities = extract_with_ner_fallback(content, llm_entities)
    for entity in additional_entities:
        entity['name'] = enhanced_normalize_entity_name(entity['name'], entity['label'], content)
        if enhanced_entity_tracker.add_entity(entity, content):
            normalized_nodes.append(entity)
    
    # 관계 정규화
    normalized_relations = []
    for rel in parsed_json.get('relations', []):
        # 관계 타입 표준화
        rel_type = rel['relationship']
        if rel_type in ['EMPLOYED_BY', 'WORKS_AT']:
            rel_type = 'WORKS_FOR'
        elif rel_type in ['HEADQUARTERED_IN', 'BASED_IN']:
            rel_type = 'LOCATED_IN'
        
        rel['relationship'] = rel_type
        normalized_relations.append(rel)
    
    result = {
        'nodes': normalized_nodes,
        'relations': normalized_relations
    }
    
    # 개별 결과 저장
    result_path = os.path.join(result_dir, f'result_{idx}.json')
    with open(result_path, "w", encoding="utf-8") as f:
        json.dump(result, f, ensure_ascii=False, indent=4)
    
    print(f"[{idx}] 노드 추출 완료 - 신규 노드: {len(normalized_nodes)}개 (LLM: {len(parsed_json.get('nodes', []))}, NER: {len(additional_entities)})")
    return result_path, result

def main(purpose="뉴스 기사 분석"):
    """메인 실행 함수"""
    OUTPUT_ROOT = os.getenv("OUTPUT_ROOT", "output")
    result_dir = os.path.join(OUTPUT_ROOT, "result")
    chunks_dir = os.path.join(OUTPUT_ROOT, "chunked_document")
    schema_dir = os.path.join(OUTPUT_ROOT, "schema")
    os.makedirs(result_dir, exist_ok=True)
    
    # 스키마 로드
    with open(f"{schema_dir}/schema.json", "r", encoding="utf-8") as f:
        schema_json = json.load(f)
    
    load_dotenv()
    api_key = os.getenv("OPENAI_API_KEY")
    
    system_msg = """당신은 한국어 뉴스 기사에서 엔티티와 관계를 정확하고 완전하게 추출하는 전문가입니다.
동일한 개체의 다른 표현을 인식하고 일관된 이름으로 통일합니다.
암시적 관계와 대명사 참조도 해결합니다.
반드시 유효한 JSON 형식으로만 응답하세요."""
    
    file_list = sorted(os.listdir(chunks_dir))
    n_files = len(file_list)
    
    # 배치 처리로 일관성 향상
    chunk_size = 3  # 더 작은 배치로 일관성 확보
    pbar = tqdm(range(0, n_files, chunk_size), desc="Processing batches", unit="batch")
    
    for start_idx in pbar:
        batch_files = file_list[start_idx:start_idx+chunk_size]
        existing_names = {entity['name'] for entity in enhanced_entity_tracker.get_all_entities()}
        
        with ThreadPoolExecutor(max_workers=chunk_size) as executor:
            futures = []
            for i, filename in enumerate(batch_files):
                idx = start_idx + i
                future = executor.submit(
                    enhanced_process_file, idx, filename, chunks_dir, result_dir, 
                    schema_json, api_key, system_msg, purpose, existing_names
                )
                futures.append(future)
            
            for future in as_completed(futures):
                future.result()
    
    # 최종 결과 생성 (별칭 정보 포함)
    final_result = {
        'nodes': enhanced_entity_tracker.get_all_entities(),
        'relations': []
    }
    
    # 모든 관계 수집
    for idx in range(n_files):
        path = os.path.join(result_dir, f"result_{idx}.json")
        if os.path.exists(path):
            with open(path, "r", encoding="utf-8") as f:
                data = json.load(f)
                final_result['relations'].extend(data.get('relations', []))
    
    # 최종 저장
    result_path = os.path.join(result_dir, "result.json")
    with open(result_path, "w", encoding="utf-8") as f:
        json.dump(final_result, f, ensure_ascii=False, indent=4)
    
    print(f"✅ 향상된 노드 추출 완료: {result_path}")
    print(f"📊 총 노드: {len(final_result['nodes'])}개")
    print(f"📊 총 관계: {len(final_result['relations'])}개")
    print(f"📊 별칭 정보가 포함된 노드: {sum(1 for n in final_result['nodes'] if 'aliases' in n.get('properties', {}))}")

if __name__ == "__main__":
    main(purpose="뉴스 기사 분석")