import os
import json
import openai
import re
from util import merge_json, parse_json
from dotenv import load_dotenv
from deduplication import deduplicate
from tqdm import tqdm
from concurrent.futures import ThreadPoolExecutor, as_completed
from typing import Dict, List, Tuple, Set

# 환경 변수 로드
load_dotenv()
OUTPUT_ROOT = os.getenv("OUTPUT_ROOT", "output")
PURPOSE = os.getenv("PURPOSE", "기업 판매")

# 패턴 기반 관계 추출을 위한 정규식 패턴들 (PDF 제안사항)
RELATION_PATTERNS = {
    "WORKS_FOR": [
        r'(\w+)(?:\s+\w+)*\s+(?:회장|사장|대표|이사|팀장|과장|부장|실장|센터장)',
        r'(\w+)(?:에서|의)\s+(?:일하다|근무하다|재직하다)',
        r'(\w+)\s+(?:소속|직원|임직원)'
    ],
    "CEO_OF": [
        r'(\w+)\s+(?:대표이사|최고경영자|CEO|사장)',
        r'(\w+)(?:의)?\s+(?:대표|사장)(?:\s+(\w+))'
    ],
    "HEADQUARTERED_IN": [
        r'(\w+)(?:의)?\s+본사(?:는|가)?\s+(\w+)(?:에|에서)',
        r'(\w+)\s+본부(?:는|가)?\s+(\w+)(?:에|에서)\s+(?:위치|자리)'
    ],
    "ACQUIRED": [
        r'(\w+)(?:가|은|는)?\s+(\w+)(?:를|을)?\s+(?:인수|매입|사들이다)',
        r'(\w+)(?:와|과)?\s+(\w+)(?:의)?\s+(?:인수합병|M&A)'
    ],
    "PARTNERED_WITH": [
        r'(\w+)(?:와|과)\s+(\w+)(?:가|은|는)?\s+(?:협력|파트너십|제휴|협업)',
        r'(\w+)(?:와|과)\s+(\w+)\s+(?:협약|계약|제휴)'
    ],
    "VISITED": [
        r'(\w+)(?:가|은|는)?\s+(\w+)(?:를|을)?\s+(?:방문|찾아가다)',
        r'(\w+)\s+(\w+)\s+(?:방문|견학|시찰)'
    ],
    "INVESTED_IN": [
        r'(\w+)(?:가|은|는)?\s+(\w+)(?:에|에게)?\s+(?:투자|출자)',
        r'(\w+)\s+(\w+)\s+(?:투자유치|자금조달)'
    ],
    "FOUNDED": [
        r'(\w+)(?:가|은|는)?\s+(\w+)(?:를|을)?\s+(?:창업|창립|설립)',
        r'(\w+)\s+(?:창업자|창립자|설립자)(?:\s+(\w+))?'
    ]
}

def extract_relations_by_patterns(text: str, entities: Dict[str, str]) -> List[Dict]:
    """패턴 기반 관계 추출 (PDF 제안사항)"""
    extracted_relations = []
    entity_names = set(entities.keys())
    
    for relation_type, patterns in RELATION_PATTERNS.items():
        for pattern in patterns:
            matches = re.finditer(pattern, text)
            for match in matches:
                groups = match.groups()
                
                if len(groups) >= 2:
                    entity1, entity2 = groups[0], groups[1]
                    
                    # 엔티티가 실제로 존재하는지 확인
                    if entity1 in entity_names and entity2 in entity_names:
                        # 관계 방향 결정 (관계 타입에 따라)
                        if relation_type in ["WORKS_FOR", "CEO_OF"]:
                            start_node, end_node = entity1, entity2
                        elif relation_type in ["HEADQUARTERED_IN", "LOCATED_IN"]:
                            start_node, end_node = entity1, entity2
                        elif relation_type in ["VISITED"]:
                            start_node, end_node = entity1, entity2
                        else:
                            start_node, end_node = entity1, entity2
                        
                        extracted_relations.append({
                            "start_node": start_node,
                            "relationship": relation_type,
                            "end_node": end_node,
                            "properties": {
                                "extracted_by": "pattern",
                                "confidence": "high",
                                "source_text": match.group()
                            }
                        })
    
    return extracted_relations

def cross_chunk_relation_extraction(document_entities: List[Dict], document_text: str, api_key: str) -> List[Dict]:
    """크로스 청크 관계 추출 (PDF 제안사항)"""
    if len(document_entities) < 2:
        return []
    
    client = openai.OpenAI(api_key=api_key)
    
    # 엔티티 목록 생성
    entity_list = []
    for entity in document_entities:
        entity_list.append(f"- {entity['label']}: {entity['name']}")
    
    entity_str = "\n".join(entity_list[:50])  # 너무 많으면 제한
    
    prompt = f"""다음은 문서에서 추출된 엔티티들입니다. 전체 문서 텍스트를 바탕으로 이 엔티티들 간의 관계를 찾아주세요.

### 엔티티 목록:
{entity_str}

### 문서 전문:
{document_text[:4000]}  # 토큰 제한

### 지침:
1. 위 엔티티들 간의 명시적/암시적 관계를 모두 찾으세요
2. 문서의 여러 부분에 걸쳐 나타나는 관계도 포함하세요  
3. 대명사나 지시어로 연결되는 관계도 해결하세요
4. 각 관계마다 근거가 되는 문장을 properties에 포함하세요

### 출력 형식 (JSON):
{{
    "relations": [
        {{
            "start_node": "<엔티티명>",
            "relationship": "<관계타입>",
            "end_node": "<엔티티명>",
            "properties": {{
                "evidence": "<근거 문장>",
                "confidence": "high|medium|low"
            }}
        }}
    ]
}}"""

    try:
        response = client.chat.completions.create(
            model="gpt-4o",
            response_format={"type": "json_object"},
            messages=[
                {"role": "system", "content": "문서 전체를 분석하여 엔티티 간 관계를 찾는 전문가입니다."},
                {"role": "user", "content": prompt}
            ],
            temperature=0.1
        )
        
        result = parse_json(response.choices[0].message.content)
        return result.get('relations', [])
    
    except Exception as e:
        print(f"크로스 청크 관계 추출 오류: {e}")
        return []

def enhanced_process_file(filename, chunks_dir, result_dir, system_msg, nodes, api_key, document_entities_cache):
    """향상된 파일별 관계 추출"""
    client = openai.OpenAI(api_key=api_key)
    i = int(filename.split('_')[-1].split('.')[0])
    
    filename_path = os.path.join(chunks_dir, filename)
    if not os.path.exists(filename_path):
        print(f"파일 없음: {filename_path} → 종료합니다.")
        return
    
    with open(filename_path, "r", encoding="utf-8") as f:
        content = f.read()

    # 노드 이름을 딕셔너리로 매핑 (패턴 매칭용)
    entity_name_to_label = {}
    for node in nodes:
        entity_name_to_label[node['name']] = node['label']

    # 향상된 프롬프트 (더 많은 관계 타입과 예시 포함)
    prompt = f"""주어진 텍스트에서 엔티티 간의 모든 의미 있는 관계를 추출하세요.

### 지침:
- 제공된 노드를 정확히 사용하세요 (수정 금지)
- 관계 타입은 **SCREAMING_SNAKE_CASE**로 작성
- 다양한 관계 타입을 활용하세요:
  * 고용: WORKS_FOR, CEO_OF, FOUNDER_OF, BOARD_MEMBER_OF
  * 위치: HEADQUARTERED_IN, LOCATED_IN, HELD_IN, LIVES_IN
  * 비즈니스: ACQUIRED, PARTNERED_WITH, INVESTED_IN, COMPETES_WITH, SUBSIDIARY_OF
  * 이벤트: PARTICIPATED_IN, ATTENDED, SPOKE_AT, SPONSORED
  * 상호작용: VISITED, MET_WITH, NEGOTIATED, COLLABORATED_ON
- properties에는 날짜, 금액, 목적 등 구체적 정보 포함
- 암시적 관계도 추출 (예: "A 회장"은 A CEO_OF [회사] 관계 암시)

### 관계 추출 예시:
- "삼성전자 이재용 회장" → 이재용 CEO_OF 삼성전자
- "구글과 협력 계약" → [회사] PARTNERED_WITH 구글  
- "실리콘밸리 본사 방문" → [인물] VISITED [회사]
- "AI 컨퍼런스 기조연설" → [인물] SPOKE_AT [이벤트]

### 출력 형식 (JSON):
{{
    "nodes": {nodes},
    "relations": [
        {{
            "start_node": "<정확한엔티티이름>",
            "relationship": "<RELATION_TYPE>",
            "end_node": "<정확한엔티티이름>",
            "properties": {{
                "confidence": "high|medium|low",
                "evidence": "<근거 문장 일부>",
                "date": "<날짜>",
                "additional_info": "<추가 정보>"
            }}
        }}
    ]
}}

### 텍스트:
{content}

### 엔티티(노드):
{nodes}"""

    # LLM 관계 추출
    response = client.chat.completions.create(
        model="gpt-4o",
        response_format={"type": "json_object"},
        messages=[
            {"role": "system", "content": system_msg},
            {"role": "user", "content": prompt}
        ]
    )
    
    gpt_output = response.choices[0].message.content
    llm_result = parse_json(gpt_output)
    
    # 패턴 기반 관계 추출 (PDF 제안사항)
    pattern_relations = extract_relations_by_patterns(content, entity_name_to_label)
    
    # LLM 결과와 패턴 결과 병합
    all_relations = llm_result.get('relations', []) + pattern_relations
    
    # 중복 제거 (같은 start_node, relationship, end_node 조합)
    seen_relations = set()
    unique_relations = []
    
    for rel in all_relations:
        rel_key = (rel['start_node'], rel['relationship'], rel['end_node'])
        if rel_key not in seen_relations:
            seen_relations.add(rel_key)
            unique_relations.append(rel)
    
    # 문서별 엔티티 캐시에 추가 (크로스 청크 관계 추출용)
    doc_id = f"doc_{i // 10}"  # 10개 청크당 하나의 문서로 가정
    if doc_id not in document_entities_cache:
        document_entities_cache[doc_id] = {"entities": [], "text": ""}
    
    document_entities_cache[doc_id]["entities"].extend(nodes)
    document_entities_cache[doc_id]["text"] += content + "\n"
    
    final_result = {
        "nodes": nodes,
        "relations": unique_relations
    }
    
    # 개별 결과 저장
    result_path = os.path.join(result_dir, f'result_enhanced_{i}.json')
    with open(result_path, "w", encoding="utf-8") as f:
        json.dump(final_result, f, ensure_ascii=False, indent=4)
    
    print(f"[{i}] 향상된 관계 추출 완료 - LLM: {len(llm_result.get('relations', []))}, 패턴: {len(pattern_relations)}, 최종: {len(unique_relations)}")

def post_process_enhanced_relations(result_json: Dict) -> Dict:
    """향상된 관계 후처리"""
    processed_relations = []
    node_names = {node['name'] for node in result_json.get('nodes', [])}
    
    # 관계 정규화 매핑
    relation_normalization = {
        'EMPLOYED_BY': 'WORKS_FOR',
        'WORKS_AT': 'WORKS_FOR',
        'BASED_IN': 'LOCATED_IN',
        'HEADQUARTERED_AT': 'HEADQUARTERED_IN',
        'COLLABORATED_WITH': 'PARTNERED_WITH',
        'COOPERATED_WITH': 'PARTNERED_WITH'
    }
    
    dropped_relations = []
    
    for rel in result_json.get('relations', []):
        # 관계 타입 정규화
        original_rel_type = rel['relationship']
        normalized_rel_type = relation_normalization.get(original_rel_type, original_rel_type)
        rel['relationship'] = normalized_rel_type
        
        # 노드 존재 확인
        if rel['start_node'] in node_names and rel['end_node'] in node_names:
            processed_relations.append(rel)
        else:
            dropped_relations.append(rel)
            print(f"⚠️ 관계 제외 (노드 없음): {rel['start_node']} -{rel['relationship']}-> {rel['end_node']}")
    
    result_json['relations'] = processed_relations
    
    # 드롭된 관계 통계
    if dropped_relations:
        print(f"📊 드롭된 관계: {len(dropped_relations)}개")
        
        # 드롭 원인 분석
        missing_start = sum(1 for rel in dropped_relations if rel['start_node'] not in node_names)
        missing_end = sum(1 for rel in dropped_relations if rel['end_node'] not in node_names)
        print(f"   - start_node 누락: {missing_start}개")
        print(f"   - end_node 누락: {missing_end}개")
    
    return result_json

def main(purpose="뉴스 기사 분석"):
    """메인 실행 함수"""
    OUTPUT_ROOT = os.getenv("OUTPUT_ROOT", "output")
    result_dir = os.path.join(OUTPUT_ROOT, "result")
    chunks_dir = os.path.join(OUTPUT_ROOT, "chunked_document")
    os.makedirs(result_dir, exist_ok=True)

    # 노드 정보 로드
    with open("output/result/result.json", "r", encoding="utf-8") as f:
        result_json = json.load(f)
        nodes = result_json["nodes"]

    load_dotenv()
    api_key = os.getenv("OPENAI_API_KEY")

    system_msg = """당신은 한국어 뉴스 기사에서 포괄적인 엔티티 관계를 추출하는 전문가입니다.
명시적 관계뿐만 아니라 암시적 관계, 대명사 참조, 문맥상 관계도 모두 추출합니다.
다양한 관계 타입을 활용하여 풍부한 지식 그래프를 구성합니다.
반드시 올바른 JSON 형식으로만 응답하세요."""

    file_names = [f for f in os.listdir(chunks_dir) if f.endswith('.txt')]
    document_entities_cache = {}  # 문서별 엔티티 캐시

    # 1차: 청크별 관계 추출
    with ThreadPoolExecutor(max_workers=10) as executor:
        futures = {
            executor.submit(enhanced_process_file, filename, chunks_dir, result_dir, 
                          system_msg, nodes, api_key, document_entities_cache): filename
            for filename in file_names
        }
        
        for future in tqdm(as_completed(futures), total=len(futures), desc="Extracting relations"):
            try:
                future.result()
            except Exception as e:
                print(f"Error processing {futures[future]}: {e}")

    # 2차: 크로스 청크 관계 추출 (PDF 제안사항)
    print("🔄 크로스 청크 관계 추출 시작...")
    cross_chunk_relations = []
    
    for doc_id, doc_data in document_entities_cache.items():
        if len(doc_data["entities"]) > 1:  # 엔티티가 2개 이상인 문서만
            relations = cross_chunk_relation_extraction(
                doc_data["entities"], 
                doc_data["text"], 
                api_key
            )
            cross_chunk_relations.extend(relations)
            print(f"📄 {doc_id}: {len(relations)}개 크로스청크 관계 추출")

    # 3차: 결과 병합
    result_path = os.path.join(result_dir, "result_enhanced.json")
    final_result = {"nodes": nodes, "relations": []}
    
    # 청크별 결과 수집
    for i in range(len(file_names)):
        chunked_result_path = os.path.join(result_dir, f"result_enhanced_{i}.json")
        if os.path.exists(chunked_result_path):
            with open(chunked_result_path, "r", encoding="utf-8") as f:
                chunked_data = json.load(f)
                final_result["relations"].extend(chunked_data.get("relations", []))
    
    # 크로스 청크 관계 추가
    final_result["relations"].extend(cross_chunk_relations)
    
    # 최종 후처리
    final_result = post_process_enhanced_relations(final_result)
    
    # 저장
    with open(result_path, "w", encoding="utf-8") as f:
        json.dump(final_result, f, ensure_ascii=False, indent=4)

    # 중복 제거
    deduplicate(result_path)
    
    # 통계 출력
    print(f"✅ 향상된 관계 추출 완료: {result_path}")
    print(f"📊 총 관계: {len(final_result['relations'])}개")
    print(f"📊 크로스청크 관계: {len(cross_chunk_relations)}개")
    
    # 관계 타입별 분포
    from collections import Counter
    relation_types = [rel['relationship'] for rel in final_result['relations']]
    relation_stats = Counter(relation_types)
    
    print("📈 관계 타입 분포 (상위 10개):")
    for rel_type, count in relation_stats.most_common(10):
        print(f"   {rel_type}: {count}개")

if __name__ == "__main__":
    main(purpose="뉴스 기사 분석")