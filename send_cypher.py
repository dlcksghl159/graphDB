#!/usr/bin/env python3
"""
send_cypher.py
--------------
usage:
  python send_cypher.py
"""
import os
import re
from pathlib import Path

from neo4j import GraphDatabase, basic_auth
from langchain_openai import OpenAIEmbeddings
from dotenv import load_dotenv

load_dotenv()   
OPENAI_API_KEY = os.getenv("OPENAI_API_KEY")

# ── 0. Settings ───────────────────────────────────────────────────
OUTPUT_ROOT  = Path(os.getenv("OUTPUT_ROOT", "output"))
CY_FILE       = OUTPUT_ROOT / "graph.cypher"

NEO4J_URI   = os.getenv("NEO4J_URI",  "bolt://localhost:7687")
NEO4J_USER  = os.getenv("NEO4J_USER", "neo4j")
NEO4J_PASS  = os.getenv("NEO4J_PASSWORD", "testtest")

BATCH_SIZE  = 50   # how many data statements per transaction
EMBED_BATCH = 128  # how many nodes to embed per loop

# ── 1. Load & split Cypher file ───────────────────────────────────
text  = CY_FILE.read_text(encoding="utf-8")
blocks = [blk.strip() for blk in re.split(r"\n\s*\n", text) if blk.strip()]

print(f"📄  loaded {len(blocks)} Cypher statements from {CY_FILE}")

# Identify schema vs data statements
schema_prefixes = (
    "CREATE CONSTRAINT",
    "CREATE INDEX",
    "DROP CONSTRAINT",
    "DROP INDEX",
    "CREATE VECTOR INDEX",
)
schema_blocks = [b if b.endswith(";") else b + ";" 
                 for b in blocks 
                 if b.lstrip().upper().startswith(schema_prefixes)]
data_blocks   = [b if b.endswith(";") else b + ";" 
                 for b in blocks 
                 if b not in schema_blocks]

# ── 2. Connect to Neo4j ───────────────────────────────────────────
driver = GraphDatabase.driver(
    NEO4J_URI,
    auth=basic_auth(NEO4J_USER, NEO4J_PASS)
)

# ── 3. Apply schema statements (autocommit each) ─────────────────
with driver.session() as sess:
    for stmt in schema_blocks:
        sess.run(stmt)
    print(f"✅ Applied {len(schema_blocks)} schema statements.")

# ── 4. Apply data statements in batches ──────────────────────────
total = 0
with driver.session() as sess:
    tx = sess.begin_transaction()
    for i, stmt in enumerate(data_blocks, start=1):
        tx.run(stmt)
        # commit in batches
        if i % BATCH_SIZE == 0:
            tx.commit()
            total += BATCH_SIZE
            print(f"✅ Committed {total} data statements.")
            tx = sess.begin_transaction()
    # commit any leftover
    remaining = len(data_blocks) % BATCH_SIZE
    if remaining:
        tx.commit()
        total += remaining
        print(f"✅ Committed final {remaining} data statements.")
print(f"🎉 Done inserting data: {total} statements executed.")

# ── 5. Build embedding index & tag nodes ─────────────────────────
emb = OpenAIEmbeddings(openai_api_key=OPENAI_API_KEY)

with driver.session() as sess:
    # label all nodes Embeddable
    sess.run("""
        MATCH (n)
        SET n:Embeddable;
    """)
    # create vector index if missing
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

    # loop until all have embeddings
    while True:
        rows = sess.run("""
            MATCH (n:Embeddable)
            WHERE n.name IS NOT NULL AND n.embedding IS NULL
            RETURN elementId(n) AS id, n.name AS txt
            LIMIT $lim
        """, lim=EMBED_BATCH).data()

        if not rows:
            print("🍀 All nodes are now embedded!")
            break

        texts = [r["txt"] for r in rows]
        vecs  = emb.embed_documents(texts)

        # update each node
        for r, v in zip(rows, vecs):
            sess.run("""
                MATCH (n) WHERE elementId(n) = $id
                SET n.embedding = $vec
            """, id=r["id"], vec=v)
        print(f"✅ Embedded {len(rows)} nodes.")

driver.close()
