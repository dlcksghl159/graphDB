import re
import json


import json
import re

def merge_json(
    old_schema: dict,
    new_schema: dict,
    node_key=("label",),  # 예: ("label",) 또는 ("label", "name")
) -> dict:
    print("🔗 JSON 병합 시작...")
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
    print("🔗 JSON 병합 완료")
    return {
        "nodes": merged_nodes,
        "relations": merged_relations
    }


import re
import json

def parse_json(gpt_output: str) -> dict:
    """
    GPT 출력 중에서 JSON 블록을 자동으로 탐지하여 파싱한 후 dict로 반환.
    - ```json ... ``` 코드블록 우선 탐지
    - 없으면 첫 '{' 위치부터 JSONDecoder.raw_decode 시도
    - 그래도 실패 시 마지막 '}'까지 슬라이싱 후 json.loads
    """
    # 1) ```json ... ``` 또는 ``` ... ``` 블록 탐지
    fence_pattern = r'```(?:json)?\s*(\{[\s\S]*?\})\s*```'
    fence_match = re.search(fence_pattern, gpt_output, re.IGNORECASE)
    if fence_match:
        json_str = fence_match.group(1)
    else:
        # 2) raw_decode 로 파싱 가능한 구간 자동 탐지
        start = gpt_output.find("{")
        if start == -1:
            print("❌ JSON 구조가 전혀 감지되지 않음")
            return {}
        decoder = json.JSONDecoder()
        try:
            obj, idx = decoder.raw_decode(gpt_output[start:])
            return obj
        except json.JSONDecodeError:
            # 3) 마지막 '}'까지 잘라서 재시도
            end = gpt_output.rfind("}")
            if end == -1 or end <= start:
                print("❌ 유효한 '}'를 찾을 수 없음")
                return {}
            json_str = gpt_output[start:end+1]

    # 공백·줄바꿈 정리
    json_str = json_str.strip()

    try:
        return json.loads(json_str)
    except json.JSONDecodeError as e:
        print(f"❌ JSON 파싱 실패: {e}")
        print("⚠️ 추출된 JSON 원본:\n", json_str)
        return {}
