# rag.py
"""
Graph-RAG 모듈 – answer() 함수를 외부에서 재사용할 수 있도록 정리
"""

import os
from dotenv import load_dotenv
from langchain_openai import ChatOpenAI, OpenAIEmbeddings
from langchain_community.vectorstores import Neo4jVector
from langchain_neo4j import Neo4jGraph, GraphCypherQAChain

# ── (A) 공통 초기화 ────────────────────────────────────────────────
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

_chain = GraphCypherQAChain.from_llm(
    _llm,
    graph=_graph,
    top_k=5,
    validate_cypher=True,
    allow_dangerous_requests=True,   # READ-ONLY 계정 사용 권장
    verbose=False,
)

# ── (B) 외부 공개 함수 ────────────────────────────────────────────
def answer(question: str) -> str:
    """
    주어진 질문에 대해 그래프-RAG로 답변을 생성해 반환한다.
    예외가 발생하면 빈 문자열을 반환.
    """
    try:
        result = _chain.invoke({"query": question})
        return result.get("result", "").strip()
    except Exception:
        return ""

# ── (C) CLI 테스트용 ──────────────────────────────────────────────
if __name__ == "__main__":
    while True:
        q = input("질문: ")
        print("답변:", answer(q))
