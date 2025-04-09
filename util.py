import re
import json


import json
import re

def merge_json(
    old_schema: dict,
    new_schema: dict,
    node_key=("label",),  # 예: ("label",) 또는 ("label", "name")
) -> dict:
    # --- 노드 병합 ---
    def build_node_dict(nodes):
        result = {}
        for node in nodes:
            try:
                key = tuple(node[k] for k in node_key)
            except KeyError:
                continue  # 필수 병합 키가 없으면 생략

            properties = node.get("properties", {})
            if key in result:
                result[key].update(properties)
            else:
                result[key] = properties.copy()
        return result

    old_nodes = build_node_dict(old_schema.get("nodes", []))
    new_nodes = build_node_dict(new_schema.get("nodes", []))
    all_keys = set(old_nodes.keys()).union(new_nodes.keys())

    merged_nodes = []
    for key in all_keys:
        merged_props = {**old_nodes.get(key, {}), **new_nodes.get(key, {})}

        # old/new 스키마에서 name을 찾아서 유지
        old_node = next((n for n in old_schema.get("nodes", []) if tuple(n.get(k) for k in node_key) == key), {})
        new_node = next((n for n in new_schema.get("nodes", []) if tuple(n.get(k) for k in node_key) == key), {})
        name = old_node.get("name") or new_node.get("name") or ""

        node = {k: v for k, v in zip(node_key, key)}
        node["name"] = name  # 항상 name 포함
        node["properties"] = merged_props
        merged_nodes.append(node)

    # --- 관계 병합 ---
    def rel_key(rel):
        return (rel["start_node"], rel["relationship"], rel["end_node"])

    old_rels_dict = {rel_key(r): r.get("properties", {}) for r in old_schema.get("relations", [])}
    new_rels_dict = {rel_key(r): r.get("properties", {}) for r in new_schema.get("relations", [])}
    all_rel_keys = set(old_rels_dict.keys()).union(new_rels_dict.keys())

    merged_relations = []
    for key in all_rel_keys:
        start_node, relationship, end_node = key
        merged_props = {**old_rels_dict.get(key, {}), **new_rels_dict.get(key, {})}
        merged_relations.append({
            "start_node": start_node,
            "relationship": relationship,
            "end_node": end_node,
            "properties": merged_props
        })

    return {
        "nodes": merged_nodes,
        "relations": merged_relations
    }



def parse_json(gpt_output):
    # JSON 구조 감지 및 추출 (전체 JSON 블록을 greedy하게 탐지)
    match = re.search(r'\{\s*"nodes"\s*:\s*\[.*\],\s*"relations"\s*:\s*\[.*\]\s*\}', gpt_output, re.DOTALL)

    parsed_json = {}

    if match:
        json_data = match.group()
        
        # JSON 정리 (불필요한 공백, 줄 바꿈 제거 가능)
        json_data = json_data.strip()

        try:
            # JSON 문자열을 딕셔너리로 파싱
            parsed_json = json.loads(json_data)
        except json.JSONDecodeError as e:
            print("❌ JSON 파싱 실패:", e)
            print("⚠️ 추출된 JSON 원본:\n", json_data)
    else:
        print("❌ JSON 구조가 감지되지 않음")
        print("⚠️ GPT 출력 원문:\n", gpt_output)
    
    return parsed_json
