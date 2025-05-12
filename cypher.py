import json
import re

def sanitize_alias(name):
    return re.sub(r'[^a-zA-Z0-9]', '', name.title().replace(" ", ""))

def cypher_escape(value):
    return value.replace("'", "\\'")

def generate_create_match_cypher(json_path: str, output_path: str):
    with open(json_path, "r", encoding="utf-8") as f:
        data = json.load(f)

    cypher_blocks = []

    # 노드 생성 (CREATE)
    for node in data["nodes"]:
        label = node["label"]
        name = node["name"].strip()
        props = node.get("properties", {})
        props["name"] = name
        props_str = ", ".join(
            [f"{k}: '{cypher_escape(str(v))}'" if isinstance(v, str) else f"{k}: {v}" for k, v in props.items()]
        )
        cypher_blocks.append(f"CREATE (:{label} {{{props_str}}});")

    # 관계 생성 (MATCH + CREATE)
    for rel in data["relations"]:
        start_name = rel["start_node"].strip()
        end_name = rel["end_node"].strip()
        rel_type = rel["relationship"]

        rel_block = (
            f"MATCH (a), (b)\n"
            f"WHERE a.name = '{cypher_escape(start_name)}' AND b.name = '{cypher_escape(end_name)}'\n"
            f"CREATE (a)-[:{rel_type} {{name: a.name + '<->' + b.name}}]->(b);"
        )
        cypher_blocks.append(rel_block)

    # 파일로 저장
    full_query = "\n\n".join(cypher_blocks)
    with open(output_path, "w", encoding="utf-8") as f:
        f.write(full_query)

    print("✅ Cypher 쿼리가 'output.cypher'에 저장되었습니다.")

generate_create_match_cypher("./output/result/result_naive.json", "./output/output.cypher")

