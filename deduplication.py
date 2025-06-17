import os
import json
import openai
from util import parse_json
from dotenv import load_dotenv
from typing import Dict, List, Set, Tuple
from collections import Counter, defaultdict
import re

def analyze_graph_integrity(data: Dict) -> Dict:
    """그래프 무결성 분석 (PDF 제안사항)"""
    nodes = data.get('nodes', [])
    relations = data.get('relations', [])
    
    # 노드 이름 집합
    node_names = {node['name'] for node in nodes}
    
    # 관계에서 참조되는 노드들
    referenced_nodes = set()
    for rel in relations:
        referenced_nodes.add(rel['start_node'])
        referenced_nodes.add(rel['end_node'])
    
    # 무결성 분석
    orphaned_nodes = node_names - referenced_nodes  # 관계가 없는 고립된 노드
    missing_nodes = referenced_nodes - node_names   # 관계에서 참조되지만 존재하지 않는 노드
    
    # 노드별 연결도 분석
    node_connections = defaultdict(int)
    for rel in relations:
        node_connections[rel['start_node']] += 1
        node_connections[rel['end_node']] += 1
    
    # 중앙성이 높은 노드들 (연결이 많은 노드)
    central_nodes = sorted(node_connections.items(), key=lambda x: x[1], reverse=True)[:10]
    
    # 관계 타입 분포
    relation_types = Counter(rel['relationship'] for rel in relations)
    
    # 중복 관계 검사
    relation_keys = [(rel['start_node'], rel['relationship'], rel['end_node']) for rel in relations]
    duplicate_relations = [k for k, count in Counter(relation_keys).items() if count > 1]
    
    return {
        "total_nodes": len(nodes),
        "total_relations": len(relations),
        "orphaned_nodes": list(orphaned_nodes),
        "missing_nodes": list(missing_nodes),
        "central_nodes": central_nodes,
        "relation_types": dict(relation_types),
        "duplicate_relations": duplicate_relations,
        "connectivity_score": len(referenced_nodes) / len(nodes) if nodes else 0
    }

def repair_missing_entities(data: Dict, api_key: str) -> Dict:
    """누락된 엔티티 복구 시도 (PDF 제안사항)"""
    client = openai.OpenAI(api_key=api_key)
    
    integrity_analysis = analyze_graph_integrity(data)
    missing_nodes = integrity_analysis['missing_nodes']
    
    if not missing_nodes:
        return data
    
    print(f"🔧 누락된 엔티티 복구 시도: {len(missing_nodes)}개")
    
    # 누락된 엔티티에 대한 정보 추론
    existing_nodes = data.get('nodes', [])
    relations = data.get('relations', [])
    
    # 누락된 각 엔티티에 대해 관계 컨텍스트 수집
    for missing_node in missing_nodes:
        related_relations = []
        for rel in relations:
            if rel['start_node'] == missing_node or rel['end_node'] == missing_node:
                related_relations.append(rel)
        
        if related_relations:
            # 관계 컨텍스트로부터 엔티티 타입 추론
            context_prompt = f"""누락된 엔티티 '{missing_node}'의 타입을 다음 관계들로부터 추론하세요:

관계 정보:
{json.dumps(related_relations, ensure_ascii=False, indent=2)}

기존 노드 예시:
{json.dumps(existing_nodes[:5], ensure_ascii=False, indent=2)}

다음 중 가장 적절한 라벨을 선택하고 기본 속성을 추론하세요:
PERSON, COMPANY, ORGANIZATION, LOCATION, EVENT, PRODUCT, TECHNOLOGY, PROJECT

JSON 형식으로 응답:
{{
    "label": "추론된_라벨",
    "name": "{missing_node}",
    "properties": {{
        "inferred": true,
        "confidence": "high|medium|low",
        "reasoning": "추론 근거"
    }}
}}"""

            try:
                response = client.chat.completions.create(
                    model="gpt-4o-mini",
                    response_format={"type": "json_object"},
                    messages=[
                        {"role": "system", "content": "엔티티 타입 추론 전문가입니다."},
                        {"role": "user", "content": context_prompt}
                    ],
                    temperature=0.1
                )
                
                inferred_entity = parse_json(response.choices[0].message.content)
                data['nodes'].append(inferred_entity)
                print(f"   복구됨: {missing_node} → {inferred_entity['label']}")
                
            except Exception as e:
                print(f"   복구 실패: {missing_node} - {e}")
    
    return data

def enhanced_similarity_check(nodes: List[Dict]) -> List[Tuple[int, int, float]]:
    """향상된 노드 유사도 검사"""
    from difflib import SequenceMatcher
    
    similar_pairs = []
    
    for i, node1 in enumerate(nodes):
        for j, node2 in enumerate(nodes[i+1:], i+1):
            # 같은 라벨의 노드들만 비교
            if node1['label'] != node2['label']:
                continue
            
            name1 = node1['name'].lower()
            name2 = node2['name'].lower()
            
            # 문자열 유사도 계산
            similarity = SequenceMatcher(None, name1, name2).ratio()
            
            # 높은 유사도 또는 포함 관계
            if similarity > 0.8 or name1 in name2 or name2 in name1:
                similar_pairs.append((i, j, similarity))
    
    return similar_pairs

def smart_deduplication(data_path: str):
    """지능형 중복 제거 (PDF 제안사항 반영)"""
    
    # 기존 데이터 로드
    with open(data_path, "r", encoding="utf-8") as f:
        result_json = json.load(f)

    # 백업 저장
    root, ext = os.path.splitext(data_path)
    backup_path = f"{root}_backup{ext}"
    with open(backup_path, "w", encoding="utf-8") as f:
        json.dump(result_json, f, ensure_ascii=False, indent=4)

    load_dotenv()
    api_key = os.getenv("OPENAI_API_KEY")

    # 1단계: 그래프 무결성 분석
    print("🔍 1단계: 그래프 무결성 분석")
    integrity_report = analyze_graph_integrity(result_json)
    
    print(f"   노드: {integrity_report['total_nodes']}개")
    print(f"   관계: {integrity_report['total_relations']}개")
    print(f"   고립된 노드: {len(integrity_report['orphaned_nodes'])}개")
    print(f"   누락된 노드: {len(integrity_report['missing_nodes'])}개")
    print(f"   연결성 점수: {integrity_report['connectivity_score']:.2f}")
    
    if integrity_report['missing_nodes']:
        print(f"   누락된 노드 목록: {integrity_report['missing_nodes'][:10]}")

    # 2단계: 누락된 엔티티 복구
    print("🔧 2단계: 누락된 엔티티 복구")
    result_json = repair_missing_entities(result_json, api_key)

    # 3단계: 유사 노드 검사 및 병합
    print("🔍 3단계: 유사 노드 검사")
    similar_pairs = enhanced_similarity_check(result_json['nodes'])
    
    if similar_pairs:
        print(f"   유사한 노드 쌍: {len(similar_pairs)}개")
        for i, j, sim in similar_pairs[:5]:  # 상위 5개만 출력
            node1 = result_json['nodes'][i]
            node2 = result_json['nodes'][j]
            print(f"   - {node1['name']} ↔ {node2['name']} (유사도: {sim:.2f})")

    # 4단계: LLM 기반 지능형 중복 제거
    print("🤖 4단계: LLM 기반 지능형 중복 제거")
    client = openai.OpenAI(api_key=api_key)

    # 중복 제거 프롬프트 개선
    enhanced_prompt = f"""다음 지식 그래프의 노드와 관계를 분석하여 중복 및 품질 이슈를 해결하세요.

### 현재 데이터:
{json.dumps(result_json, ensure_ascii=False, indent=2)[:8000]}  # 토큰 제한

### 무결성 분석 결과:
- 총 노드: {integrity_report['total_nodes']}개
- 총 관계: {integrity_report['total_relations']}개  
- 고립된 노드: {len(integrity_report['orphaned_nodes'])}개
- 중복 관계: {len(integrity_report['duplicate_relations'])}개

### 개선 지침:
1. **똑똑한 중복 제거**: 
   - 의미상 동일한 엔티티 병합 (예: "구글" + "Google" → "구글")
   - 속성 정보 손실 없이 병합
   - 별칭 정보는 aliases 배열에 보존

2. **관계 품질 향상**:
   - 중복 관계 제거
   - 불필요한 관계 정리 (너무 일반적이거나 의미 없는 관계)
   - 관계 방향 일관성 확인

3. **노드 품질 향상**:
   - 너무 일반적인 노드 제거 ("기술", "시장" 등)
   - 구체적 노드가 있으면 일반적 노드 제거 (예: "아시아" vs "한국", "일본")
   - 속성 정보 풍부화

4. **맥락 일관성**:
   - 한국어 뉴스 도메인에 적합한 엔티티만 유지
   - 문맥상 중요하지 않은 엔티티 제거

### 출력:
정제된 노드와 관계만 포함하는 JSON"""

    try:
        response = client.chat.completions.create(
            model="gpt-4o",
            messages=[
                {"role": "system", "content": "지식 그래프 품질 개선 전문가입니다."},
                {"role": "user", "content": enhanced_prompt}
            ],
            temperature=0.1
        )

        # 응답에서 JSON 추출
        gpt_output = response.choices[0].message.content
        
        # JSON 코드 블록에서 추출
        json_match = re.search(r'```json\s*(.*?)\s*```', gpt_output, re.DOTALL)
        if json_match:
            json_content = json_match.group(1)
        else:
            json_content = gpt_output
        
        cleaned_json = parse_json(json_content)

        # 5단계: 결과 검증 및 통계
        print("📊 5단계: 개선 결과 검증")
        
        original_nodes = len(result_json['nodes'])
        original_relations = len(result_json['relations'])
        cleaned_nodes = len(cleaned_json.get('nodes', []))
        cleaned_relations = len(cleaned_json.get('relations', []))
        
        print(f"   노드: {original_nodes} → {cleaned_nodes} ({cleaned_nodes - original_nodes:+d})")
        print(f"   관계: {original_relations} → {cleaned_relations} ({cleaned_relations - original_relations:+d})")
        
        # 최종 무결성 검사
        final_integrity = analyze_graph_integrity(cleaned_json)
        print(f"   최종 연결성: {final_integrity['connectivity_score']:.2f}")
        print(f"   최종 고립 노드: {len(final_integrity['orphaned_nodes'])}개")

        # 중요한 개선사항이 있는 경우만 적용
        if (final_integrity['connectivity_score'] >= integrity_report['connectivity_score'] * 0.9 and 
            len(final_integrity['missing_nodes']) <= len(integrity_report['missing_nodes'])):
            
            with open(data_path, "w", encoding="utf-8") as f:
                json.dump(cleaned_json, f, ensure_ascii=False, indent=4)
            print("✅ 개선된 데이터 저장 완료")
        else:
            print("⚠️ 품질 저하로 원본 유지")
            
    except Exception as e:
        print(f"LLM 중복 제거 실패: {e}")

def validate_graph_quality(data_path: str) -> Dict:
    """그래프 품질 검증 (PDF 제안사항)"""
    with open(data_path, "r", encoding="utf-8") as f:
        data = json.load(f)
    
    nodes = data.get('nodes', [])
    relations = data.get('relations', [])
    
    quality_metrics = {
        "node_coverage": 0,      # 관계에 참여하는 노드 비율
        "relation_density": 0,   # 가능한 관계 대비 실제 관계 비율  
        "avg_connections": 0,    # 노드당 평균 연결 수
        "isolated_nodes": 0,     # 고립된 노드 수
        "relation_diversity": 0, # 관계 타입 다양성
        "has_aliases": 0,        # 별칭 정보가 있는 노드 수
        "property_richness": 0   # 속성이 풍부한 노드 비율
    }
    
    if not nodes:
        return quality_metrics
    
    # 노드 커버리지
    node_names = {node['name'] for node in nodes}
    referenced_nodes = set()
    for rel in relations:
        referenced_nodes.add(rel['start_node'])
        referenced_nodes.add(rel['end_node'])
    
    quality_metrics["node_coverage"] = len(referenced_nodes) / len(nodes)
    quality_metrics["isolated_nodes"] = len(nodes) - len(referenced_nodes)
    
    # 관계 밀도
    max_possible_relations = len(nodes) * (len(nodes) - 1)  # 방향성 있는 관계
    if max_possible_relations > 0:
        quality_metrics["relation_density"] = len(relations) / max_possible_relations
    
    # 평균 연결 수
    if nodes:
        quality_metrics["avg_connections"] = (len(relations) * 2) / len(nodes)
    
    # 관계 다양성
    relation_types = set(rel['relationship'] for rel in relations)
    quality_metrics["relation_diversity"] = len(relation_types)
    
    # 별칭 정보
    quality_metrics["has_aliases"] = sum(1 for node in nodes 
                                       if 'aliases' in node.get('properties', {}))
    
    # 속성 풍부도 (속성이 2개 이상인 노드)
    quality_metrics["property_richness"] = sum(1 for node in nodes 
                                             if len(node.get('properties', {})) >= 2) / len(nodes)
    
    return quality_metrics

def main_enhanced_deduplication(data_path: str):
    """메인 향상된 중복 제거 함수"""
    print("🚀 향상된 지식 그래프 품질 개선 시작")
    
    # 사전 품질 측정
    print("📊 사전 품질 측정")
    pre_quality = validate_graph_quality(data_path)
    print(f"   노드 커버리지: {pre_quality['node_coverage']:.2f}")
    print(f"   관계 다양성: {pre_quality['relation_diversity']}개 타입")
    print(f"   고립 노드: {pre_quality['isolated_nodes']}개")
    print(f"   속성 풍부도: {pre_quality['property_richness']:.2f}")
    
    # 지능형 중복 제거 수행
    smart_deduplication(data_path)
    
    # 사후 품질 측정
    print("📊 사후 품질 측정")
    post_quality = validate_graph_quality(data_path)
    print(f"   노드 커버리지: {post_quality['node_coverage']:.2f} ({post_quality['node_coverage'] - pre_quality['node_coverage']:+.2f})")
    print(f"   관계 다양성: {post_quality['relation_diversity']}개 타입 ({post_quality['relation_diversity'] - pre_quality['relation_diversity']:+d})")
    print(f"   고립 노드: {post_quality['isolated_nodes']}개 ({post_quality['isolated_nodes'] - pre_quality['isolated_nodes']:+d})")
    print(f"   속성 풍부도: {post_quality['property_richness']:.2f} ({post_quality['property_richness'] - pre_quality['property_richness']:+.2f})")
    
    print("✅ 향상된 지식 그래프 품질 개선 완료")

# 기존 함수와의 호환성을 위한 래퍼
def deduplicate(data_path: str):
    """기존 인터페이스 호환성 유지"""
    main_enhanced_deduplication(data_path)

if __name__ == "__main__":
    import sys
    if len(sys.argv) > 1:
        main_enhanced_deduplication(sys.argv[1])
    else:
        main_enhanced_deduplication("output/result/result.json")