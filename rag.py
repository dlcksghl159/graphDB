# rag.py
"""
Graph-RAG 모듈 – 노드 우선 탐색 + 유연한 관계 매칭
(2025-06-17 통합 패치: elementId/labels 평탄화 버그 수정)
"""

import os
from typing import List, Dict
from dotenv import load_dotenv
from langchain_openai import ChatOpenAI, OpenAIEmbeddings
from langchain_community.vectorstores import Neo4jVector
from langchain_neo4j import Neo4jGraph, GraphCypherQAChain

# ── (A) 공통 초기화 ────────────────────────────────────────────
load_dotenv()

NEO4J_URI      = os.getenv("NEO4J_URI", "bolt://localhost:7687")
NEO4J_USERNAME = os.getenv("NEO4J_USERNAME", "neo4j")
NEO4J_PASSWORD = os.getenv("NEO4J_PASSWORD", "password")
OPENAI_API_KEY = os.getenv("OPENAI_API_KEY")
if not OPENAI_API_KEY:
    raise RuntimeError("OPENAI_API_KEY not set")

_llm        = ChatOpenAI(openai_api_key=OPENAI_API_KEY,
                         model="gpt-4.1",
                         temperature=0)
_embeddings = OpenAIEmbeddings(openai_api_key=OPENAI_API_KEY)

_graph = Neo4jGraph(url=NEO4J_URI,
                    username=NEO4J_USERNAME,
                    password=NEO4J_PASSWORD)

# (선택) 벡터 인덱스가 없어도 그냥 진행
try:
    _ = Neo4jVector.from_existing_index(
        embedding=_embeddings,
        url=NEO4J_URI,
        username=NEO4J_USERNAME,
        password=NEO4J_PASSWORD,
        index_name="vector",
        node_label="Chunk",
        text_node_property="text",
        embedding_node_property="embedding",
    )
except Exception:
    pass  # 경고만 무시

# ── (B) 노드 우선 탐색 함수들 ───────────────────────────────────
def find_entities_in_question(question: str) -> List[str]:
    """
    질문에서 엔티티를 추출 (LLM 사용)
    """
    prompt = f"""다음 질문에서 핵심 엔티티(인물, 작품, 영화, 회사 등)를 추출하세요.
엔티티만 추출하고, 쉼표로 구분해서 나열하세요.

질문: {question}

엔티티들:"""
    try:
        response = _llm.invoke(prompt)
        entities = [e.strip() for e in response.content.split(',') if e.strip()]
        return entities
    except Exception:
        return []

def find_nodes_by_name(entity_names: List[str]) -> List[Dict]:
    """
    이름으로 노드 찾기 (정확 일치 → 부분 일치)
    반환 예: {'node_id': '4:73e9a61b-…', 'name': 'Thor', 'labels': ['Movie']}
    """
    nodes: List[Dict] = []
    for entity in entity_names:
        # 정확 일치
        exact_query = """
        MATCH (n)
        WHERE n.name = $entity
        RETURN elementId(n) AS node_id, n.name AS name, labels(n) AS labels
        LIMIT 5
        """
        exact_result = _graph.query(exact_query, {"entity": entity})
        if exact_result:
            nodes.extend(exact_result)
            continue  # 같은 엔티티에 대해 부분 일치는 생략

        # 부분 일치
        partial_query = """
        MATCH (n)
        WHERE n.name CONTAINS $entity
        RETURN elementId(n) AS node_id, n.name AS name, labels(n) AS labels
        LIMIT 5
        """
        partial_result = _graph.query(partial_query, {"entity": entity})
        nodes.extend(partial_result)
    return nodes

def get_node_relationships(node_id: str) -> List[Dict]:
    """
    특정 노드의 모든 관계 가져오기
    """
    query = """
    MATCH (n)-[r]-(m)
    WHERE elementId(n) = $node_id
    RETURN
        startNode(r) = n AS is_outgoing,
        type(r)      AS relationship_type,
        m.name       AS connected_node_name,
        labels(m)    AS connected_node_labels,
        properties(r) AS relationship_properties
    """
    return _graph.query(query, {"node_id": node_id})

def analyze_relationships_with_llm(
    question: str,
    node_name: str,
    node_labels: List[str],
    relationships: List[Dict],
) -> str:
    """
    LLM을 사용해 질문과 관계들을 분석하고 답변 생성
    """
    # 관계 정보 포맷팅
    rel_descriptions = []
    for rel in relationships:
        direction = "→" if rel["is_outgoing"] else "←"
        rel_desc = f"{direction} {rel['relationship_type']} {direction} {rel['connected_node_name']} ({', '.join(rel['connected_node_labels'])})"
        if rel["relationship_properties"]:
            rel_desc += f" [속성: {rel['relationship_properties']}]"
        rel_descriptions.append(rel_desc)
    relationships_text = "\n".join(rel_descriptions)

    prompt = f"""주어진 노드와 관계 정보를 바탕으로 질문에 답변하세요.

질문: {question}

중심 노드: {node_name} (타입: {', '.join(node_labels)})

연결된 관계들:
{relationships_text}

주의사항:
- 관계 타입이 정확히 일치하지 않아도 의미상 연관되면 사용하세요
  예: ACTED_IN ≈ FEATURED_IN ≈ APPEARED_IN ≈ STARRED_IN
  예: DIRECTED ≈ DIRECTED_BY ≈ FILMMAKER_OF
  예: PRODUCED ≈ PRODUCED_BY ≈ PRODUCER_OF
- 질문의 의도를 파악해서 가장 적절한 관계를 선택하세요
- 구체적인 이름과 정보를 포함해서 답변하세요

답변:"""
    response = _llm.invoke(prompt)
    return response.content

# ── (C) 향상된 답변 생성 함수 ───────────────────────────────────
def enhanced_answer(question: str) -> str:
    """
    노드 우선 탐색 + 유연한 관계 매칭으로 답변 생성
    """
    try:
        print(f"🔍 질문: {question}")

        # 1. 질문에서 엔티티 추출
        entities = find_entities_in_question(question)
        print(f"📌 추출된 엔티티: {entities}")

        if not entities:
            return fallback_answer(question)

        # 2. 엔티티로 노드 찾기
        nodes = find_nodes_by_name(entities)
        print(f"🎯 찾은 노드 수: {len(nodes)}")

        if not nodes:
            return f"'{', '.join(entities)}'에 대한 정보를 찾을 수 없습니다."

        # 3. 각 노드의 관계 분석
        best_answer = ""
        best_score = 0
        for node_info in nodes:
            node_id     = node_info["node_id"]
            node_name   = node_info["name"]
            node_labels = node_info["labels"]

            print(f"\n🔗 노드 '{node_name}' 분석 중...")

            relationships = get_node_relationships(node_id)
            if not relationships:
                continue
            print(f"   관계 수: {len(relationships)}")

            answer = analyze_relationships_with_llm(
                question, node_name, node_labels, relationships
            )
            score = evaluate_answer_quality(answer)
            print(f"   답변 점수: {score}")

            if score > best_score:
                best_score = score
                best_answer = answer

        if best_answer:
            return best_answer
        return fallback_answer(question)

    except Exception as e:
        print(f"❌ 오류 발생: {str(e)}")
        return fallback_answer(question)

def fallback_answer(question: str) -> str:
    """
    기존 GraphCypherQAChain 방식으로 폴백
    """
    chain = GraphCypherQAChain.from_llm(
        _llm,
        graph=_graph,
        top_k=5,
        validate_cypher=True,
        allow_dangerous_requests=True,
        verbose=False,
    )
    try:
        result = chain.invoke({"query": question})
        return result.get("result", "답변을 찾을 수 없습니다.").strip()
    except Exception:
        return "답변을 찾을 수 없습니다."

# ── (D) 답변 품질 평가 함수 ────────────────────────────────────
def evaluate_answer_quality(answer: str) -> int:
    """
    답변의 품질을 0-100점으로 평가
    """
    if not answer or answer.strip() == "":
        return 0

    bad_phrases = [
        "저는 그 답을 알지 못합니다",
        "답을 알지 못합니다",
        "정보를 찾을 수 없습니다",
        "I don't know",
        "cannot find",
        "no information",
        "unable to find",
    ]
    answer_lower = answer.lower()
    for phrase in bad_phrases:
        if phrase.lower() in answer_lower:
            return 0

    score = 50  # 기본 점수

    length = len(answer.strip())
    if 20 <= length <= 500:
        score += 20
    elif 10 <= length <= 1000:
        score += 10

    specific_indicators = [
        "이름", "날짜", "숫자", "년도", "개", "명", "번째",
        "name", "date", "year", "number",
    ]
    for indicator in specific_indicators:
        if indicator in answer_lower:
            score += 5

    if answer.strip().endswith(('.', '!', '?', '다', '습니다', '입니다')):
        score += 10

    return min(score, 100)

# ── (E) 외부 공개 함수 ──────────────────────────────────────────
def answer(question: str) -> str:
    """
    주어진 질문에 대해 노드 우선 탐색으로 답변을 생성한다.
    """
    return enhanced_answer(question)

# ── (F) CLI 테스트용 ───────────────────────────────────────────
if __name__ == "__main__":
    print("🚀 Enhanced Graph-RAG 시스템 (노드 우선 탐색 + 유연한 관계 매칭)")
    print("'quit' 입력시 종료\n")

    while True:
        q = input("질문: ").strip()
        if q.lower() == "quit":
            break
        elif not q:
            continue

        result = answer(q)
        print(f"답변: {result}\n")
