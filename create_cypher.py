# generate_cypher.py  (Python 3.9+)
import json
import os
from typing import Any, Dict, List

###############################################
# JSON → Cypher blocks (robust)
###############################################

def cypher_escape(val: str) -> str:
    """
    문자열을 Cypher literal 로 안전하게 변환
    1) json.dumps() 로 기본 특수문자 처리
    2) 양쪽 큰따옴표 제거
    3) 남은 작은따옴표 → \'
    """
    s = json.dumps(val, ensure_ascii=False)[1:-1]
    return s.replace("'", "\\'")


def _literal(x: Any) -> str:
    """Python 값 → Cypher literal (문자열 제외)."""
    if isinstance(x, bool):
        return "true" if x else "false"
    if x is None:
        return "null"
    return str(x)


def fmt_prop_pair(key: str, val: Any) -> str:
    """
    값 유형별 Cypher 표현
      • str               → '문자열'
      • int/float/bool    → 123 / true
      • None              → null
      • list[primitive]   → [1,'a',true]
      • dict / 복합 list  → '{"json":"string"}'
    """
    # 1) 문자열
    if isinstance(val, str):
        return f"{key} = '{cypher_escape(val)}'"

    # 2) 숫자 · 불리언 · None
    if isinstance(val, (int, float, bool)) or val is None:
        return f"{key} = {_literal(val)}"

    # 3) 리스트
    if isinstance(val, list):
        # 모든 원소가 원시 값이면 list literal 사용
        if all(
            isinstance(x, (str, int, float, bool)) or x is None
            for x in val
        ):
            elems = ", ".join(
                f"'{cypher_escape(x)}'" if isinstance(x, str) else _literal(x)
                for x in val
            )
            return f"{key} = [{elems}]"

    # 4) 딕셔너리 · 복합 리스트 → JSON 문자열로 보관
    json_str = cypher_escape(json.dumps(val, ensure_ascii=False))
    return f"{key} = '{json_str}'"


def merge_node(label: str, name: str, props: Dict) -> str:
    base = f"MERGE (n:`{label}` {{name:'{cypher_escape(name)}'}})"
    prop_pairs = [fmt_prop_pair(k, v) for k, v in props.items() if k != "name"]
    if prop_pairs:
        sets = ", ".join(f"n.{pair}" for pair in prop_pairs)
        return f"{base}\n  ON CREATE SET {sets}\n  ON MATCH  SET {sets};"
    return base + ";"


def merge_relation(
    a_label: str, a_name: str,
    b_label: str, b_name: str,
    rel_type: str,
    props: Dict
) -> str:
    match = (
        f"MATCH (a:`{a_label}` {{name:'{cypher_escape(a_name)}'}}),\n"
        f"      (b:`{b_label}` {{name:'{cypher_escape(b_name)}'}})"
    )
    merge = f"MERGE (a)-[r:`{rel_type}`]->(b)"
    prop_pairs = [fmt_prop_pair(k, v) for k, v in props.items()]
    if prop_pairs:
        sets = ", ".join(f"r.{p}" for p in prop_pairs)
        merge += f"\n  ON CREATE SET {sets}\n  ON MATCH  SET {sets}"
    return match + "\n" + merge + ";"


def generate_cypher_blocks(g: Dict) -> List[str]:
    blocks: List[str] = []

    # 1) unique constraints
    labels = {n["label"] for n in g.get("nodes", [])}
    blocks += [
        f"CREATE CONSTRAINT IF NOT EXISTS FOR (n:`{lbl}`) REQUIRE n.name IS UNIQUE;"
        for lbl in sorted(labels)
    ]

    # 2) nodes
    for n in g.get("nodes", []):
        blocks.append(
            merge_node(n["label"], n["name"].strip(), n.get("properties", {}))
        )

    # map name → label
    name2label = {n["name"].strip(): n["label"] for n in g.get("nodes", [])}

    # 3) relations
    for r in g.get("relations", []):
        a = r["start_node"].strip()
        b = r["end_node"].strip()
        blocks.append(
            merge_relation(
                name2label.get(a, "_UNSPEC"), a,
                name2label.get(b, "_UNSPEC"), b,
                r["relationship"],
                r.get("properties", {})
            )
        )
    return blocks


def generate_cypher_file(json_path: str, cypher_out: str) -> None:
    with open(json_path, encoding="utf-8") as f:
        g = json.load(f)

    blocks = generate_cypher_blocks(g)

    # 두 줄 개행으로만 구분 (세미콜론 split 문제 방지)
    with open(cypher_out, "w", encoding="utf-8") as f:
        f.write("\n\n".join(blocks))

    print(f"✅ Cypher script saved → {cypher_out}  (blocks: {len(blocks)})")


def main():
    root = os.getenv("OUTPUT_ROOT", "output")
    json_in = os.path.join(root, "result", "result.json")
    cypher_out = os.path.join(root, "graph.cypher")
    if not os.path.exists(json_in):
        raise FileNotFoundError(json_in)
    generate_cypher_file(json_in, cypher_out)


if __name__ == "__main__":
    main()
