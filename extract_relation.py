import os
import json
import openai
from util import merge_json, parse_json
from dotenv import load_dotenv
from deduplication import deduplicate
from tqdm import tqdm
from concurrent.futures import ThreadPoolExecutor, as_completed
from typing import Dict, List, Tuple, Set
from collections import defaultdict

# 환경 변수 로드
load_dotenv()
OUTPUT_ROOT = os.getenv("OUTPUT_ROOT", "output")
PURPOSE = os.getenv("PURPOSE", "문서 분석")

# 하드코딩된 관계 패턴 제거 - 대신 동적으로 발견

def discover_relation_patterns(text: str, entities: List[Dict]) -> List[Dict]:
    """텍스트에서 엔티티 간의 잠재적 관계 패턴 발견"""
    patterns = []
    entity_names = {entity['name'] for entity in entities}
    
    # 엔티티 쌍 사이의 텍스트 분석
    sentences = text.split('.')
    for sentence in sentences:
        found_entities = []
        for entity_name in entity_names:
            if entity_name in sentence:
                found_entities.append(entity_name)
        
        # 같은 문장에 2개 이상의 엔티티가 있으면 관계 가능성
        if len(found_entities) >= 2:
            patterns.append({
                "sentence": sentence.strip(),
                "entities": found_entities,
                "potential_relation": True
            })
    
    return patterns

def infer_relation_type(sentence: str, entity1: str, entity2: str) -> Tuple[str, float]:
    """문장에서 두 엔티티 간의 관계 타입 추론"""
    sentence_lower = sentence.lower()
    entity1_lower = entity1.lower()
    entity2_lower = entity2.lower()
    
    # 동사 기반 관계 추론 (언어 독립적)
    # 기본적인 관계 패턴만 정의
    basic_patterns = {
        # 연결/포함 관계
        'contains': ['contains', 'includes', 'has', 'comprises', 'consists of', '포함', '구성'],
        'part_of': ['part of', 'belongs to', 'member of', 'in', '속한', '일부'],
        'related_to': ['related to', 'associated with', 'connected to', '관련', '연관'],
        
        # 동작 관계
        'uses': ['uses', 'utilizes', 'employs', 'applies', '사용', '활용'],
        'creates': ['creates', 'produces', 'generates', 'makes', '생성', '만들다'],
        'affects': ['affects', 'influences', 'impacts', '영향', '작용'],
        
        # 위치 관계
        'located_in': ['located in', 'found in', 'situated in', '위치', '있다'],
        
        # 시간 관계
        'precedes': ['before', 'precedes', 'prior to', '이전', '앞서'],
        'follows': ['after', 'follows', 'subsequent to', '이후', '따라'],
    }
    
    # 패턴 매칭
    for rel_type, patterns in basic_patterns.items():
        for pattern in patterns:
            if pattern in sentence_lower:
                # 엔티티 순서 확인
                idx1 = sentence_lower.find(entity1_lower)
                idx2 = sentence_lower.find(entity2_lower)
                if idx1 < idx2:  # entity1이 먼저 나오면
                    return rel_type.upper(), 0.7
                else:  # 순서가 반대면 관계도 반대일 수 있음
                    return f"INVERSE_{rel_type.upper()}", 0.7
    
    # 패턴이 없으면 일반적인 관계
    return "RELATED_TO", 0.5

def extract_relations_general(text: str, nodes: List[Dict], schema_relations: List[Dict]) -> List[Dict]:
    """일반적인 방법으로 관계 추출"""
    extracted_relations = []
    
    # 노드 이름과 타입 매핑
    node_map = {node['name']: node for node in nodes}
    
    # 스키마에서 가능한 관계 타입 추출
    valid_relation_types = {rel['relationship'] for rel in schema_relations}
    
    # 문장 단위로 분석
    sentences = text.split('.')
    
    for sentence in sentences:
        sentence = sentence.strip()
        if not sentence:
            continue
        
        # 문장에 포함된 엔티티 찾기
        found_entities = []
        for node in nodes:
            if node['name'] in sentence:
                found_entities.append(node)
        
        # 2개 이상의 엔티티가 있으면 관계 추출 시도
        if len(found_entities) >= 2:
            # 모든 엔티티 쌍에 대해 관계 검사
            for i in range(len(found_entities)):
                for j in range(i + 1, len(found_entities)):
                    entity1 = found_entities[i]
                    entity2 = found_entities[j]
                    
                    # 관계 타입 추론
                    rel_type, confidence = infer_relation_type(sentence, entity1['name'], entity2['name'])
                    
                    # 스키마에 있는 관계 타입과 매칭
                    if rel_type in valid_relation_types:
                        final_rel_type = rel_type
                    else:
                        # 가장 유사한 스키마 관계 타입 찾기
                        final_rel_type = find_closest_schema_relation(rel_type, valid_relation_types)
                    
                    extracted_relations.append({
                        "start_node": entity1['name'],
                        "relationship": final_rel_type,
                        "end_node": entity2['name'],
                        "properties": {
                            "confidence": confidence,
                            "evidence": sentence[:200]
                        }
                    })
    
    return extracted_relations

def find_closest_schema_relation(rel_type: str, valid_types: Set[str]) -> str:
    """스키마에 정의된 관계 타입 중 가장 유사한 것 찾기"""
    # 간단한 문자열 유사도 기반 매칭
    from difflib import get_close_matches
    
    matches = get_close_matches(rel_type, valid_types, n=1, cutoff=0.5)
    if matches:
        return matches[0]
    
    # 기본값
    return "RELATED_TO" if "RELATED_TO" in valid_types else list(valid_types)[0]

def process_file_general_relations(filename, chunks_dir, result_dir, system_msg, nodes, api_key, schema_relations):
    """일반화된 파일별 관계 추출"""
    client = openai.OpenAI(api_key=api_key)
    i = int(filename.split('_')[-1].split('.')[0])
    
    filename_path = os.path.join(chunks_dir, filename)
    if not os.path.exists(filename_path):
        print(f"파일 없음: {filename_path} → 종료합니다.")
        return
    
    with open(filename_path, "r", encoding="utf-8") as f:
        content = f.read()

    # 패턴 기반 관계 추출
    pattern_relations = extract_relations_general(content, nodes, schema_relations)
    
    # LLM 기반 관계 추출
    prompt = f"""주어진 텍스트에서 엔티티 간의 모든 의미 있는 관계를 추출하세요.

### 스키마의 관계 타입:
{json.dumps(schema_relations, ensure_ascii=False, indent=2)}

### 지침:
1. 제공된 노드를 정확히 사용하세요 (이름 수정 금지)
2. 스키마에 정의된 관계 타입을 우선 사용하세요
3. 새로운 관계 타입이 필요하면 UPPER_SNAKE_CASE로 작성
4. 도메인에 관계없이 일반적인 관계를 추출하세요:
   - 포함/구성 관계 (CONTAINS, PART_OF)
   - 연관 관계 (RELATED_TO, ASSOCIATED_WITH)
   - 의존 관계 (DEPENDS_ON, REQUIRES)
   - 순서 관계 (PRECEDES, FOLLOWS)
   - 기타 문맥상 중요한 관계
5. properties에는 관계의 근거, 강도, 날짜 등 추가 정보 포함

### 패턴 기반 추출 결과 (참고):
{json.dumps(pattern_relations[:5], ensure_ascii=False, indent=2)}

### 텍스트:
{content}

### 엔티티(노드):
{json.dumps(nodes, ensure_ascii=False, indent=2)}

### 출력 형식 (JSON):
{{
    "nodes": {json.dumps(nodes, ensure_ascii=False)},
    "relations": [
        {{
            "start_node": "<정확한엔티티이름>",
            "relationship": "<RELATION_TYPE>",
            "end_node": "<정확한엔티티이름>",
            "properties": {{
                "confidence": "high|medium|low",
                "evidence": "<근거 문장 일부>"
            }}
        }}
    ]
}}"""

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
    llm_result = parse_json(gpt_output)
    
    # 결과 병합 (중복 제거)
    all_relations = pattern_relations + llm_result.get('relations', [])
    
    seen_relations = set()
    unique_relations = []
    
    for rel in all_relations:
        rel_key = (rel['start_node'], rel['relationship'], rel['end_node'])
        if rel_key not in seen_relations:
            seen_relations.add(rel_key)
            unique_relations.append(rel)
    
    final_result = {
        "nodes": nodes,
        "relations": unique_relations
    }
    
    # 개별 결과 저장
    result_path = os.path.join(result_dir, f'result_enhanced_{i}.json')
    with open(result_path, "w", encoding="utf-8") as f:
        json.dump(final_result, f, ensure_ascii=False, indent=4)
    
    print(f"[{i}] 관계 추출 완료 - 총 {len(unique_relations)}개")

def cross_document_relation_discovery(all_nodes: List[Dict], all_relations: List[Dict], api_key: str) -> List[Dict]:
    """문서 전체에서 추가 관계 발견 (선택적)"""
    client = openai.OpenAI(api_key=api_key)
    
    # 노드를 타입별로 그룹화
    nodes_by_type = defaultdict(list)
    for node in all_nodes:
        nodes_by_type[node['label']].append(node['name'])
    
    # 타입 간 가능한 관계 추론
    prompt = f"""다음 엔티티들 간의 추가적인 관계를 추론하세요.

### 엔티티 타입별 목록:
{json.dumps(dict(nodes_by_type), ensure_ascii=False, indent=2)}

### 이미 발견된 관계 패턴:
{json.dumps(all_relations[:10], ensure_ascii=False, indent=2)}

### 지침:
1. 논리적으로 타당한 관계만 추론하세요
2. 너무 일반적이거나 자명한 관계는 제외하세요
3. 도메인 지식을 활용하여 의미있는 관계를 찾으세요

### 출력 (JSON):
{{
    "relations": [
        {{
            "start_node": "<엔티티명>",
            "relationship": "<관계타입>",
            "end_node": "<엔티티명>",
            "properties": {{
                "inferred": true,
                "reasoning": "<추론 근거>"
            }}
        }}
    ]
}}"""

    try:
        response = client.chat.completions.create(
            model="gpt-4o-mini",
            response_format={"type": "json_object"},
            messages=[
                {"role": "system", "content": "지식 그래프 관계 추론 전문가입니다."},
                {"role": "user", "content": prompt}
            ],
            temperature=0.3
        )
        
        result = parse_json(response.choices[0].message.content)
        return result.get('relations', [])
    
    except Exception as e:
        print(f"추가 관계 추론 오류: {e}")
        return []

def main(purpose="문서 분석"):
    """메인 실행 함수"""
    OUTPUT_ROOT = os.getenv("OUTPUT_ROOT", "output")
    result_dir = os.path.join(OUTPUT_ROOT, "result")
    chunks_dir = os.path.join(OUTPUT_ROOT, "chunked_document")
    schema_dir = os.path.join(OUTPUT_ROOT, "schema")
    os.makedirs(result_dir, exist_ok=True)

    # 노드 정보 로드
    result_path = os.path.join(result_dir, "result.json")
    if not os.path.exists(result_path):
        print(f"⚠️ 노드 정보가 없습니다: {result_path}")
        print("먼저 extract_node.py를 실행하세요.")
        return
        
    with open(result_path, "r", encoding="utf-8") as f:
        result_json = json.load(f)
        nodes = result_json["nodes"]

    # 스키마 정보 로드
    schema_path = os.path.join(schema_dir, "schema.json")
    with open(schema_path, "r", encoding="utf-8") as f:
        schema_json = json.load(f)
        schema_relations = schema_json.get("relations", [])

    load_dotenv()
    api_key = os.getenv("OPENAI_API_KEY")

    system_msg = f"""당신은 다양한 도메인의 문서에서 엔티티 간 관계를 추출하는 전문가입니다.
도메인에 관계없이 의미있는 관계를 발견하고, 명확한 근거와 함께 추출합니다.
반드시 올바른 JSON 형식으로만 응답하세요."""

    file_names = [f for f in os.listdir(chunks_dir) if f.endswith('.txt')]
    
    if not file_names:
        print("⚠️ 처리할 청크 파일이 없습니다.")
        return

    # 청크별 관계 추출
    all_relations = []
    
    with ThreadPoolExecutor(max_workers=5) as executor:
        futures = {
            executor.submit(process_file_general_relations, filename, chunks_dir, result_dir, 
                          system_msg, nodes, api_key, schema_relations): filename
            for filename in file_names
        }
        
        for future in tqdm(as_completed(futures), total=len(futures), desc="Extracting relations"):
            try:
                future.result()
            except Exception as e:
                print(f"Error processing {futures[future]}: {e}")

    # 결과 수집
    for i in range(len(file_names)):
        chunked_result_path = os.path.join(result_dir, f"result_enhanced_{i}.json")
        if os.path.exists(chunked_result_path):
            with open(chunked_result_path, "r", encoding="utf-8") as f:
                chunked_data = json.load(f)
                all_relations.extend(chunked_data.get("relations", []))

    # 선택적: 추가 관계 추론
    print("🔄 추가 관계 추론 중...")
    inferred_relations = cross_document_relation_discovery(nodes, all_relations[:50], api_key)
    all_relations.extend(inferred_relations)

    # 최종 결과 구성
    final_result = {
        "nodes": nodes,
        "relations": all_relations
    }

    # 노드 존재 확인
    node_names = {node['name'] for node in nodes}
    validated_relations = []
    
    for rel in all_relations:
        if rel['start_node'] in node_names and rel['end_node'] in node_names:
            validated_relations.append(rel)
        else:
            print(f"⚠️ 관계 제외 (노드 없음): {rel['start_node']} -> {rel['end_node']}")
    
    final_result['relations'] = validated_relations

    # 저장
    result_path = os.path.join(result_dir, "result.json")
    with open(result_path, "w", encoding="utf-8") as f:
        json.dump(final_result, f, ensure_ascii=False, indent=4)

    # 중복 제거
    deduplicate(result_path)
    
    # 통계 출력
    print(f"✅ 관계 추출 완료: {result_path}")
    print(f"📊 총 관계: {len(validated_relations)}개")
    
    # 관계 타입별 분포
    from collections import Counter
    relation_types = [rel['relationship'] for rel in validated_relations]
    relation_stats = Counter(relation_types)
    
    print("\n📈 관계 타입 분포 (상위 10개):")
    for rel_type, count in relation_stats.most_common(10):
        print(f"   {rel_type}: {count}개")

if __name__ == "__main__":
    main(purpose="문서 분석")