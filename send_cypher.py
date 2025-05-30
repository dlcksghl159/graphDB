"""
send_cypher.py
--------------
usage:
  python send_cypher.py
"""
import os, re
from pathlib import Path
from neo4j import GraphDatabase, basic_auth
from langchain_openai import OpenAIEmbeddings
from dotenv import load_dotenv
load_dotenv()   
key = os.getenv("OPENAI_API_KEY")

OUTPUT_ROOT  = Path(os.getenv("OUTPUT_ROOT", "output"))
cypher_query = OUTPUT_ROOT / "graph.cypher"


# ── 0. 설정 ───────────────────────────────────────────────────────
NEO4J_URI  = os.getenv("NEO4J_URI",  "bolt://localhost:7687")
NEO4J_USER = os.getenv("NEO4J_USER", "neo4j")
NEO4J_PASS = os.getenv("NEO4J_PASSWORD", "testtest")  # 반드시 설정!

BATCH_SIZE = 50          # 한 트랜잭션에 묶을 스테이트먼트 수
CY_FILE    = Path(cypher_query).expanduser()

# ── 1. Cypher 파일 로드 & 파싱 ────────────────────────────────────
text   = CY_FILE.read_text(encoding="utf-8")
# 두 개 이상의 연속 개행(공백 포함) → split
stmts  = [s.strip() for s in re.split(r"\n\s*\n", text) if s.strip()]

print(f"📄  loaded {len(stmts)} Cypher statements from {CY_FILE}")

# ── 2. Neo4j 연결 ────────────────────────────────────────────────
driver = GraphDatabase.driver(NEO4J_URI,
                              auth=basic_auth(NEO4J_USER, NEO4J_PASS))

# ── 3. 전송 (배치 커밋) ───────────────────────────────────────────
total = 0
with driver.session() as sess:
    tx  = sess.begin_transaction()
    for i, cy in enumerate(stmts, 1):
        tx.run(cy)            # 파라미터 없는 순수 text 쿼리
        if i % BATCH_SIZE == 0:
            tx.commit(); total += BATCH_SIZE
            print(f"✅ committed {total} statements")
            tx = sess.begin_transaction()
    # 잔여분
    tx.commit(); total += len(stmts) % BATCH_SIZE

print(f"🎉 done!  {total} statements executed.")
driver.close()


emb = OpenAIEmbeddings(openai_api_key=key)

driver = GraphDatabase.driver(
    "bolt://localhost:7687",
    auth=("neo4j", "testtest")
)

BATCH = 128

with driver.session() as sess:
    sess.run("""
             MATCH (n)
             SET   n:Embeddable;
              """)
    sess.run("""
            CREATE VECTOR INDEX all_embedding IF NOT EXISTS
            FOR (n:Embeddable) ON (n.embedding)
            OPTIONS {
              indexConfig: {
                `vector.dimensions`: 1536,
                `vector.similarity_function`: 'cosine'
              }
            };
            """)
    while True:
        # ▶ 아직 embedding이 없는 노드 뽑기
        rows = sess.run("""
            MATCH (n:Embeddable)
            WHERE n.name IS NOT NULL AND n.embedding IS NULL
            RETURN elementId(n) AS id, n.name AS txt
            LIMIT $lim
        """, lim=BATCH).data()

        if not rows:
            print("🍀 done – all nodes embedded!")
            break

        texts = [r["txt"] for r in rows]
        vecs  = emb.embed_documents(texts)

        # ▶ 벡터 저장
        for r, v in zip(rows, vecs):
            sess.run("""
                MATCH (n) WHERE elementId(n)=$id
                SET n.embedding = $vec
            """, id=r["id"], vec=v)

        print(f"✅ embedded {len(rows)} nodes")