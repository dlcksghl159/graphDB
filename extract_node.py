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

# 환경 변수 로드
load_dotenv()
OUTPUT_ROOT = os.getenv("OUTPUT_ROOT", "output")
PURPOSE = os.getenv("PURPOSE", "문서 분석")

# 하드코딩된 동의어 사전과 패턴 제거
# 대신 동적으로 관리되는 일반적인 접근 방식 사용

class GeneralEntityTracker:
    """도메인 독립적인 엔티티 추적기"""
    def __init__(self):
        self.entities = {}  # fingerprint -> entity
        self.name_to_fingerprints = {}  # normalized_name -> set of fingerprints
        self.aliases = {}  # fingerprint -> set of aliases
        self.entity_contexts = {}  # fingerprint -> list of contexts
        
    def normalize_entity_name(self, name: str, entity_type: str) -> str:
        """기본적인 정규화만 수행 (도메인 특화 로직 제거)"""
        # 기본 정규화: 공백 정리, 대소문자 통일
        normalized = name.strip()
        
        # 특수문자 제거 (기본적인 것만)
        normalized = re.sub(r'\s+', ' ', normalized)
        normalized = re.sub(r'[^\w\s\-\.]', '', normalized)
        
        return normalized
    
    def generate_entity_fingerprint(self, entity: Dict) -> str:
        """엔티티의 고유 지문 생성"""
        normalized_name = self.normalize_entity_name(entity['name'], entity['label'])
        # 타입과 정규화된 이름으로 지문 생성
        fingerprint_str = f"{entity['label']}:{normalized_name}".lower()
        return hashlib.md5(fingerprint_str.encode()).hexdigest()
    
    def add_entity(self, entity: Dict, context: str = "") -> Tuple[bool, str]:
        """엔티티 추가 및 중복 검사"""
        fingerprint = self.generate_entity_fingerprint(entity)
        
        if fingerprint in self.entities:
            # 기존 엔티티 업데이트
            existing = self.entities[fingerprint]
            
            # 속성 병합
            if 'properties' not in existing:
                existing['properties'] = {}
            for key, value in entity.get('properties', {}).items():
                if key not in existing['properties']:
                    existing['properties'][key] = value
            
            # 컨텍스트 추가
            if fingerprint in self.entity_contexts:
                self.entity_contexts[fingerprint].append(context[:200])
            
            # 별칭 추가
            if fingerprint not in self.aliases:
                self.aliases[fingerprint] = set()
            self.aliases[fingerprint].add(entity['name'])
            
            return False, fingerprint
        
        # 새 엔티티 추가
        normalized_name = self.normalize_entity_name(entity['name'], entity['label'])
        entity['name'] = normalized_name
        self.entities[fingerprint] = entity
        
        # 별칭 초기화
        self.aliases[fingerprint] = {entity['name']}
        
        # 컨텍스트 저장
        self.entity_contexts[fingerprint] = [context[:200]]
        
        # 이름 인덱스 업데이트
        name_lower = normalized_name.lower()
        if name_lower not in self.name_to_fingerprints:
            self.name_to_fingerprints[name_lower] = set()
        self.name_to_fingerprints[name_lower].add(fingerprint)
        
        return True, fingerprint
    
    def find_similar_entities(self, entity: Dict, threshold: float = 0.8) -> List[str]:
        """유사한 엔티티 찾기 (도메인 독립적)"""
        from difflib import SequenceMatcher
        
        similar_fingerprints = []
        entity_name_lower = entity['name'].lower()
        
        for existing_fp, existing_entity in self.entities.items():
            # 같은 타입의 엔티티만 비교
            if existing_entity['label'] != entity['label']:
                continue
            
            existing_name_lower = existing_entity['name'].lower()
            
            # 문자열 유사도 계산
            similarity = SequenceMatcher(None, entity_name_lower, existing_name_lower).ratio()
            
            if similarity > threshold:
                similar_fingerprints.append((existing_fp, similarity))
        
        # 유사도 순으로 정렬
        similar_fingerprints.sort(key=lambda x: x[1], reverse=True)
        return [fp for fp, _ in similar_fingerprints]
    
    def get_all_entities(self) -> List[Dict]:
        """모든 엔티티 반환 (별칭 정보 포함)"""
        result = []
        for fingerprint, entity in self.entities.items():
            entity_copy = entity.copy()
            if 'properties' not in entity_copy:
                entity_copy['properties'] = {}
            
            # 별칭 추가
            if fingerprint in self.aliases and len(self.aliases[fingerprint]) > 1:
                entity_copy['properties']['aliases'] = list(self.aliases[fingerprint])
            
            # 컨텍스트 수 추가 (디버깅용)
            if fingerprint in self.entity_contexts:
                entity_copy['properties']['mention_count'] = len(self.entity_contexts[fingerprint])
            
            result.append(entity_copy)
        return result

# 전역 추적기
entity_tracker = GeneralEntityTracker()

def extract_entities_with_context(text: str, schema: Dict) -> List[Dict]:
    """텍스트에서 스키마 기반으로 엔티티 추출 (도메인 독립적)"""
    entities = []
    
    # 스키마에서 노드 타입 추출
    node_types = [node['label'] for node in schema.get('nodes', [])]
    
    # 기본 패턴: 대문자로 시작하는 단어들 (고유명사 가능성)
    proper_noun_pattern = r'\b[A-Z][a-z]+(?:\s+[A-Z][a-z]+)*\b'
    
    # 숫자 포함 패턴 (버전, 모델명 등)
    alphanumeric_pattern = r'\b[A-Z][A-Za-z0-9\-\.]+\b'
    
    # 인용부호 내 텍스트
    quoted_pattern = r'["\'](.*?)["\']'
    
    # 괄호 내 약어
    acronym_pattern = r'\(([A-Z]{2,})\)'
    
    # 모든 패턴으로 후보 추출
    candidates = set()
    
    for pattern in [proper_noun_pattern, alphanumeric_pattern]:
        matches = re.finditer(pattern, text)
        for match in matches:
            candidate = match.group().strip()
            if len(candidate) > 2:  # 너무 짧은 것 제외
                candidates.add(candidate)
    
    # 인용부호 내 텍스트
    quoted_matches = re.finditer(quoted_pattern, text)
    for match in quoted_matches:
        candidate = match.group(1).strip()
        if len(candidate) > 2 and len(candidate) < 100:
            candidates.add(candidate)
    
    # 약어
    acronym_matches = re.finditer(acronym_pattern, text)
    for match in acronym_matches:
        candidates.add(match.group(1))
    
    # 후보를 엔티티로 변환 (타입은 나중에 LLM이 결정)
    for candidate in candidates:
        entities.append({
            "name": candidate,
            "label": "ENTITY",  # 기본 레이블
            "properties": {}
        })
    
    return entities

def process_file_general(idx, filename, chunks_dir, result_dir, schema_json, api_key, system_msg, purpose):
    """일반화된 파일별 노드 추출"""
    client = openai.OpenAI(api_key=api_key)
    filename_path = os.path.join(chunks_dir, filename)
    
    if not os.path.exists(filename_path):
        print(f"파일 없음: {filename_path} → 건너뜀")
        return None
    
    with open(filename_path, "r", encoding="utf-8") as f:
        content = f.read()
    
    # 패턴 기반 후보 추출
    pattern_candidates = extract_entities_with_context(content, schema_json)
    
    # 기존 엔티티 목록 (일관성 유지용)
    existing_entities = entity_tracker.get_all_entities()
    existing_names_str = ""
    if existing_entities:
        sample_entities = existing_entities[:30]  # 샘플만 표시
        existing_names_str = f"""
### 이미 추출된 엔티티 예시 (일관성 참고):
{json.dumps(sample_entities, ensure_ascii=False, indent=2)}
"""
    
    prompt = f"""당신은 **'{purpose}'** 목적의 지식 그래프를 위한 엔티티(노드)를 추출하는 전문가입니다.

### 스키마:
{json.dumps(schema_json, ensure_ascii=False, indent=2)}

### 지침:
1. **도메인 독립적 추출**: 어떤 종류의 문서든 처리할 수 있도록 일반적인 접근
2. **스키마 준수**: 제공된 스키마의 노드 타입만 사용
3. **완전한 추출**: 모든 중요한 개체 포착
   - 고유명사, 개념, 용어, 약어 등
   - 문맥상 중요한 모든 개체
4. **일관성 유지**: 같은 개체는 같은 이름으로
5. **속성 추가**: 가능한 한 많은 관련 정보를 properties에 포함

### 패턴 기반 후보 (참고용):
{json.dumps(pattern_candidates[:20], ensure_ascii=False, indent=2)}

{existing_names_str}

### 텍스트:
{content}

### 출력 (JSON):
{{
  "nodes": [
    {{
      "label": "스키마에_정의된_타입",
      "name": "엔티티_이름", 
      "properties": {{
        "추가_속성": "값"
      }}
    }}
  ]
}}"""

    print(f"[{idx}] {filename} 처리 중...")
    
    response = client.chat.completions.create(
        model="gpt-4.1",
        response_format={"type": "json_object"},
        messages=[
            {"role": "system", "content": system_msg},
            {"role": "user", "content": prompt}
        ],
        temperature=0.2
    )
    
    gpt_output = response.choices[0].message.content
    parsed_json = parse_json(gpt_output)
    
    # 추출된 노드 처리
    new_nodes = []
    for node in parsed_json.get('nodes', []):
        is_new, fingerprint = entity_tracker.add_entity(node, content[:500])
        if is_new:
            new_nodes.append(node)
    
    result = {
        'nodes': new_nodes,
        'relations': []  # 관계는 별도 단계에서 추출
    }
    
    # 개별 결과 저장
    result_path = os.path.join(result_dir, f'result_{idx}.json')
    with open(result_path, "w", encoding="utf-8") as f:
        json.dump(result, f, ensure_ascii=False, indent=4)
    
    print(f"[{idx}] 노드 추출 완료 - 신규: {len(new_nodes)}개")
    return result_path, result

def main(purpose="문서 분석"):
    """메인 실행 함수"""
    OUTPUT_ROOT = os.getenv("OUTPUT_ROOT", "output")
    result_dir = os.path.join(OUTPUT_ROOT, "result")
    chunks_dir = os.path.join(OUTPUT_ROOT, "chunked_document")
    schema_dir = os.path.join(OUTPUT_ROOT, "schema")
    os.makedirs(result_dir, exist_ok=True)
    
    # 스키마 로드
    schema_path = os.path.join(schema_dir, "schema.json")
    if not os.path.exists(schema_path):
        print(f"⚠️ 스키마 파일이 없습니다: {schema_path}")
        print("먼저 extract_schema.py를 실행하세요.")
        return
    
    with open(schema_path, "r", encoding="utf-8") as f:
        schema_json = json.load(f)
    
    load_dotenv()
    api_key = os.getenv("OPENAI_API_KEY")
    
    system_msg = f"""당신은 다양한 도메인의 문서에서 엔티티를 정확하게 추출하는 전문가입니다.
특정 도메인에 편향되지 않고, 제공된 스키마에 따라 일관성 있게 엔티티를 추출합니다.
반드시 유효한 JSON 형식으로만 응답하세요."""
    
    file_list = sorted([f for f in os.listdir(chunks_dir) if f.endswith('.txt')])
    n_files = len(file_list)
    
    if n_files == 0:
        print("⚠️ 처리할 청크 파일이 없습니다.")
        return
    
    # 배치 처리
    chunk_size = 10
    pbar = tqdm(range(0, n_files, chunk_size), desc="Processing batches", unit="batch")
    
    for start_idx in pbar:
        batch_files = file_list[start_idx:start_idx+chunk_size]
        
        with ThreadPoolExecutor(max_workers=min(chunk_size, 5)) as executor:
            futures = []
            for i, filename in enumerate(batch_files):
                idx = start_idx + i
                future = executor.submit(
                    process_file_general, idx, filename, chunks_dir, result_dir, 
                    schema_json, api_key, system_msg, purpose
                )
                futures.append(future)
            
            for future in as_completed(futures):
                try:
                    future.result()
                except Exception as e:
                    print(f"오류 발생: {e}")
    
    # 최종 결과 생성
    final_result = {
        'nodes': entity_tracker.get_all_entities(),
        'relations': []
    }
    
    # 최종 저장
    result_path = os.path.join(result_dir, "result.json")
    with open(result_path, "w", encoding="utf-8") as f:
        json.dump(final_result, f, ensure_ascii=False, indent=4)
    
    # 통계 출력
    print(f"✅ 노드 추출 완료: {result_path}")
    print(f"📊 총 노드: {len(final_result['nodes'])}개")
    
    # 타입별 분포
    from collections import Counter
    type_counter = Counter(node['label'] for node in final_result['nodes'])
    print("\n📈 노드 타입 분포:")
    for node_type, count in type_counter.most_common():
        print(f"   {node_type}: {count}개")

if __name__ == "__main__":
    main(purpose="문서 분석")