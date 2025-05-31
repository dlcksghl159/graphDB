
import os
from langchain_community.vectorstores import Neo4jVector
from langchain_openai                 import OpenAIEmbeddings, ChatOpenAI
from langchain_neo4j                  import Neo4jGraph, GraphCypherQAChain
from langchain.chains                 import RetrievalQA
from langchain.chains.router.multi_retrieval_qa import MultiRetrievalQAChain
from langchain_core.retrievers import BaseRetriever
from langchain_core.documents  import Document
from langchain.callbacks.manager import CallbackManagerForRetrieverRun
from typing import List, Optional, Set
from pydantic import PrivateAttr, Field, ConfigDict
from dotenv import load_dotenv
load_dotenv()   
def _build_chain(kg_dir: str = "output"):
    """
    Neo4j 접속 → 그래프 QA 체인 + 벡터 QA 체인 → MultiRetrieval QA
    kg_dir 인자는 향후 파일-기반 벡터스토어 등을 쓸 때 대비용.
    """
    # 1) LLM
    key = os.getenv("OPENAI_API_KEY")
    llm = ChatOpenAI(model="gpt-4o-mini", openai_api_key=key)
    try:
        # ── 벡터 QA ─────────────────────────────────────────────
        vec_store = Neo4jVector.from_existing_index(
            embedding          = OpenAIEmbeddings(openai_api_key=key),
            url                = os.getenv("NEO4J_URI",      "bolt://localhost:7687"),
            username           = os.getenv("NEO4J_USER",     "neo4j"),
            password           = os.getenv("NEO4J_PASSWORD", "testtest"),
            index_name         = "all_embedding",
            node_label         = "Embeddable",
            text_node_property = "name",
        )
        qa_vector = RetrievalQA.from_chain_type(
            llm, chain_type="stuff",
            retriever=vec_store.as_retriever(search_type="similarity", k=5),
        )
        graph = Neo4jGraph(
            url      = os.getenv("NEO4J_URI",      "bolt://localhost:7687"),
            username = os.getenv("NEO4J_USER",     "neo4j"),
            password = os.getenv("NEO4J_PASSWORD", "testtest"),
        )
        qa_graph = GraphCypherQAChain.from_llm(
            llm, graph,
            top_k=10,
            allow_dangerous_requests=True,
            validate_cypher=False,
        )
        # ── 리트리버 래퍼 + 클린업 클래스 (원본 코드 그대로) ─────
        class GraphChainRetriever(BaseRetriever):
            _chain: GraphCypherQAChain = PrivateAttr()
            def __init__(self, chain: GraphCypherQAChain, **kw):
                super().__init__(**kw); self._chain = chain
            def _get_relevant_documents(self, query: str, *, run_manager: Optional[
                CallbackManagerForRetrieverRun]=None, **kw):
                ans = self._chain.run(query)
                return [Document(page_content=ans, metadata={"source": "graph"})]

        class CleanMetadataRetriever(BaseRetriever):
            _base: BaseRetriever = PrivateAttr()
            drop_keys: Set[str] = Field(default_factory=lambda: {"embedding"})
            model_config = ConfigDict(arbitrary_types_allowed=True)
            def __init__(self, base: BaseRetriever, drop_keys=None, **kw):
                super().__init__(**kw); self._base = base
                if drop_keys: self.drop_keys = set(drop_keys)
            def _get_relevant_documents(self, query: str, *, run_manager=None, **kw):
                docs = self._base.get_relevant_documents(query, **kw)
                return [
                    Document(d.page_content,
                            {k: v for k, v in d.metadata.items()
                            if k not in self.drop_keys})
                    for d in docs
                ]

        vec_retriever   = CleanMetadataRetriever(vec_store.as_retriever(k=5))
        graph_retriever = GraphChainRetriever(qa_graph)

        retriever_infos = [
            {"name": "vector", "description": "길고 문맥이 긴 답변", "retriever": vec_retriever},
            {"name": "graph",  "description": "정확한 엔티티·수치·관계", "retriever": graph_retriever},
        ]

        return MultiRetrievalQAChain.from_retrievers(
            default_chain_llm=llm, llm=llm, retriever_infos=retriever_infos
        )
    except Exception as e:
        print(f"⚠️ 벡터스토어 로딩 실패: {e}")
        return None

    

    # ── 그래프 QA ───────────────────────────────────────────
    

    
from functools import lru_cache

@lru_cache(maxsize=1)
def _get_chain(kg_dir: str = "output"):
    """
    최초 1회만 _build_chain()을 호출하고 결과를 캐시.
    """
    return _build_chain(kg_dir)

def answer(question: str, kg_dir: str = "output") -> str:
    """
    외부에서 호출할 진입점.
    """
    chain = _get_chain(kg_dir)
    if chain is None:
        return "⚠️ 벡터스토어를 로드할 수 없습니다. Neo4j 서버가 실행 중인지 확인하세요."
    else:
        result = chain.invoke(question)          # dict | str
        return result.get("result") if isinstance(result, dict) else result
if __name__ == "__main__":
    print(answer("Obzen과 obzen analytics의 관계는?"))
