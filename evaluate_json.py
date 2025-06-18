import json
import os
import time
import argparse
import numpy as np
from pathlib import Path
from typing import Tuple, List, Dict
from openai import OpenAI
from difflib import SequenceMatcher
from dotenv import load_dotenv

###############################################################################
# 하이브리드 KG 평가 (노드: OpenAI Embedding, 관계: difflib)
# ——————————————————————————————————————————————
# 사용 전: 프로젝트 루트에 .env 파일에 OPENAI_API_KEY 설정
# 설치: pip install openai numpy python-dotenv
###############################################################################

# 1) .env에서 API 키 로드
load_dotenv()  
api_key = os.getenv("OPENAI_API_KEY")  
if not api_key:
    raise RuntimeError("`.env`에 설정된 OPENAI_API_KEY를 찾을 수 없습니다.")  # 환경 변수 필수[3]

class CoverageEvaluator:
    def __init__(self,
                 api_key: str,
                 embedding_model: str = "text-embedding-3-small",
                 node_threshold: float = 0.8,
                 relation_threshold: float = 0.8):
        # OpenAI 클라이언트 초기화
        self.client = OpenAI(api_key=api_key)  
        self.embedding_model = embedding_model
        self.node_threshold = node_threshold
        self.relation_threshold = relation_threshold

    def get_embeddings(self, texts: List[str]) -> List[List[float]]:
        resp = self.client.embeddings.create(input=texts,
                                             model=self.embedding_model)
        return [d.embedding for d in resp.data]

    def cosine_sim(self, v1: List[float], v2: List[float]) -> float:
        a, b = np.array(v1), np.array(v2)
        if np.linalg.norm(a)==0 or np.linalg.norm(b)==0:
            return 0.0
        return float(np.dot(a, b) / (np.linalg.norm(a) * np.linalg.norm(b)))

    def match_nodes(self,
                    pred_texts: List[str],
                    gold_texts: List[str]) -> List[Tuple[int,int,float]]:
        if not pred_texts or not gold_texts:
            return []
        pred_emb = self.get_embeddings(pred_texts); time.sleep(0.1)
        gold_emb = self.get_embeddings(gold_texts)
        sims = []
        for i, pe in enumerate(pred_emb):
            for j, ge in enumerate(gold_emb):
                sim = self.cosine_sim(pe, ge)
                if sim >= self.node_threshold:
                    sims.append((i, j, sim))
        sims.sort(key=lambda x: x[2], reverse=True)
        used_p, used_g = set(), set(); matches = []
        for i, j, s in sims:
            if i not in used_p and j not in used_g:
                matches.append((i, j, s))
                used_p.add(i); used_g.add(j)
        return matches

    def match_relations(self,
                        pred_texts: List[str],
                        gold_texts: List[str]) -> List[Tuple[int,int,float]]:
        matches = []; used_g = set()
        for i, p in enumerate(pred_texts):
            best_j, best_s = -1, 0.0
            for j, g in enumerate(gold_texts):
                if j in used_g: continue
                s = SequenceMatcher(None, p.lower().strip(),
                                    g.lower().strip()).ratio()
                if s >= self.relation_threshold and s > best_s:
                    best_j, best_s = j, s
            if best_j >= 0:
                matches.append((i, best_j, best_s))
                used_g.add(best_j)
        return matches

def node_to_text(n: Dict) -> str:
    return f"{n['label'].strip()} {n['name'].strip()}"

def rel_to_text(r: Dict) -> str:
    return f"{r['start_node'].strip()} {r['relationship'].strip()} {r['end_node'].strip()}"

def compute_coverage(matches: List[Tuple[int,int,float]], total_gold: int) -> float:
    gold_idxs = {g for _, g, _ in matches}
    return len(gold_idxs) / total_gold if total_gold else 0.0

def main():
    p = argparse.ArgumentParser()
    p.add_argument("--gold", required=True, help="Gold JSON 파일 경로")
    p.add_argument("--pred", required=True, help="Pred JSON 파일 경로")
    p.add_argument("--node-threshold", type=float, default=0.8,
                   help="노드 유사성 임계값")
    p.add_argument("--relation-threshold", type=float, default=0.8,
                   help="관계 유사성 임계값")
    args = p.parse_args()

    gold = json.loads(Path(args.gold).read_text(encoding="utf-8"))
    pred = json.loads(Path(args.pred).read_text(encoding="utf-8"))

    gold_nodes = [node_to_text(n) for n in gold.get("nodes", [])]
    pred_nodes = [node_to_text(n) for n in pred.get("nodes", [])]
    gold_rels  = [rel_to_text(r) for r in gold.get("relations", [])]
    pred_rels  = [rel_to_text(r) for r in pred.get("relations", [])]

    ev = CoverageEvaluator(api_key=api_key,
                           node_threshold=args.node_threshold,
                           relation_threshold=args.relation_threshold)

    node_matches = ev.match_nodes(pred_nodes, gold_nodes)
    rel_matches  = ev.match_relations(pred_rels, gold_rels)

    node_cov = compute_coverage(node_matches, len(gold_nodes))
    rel_cov  = compute_coverage(rel_matches,  len(gold_rels))
    total_gold = len(gold_nodes) + len(gold_rels)
    total_matched = len({g for _,g,_ in node_matches}) \
                    + len({g for _,g,_ in rel_matches})
    overall_cov = total_matched / total_gold if total_gold else 0.0

    # 출력
    print(f"노드 Coverage (Gold 대비): {node_cov:.3f}")
    print(f"관계 Coverage (Gold 대비): {rel_cov:.3f}")
    print(f"전체 Coverage (노드+관계): {overall_cov:.3f}")

if __name__ == "__main__":
    main()
