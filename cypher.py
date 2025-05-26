import json
import os
import re
from typing import Dict, List, Tuple

###############################################
# Cypher generation for Neo4j (robust version)
# ---------------------------------------------
# • Nodes/edges are **MERGE**d (idempotent).
# • Unique constraints on :Label(name) are added
#   (CREATE CONSTRAINT IF NOT EXISTS ...).
# • ON CREATE / ON MATCH keeps properties synced.
# • Relationships are MERGEd with optional props.
###############################################

def escape(value: str) -> str:
    """Escape single quotes for Cypher string."""
    return value.replace("'", "\\'")


def fmt_prop_pair(key: str, val) -> str:
    if isinstance(val, str):
        return f"{key}: '{escape(val)}'"
    return f"{key}: {json.dumps(val, ensure_ascii=False)}"


def merge_node(label: str, name: str, props: Dict[str, str]) -> str:
    """Generate idempotent node MERGE block with ON CREATE / ON MATCH SET."""
    base = f"MERGE (n:{label} {{name: '{escape(name)}'}})"
    if props:
        prop_pairs = [fmt_prop_pair(k, v) for k, v in props.items() if k != "name"]
        if prop_pairs:
            sets = ", ".join([f"n.{p}" for p in prop_pairs])
            return f"{base}\n  ON CREATE SET {sets}\n  ON MATCH  SET {sets};"
    return base + ";"


def merge_relation(
    start_label: str,
    start_name: str,
    end_label: str,
    end_name: str,
    rel_type: str,
    props: Dict[str, str],
) -> str:
    """Generate relation MERGE block between two matched nodes."""
    match = (
        f"MATCH (a:{start_label} {{name: '{escape(start_name)}'}}),"
        f"      (b:{end_label}   {{name: '{escape(end_name)}'}})"
    )
    prop_pairs = [fmt_prop_pair(k, v) for k, v in props.items()]
    prop_set = ", ".join([f"r.{p}" for p in prop_pairs]) if prop_pairs else ""
    merge = f"MERGE (a)-[r:{rel_type}]->(b)"
    if prop_set:
        merge += f"\n  ON CREATE SET {prop_set}\n  ON MATCH  SET {prop_set}"
    return "\n".join(match) + "\n" + merge + ";"


def generate_cypher_blocks(graph_json: Dict) -> List[str]:
    """Convert parsed JSON G( nodes + relations ) -> Cypher blocks."""
    blocks: List[str] = []

    # 1) constraints (unique name per label)
    labels = {node["label"] for node in graph_json.get("nodes", [])}
    blocks.extend(
        [
            f"CREATE CONSTRAINT IF NOT EXISTS FOR (n:{lbl}) REQUIRE n.name IS UNIQUE;"
            for lbl in sorted(labels)
        ]
    )

    # 2) nodes
    for node in graph_json.get("nodes", []):
        blocks.append(
            merge_node(node["label"], node["name"].strip(), node.get("properties", {}))
        )

    # Build name ➜ label index for fast lookup
    name2label = {n["name"].strip(): n["label"] for n in graph_json.get("nodes", [])}

    # 3) relations
    for rel in graph_json.get("relations", []):
        start_name = rel["start_node"].strip()
        end_name = rel["end_node"].strip()
        rel_type = rel["relationship"]
        props = rel.get("properties", {})

        start_label = name2label.get(start_name, "") or "_UNSPEC"
        end_label = name2label.get(end_name, "") or "_UNSPEC"

        blocks.append(
            merge_relation(start_label, start_name, end_label, end_name, rel_type, props)
        )

    return blocks


def generate_cypher_file(json_path: str, output_path: str) -> None:
    with open(json_path, "r", encoding="utf-8") as f:
        data = json.load(f)

    cypher_blocks = generate_cypher_blocks(data)

    with open(output_path, "w", encoding="utf-8") as f:
        f.write("\n\n".join(cypher_blocks))

    print(f"✅ Cypher script saved ➜ {output_path}  (blocks: {len(cypher_blocks)})")


def main():
    OUTPUT_ROOT = os.getenv("OUTPUT_ROOT", "output")
    json_in = os.path.join(OUTPUT_ROOT, "result", "result.json")
    cypher_out = os.path.join(OUTPUT_ROOT, "graph.cypher")

    if not os.path.exists(json_in):
        raise FileNotFoundError(f"Input graph not found: {json_in}")

    generate_cypher_file(json_in, cypher_out)


if __name__ == "__main__":
    main()
