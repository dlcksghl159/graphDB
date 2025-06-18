import json
import argparse
import os
from pathlib import Path
from typing import Tuple, Set, Dict, List
import numpy as np
from openai import OpenAI
from difflib import SequenceMatcher
import time
from dotenv import load_dotenv
load_dotenv()
api_key = os.getenv("OPENAI_API_KEY")

###############################################################################
# 하이브리드 Knowledge Graph 평가 시스템
# ------------------------------------
# 노드 평가: OpenAI Embedding (의미적 유사성)
# 관계 평가: Python difflib (구조적 유사성)
#
# 사용법: python evaluate_kg_hybrid.py --gold movie_answer.json --pred result.json
###############################################################################

class HybridKGEvaluator:
    def __init__(self, api_key: str = None, embedding_model: str = "text-embedding-3-small", 
                 node_threshold: float = 0.8, relation_threshold: float = 0.8):
        """
        하이브리드 Knowledge Graph 평가기 초기화
        
        Args:
            api_key: OpenAI API 키
            embedding_model: OpenAI 임베딩 모델명
            node_threshold: 노드 유사성 임계값
            relation_threshold: 관계 유사성 임계값
        """
        # OpenAI 클라이언트 초기화 (노드 평가용)
        if api_key:
            self.client = OpenAI(api_key=api_key)
        else:
            self.client = OpenAI()  # 환경변수에서 자동 로드
        
        self.embedding_model = embedding_model
        self.node_threshold = node_threshold
        self.relation_threshold = relation_threshold
        
        print(f"=== 하이브리드 평가 시스템 초기화 ===")
        print(f"노드 평가: OpenAI Embedding ({embedding_model})")
        print(f"관계 평가: Python difflib")
        print(f"노드 임계값: {node_threshold}")
        print(f"관계 임계값: {relation_threshold}")
        print()
    
    # === OpenAI Embedding 관련 메서드 (노드 평가용) ===
    
    def get_embeddings_batch(self, texts: List[str]) -> List[List[float]]:
        """OpenAI API를 사용하여 배치로 임베딩 생성"""
        try:
            response = self.client.embeddings.create(
                input=texts,
                model=self.embedding_model
            )
            return [data.embedding for data in response.data]
        except Exception as e:
            print(f"임베딩 생성 중 오류 발생: {e}")
            return None
    
    def cosine_similarity(self, vec1: List[float], vec2: List[float]) -> float:
        """두 임베딩 벡터 간의 코사인 유사도 계산"""
        vec1 = np.array(vec1)
        vec2 = np.array(vec2)
        
        dot_product = np.dot(vec1, vec2)
        norm_vec1 = np.linalg.norm(vec1)
        norm_vec2 = np.linalg.norm(vec2)
        
        if norm_vec1 == 0 or norm_vec2 == 0:
            return 0.0
        
        return dot_product / (norm_vec1 * norm_vec2)
    
    def evaluate_nodes_with_embeddings(self, pred_node_texts: List[str], gold_node_texts: List[str]) -> List[Tuple[int, int, float]]:
        """OpenAI Embedding을 사용한 노드 매칭"""
        if not pred_node_texts or not gold_node_texts:
            return []
        
        print(f"  OpenAI 임베딩으로 노드 평가 중: 예측 {len(pred_node_texts)}개, 정답 {len(gold_node_texts)}개")
        
        # 배치로 임베딩 생성
        pred_embeddings = self.get_embeddings_batch(pred_node_texts)
        time.sleep(0.1)  # API 레이트 리미트 고려
        gold_embeddings = self.get_embeddings_batch(gold_node_texts)
        
        if pred_embeddings is None or gold_embeddings is None:
            return []
        
        # 유사도 계산 및 매칭
        similarities = []
        for i, pred_emb in enumerate(pred_embeddings):
            for j, gold_emb in enumerate(gold_embeddings):
                sim = self.cosine_similarity(pred_emb, gold_emb)
                if sim >= self.node_threshold:
                    similarities.append((i, j, sim))
        
        # 유사도 기준으로 정렬하여 최적 매칭
        similarities.sort(key=lambda x: x[2], reverse=True)
        
        matches = []
        used_pred = set()
        used_gold = set()
        
        for pred_idx, gold_idx, sim in similarities:
            if pred_idx not in used_pred and gold_idx not in used_gold:
                matches.append((pred_idx, gold_idx, sim))
                used_pred.add(pred_idx)
                used_gold.add(gold_idx)
        
        return matches
    
    # === Difflib 관련 메서드 (관계 평가용) ===
    
    def difflib_similarity(self, text1: str, text2: str) -> float:
        """difflib을 사용한 텍스트 유사도 계산"""
        return SequenceMatcher(None, text1.lower().strip(), text2.lower().strip()).ratio()
    
    def evaluate_relations_with_difflib(self, pred_rel_texts: List[str], gold_rel_texts: List[str]) -> List[Tuple[int, int, float]]:
        """difflib을 사용한 관계 매칭"""
        if not pred_rel_texts or not gold_rel_texts:
            return []
        
        print(f"  difflib으로 관계 평가 중: 예측 {len(pred_rel_texts)}개, 정답 {len(gold_rel_texts)}개")
        
        matches = []
        used_gold_indices = set()
        
        for pred_idx, pred_rel in enumerate(pred_rel_texts):
            best_match = (-1, 0.0)
            
            for gold_idx, gold_rel in enumerate(gold_rel_texts):
                if gold_idx not in used_gold_indices:
                    sim = self.difflib_similarity(pred_rel, gold_rel)
                    if sim >= self.relation_threshold and sim > best_match[1]:
                        best_match = (gold_idx, sim)
            
            if best_match[0] != -1:
                matches.append((pred_idx, best_match[0], best_match[1]))
                used_gold_indices.add(best_match[0])
        
        return matches


def load_json(path: Path) -> Dict:
    """JSON 파일 로드"""
    with path.open("r", encoding="utf-8") as f:
        return json.load(f)


def node_to_text(node: Dict) -> str:
    """노드를 비교 가능한 텍스트로 변환"""
    return f"{node['label']} {node['name']}"


def relation_to_text(rel: Dict) -> str:
    """관계를 비교 가능한 텍스트로 변환"""
    return f"{rel['start_node']} {rel['relationship']} {rel['end_node']}"


def prf(tp: int, pred: int, gold: int) -> Tuple[float, float, float]:
    """Precision, Recall, F1 계산"""
    prec = tp / pred if pred else 0.0
    rec = tp / gold if gold else 0.0
    if prec + rec == 0:
        f1 = 0.0
    else:
        f1 = 2 * prec * rec / (prec + rec)
    return prec, rec, f1


def evaluate_hybrid(gold: Dict, pred: Dict, evaluator: HybridKGEvaluator, verbose: bool = False):
    """하이브리드 방식으로 Knowledge Graph 평가 수행"""
    
    print("=" * 70)
    print("하이브리드 Knowledge Graph 평가 시작")
    print("=" * 70)
    
    # 텍스트 변환
    gold_node_texts = [node_to_text(n) for n in gold.get("nodes", [])]
    pred_node_texts = [node_to_text(n) for n in pred.get("nodes", [])]
    gold_rel_texts = [relation_to_text(r) for r in gold.get("relations", [])]
    pred_rel_texts = [relation_to_text(r) for r in pred.get("relations", [])]
    
    print(f"데이터 요약:")
    print(f"  정답 노드: {len(gold_node_texts)}개, 예측 노드: {len(pred_node_texts)}개")
    print(f"  정답 관계: {len(gold_rel_texts)}개, 예측 관계: {len(pred_rel_texts)}개")
    print()
    
    # 1. OpenAI Embedding으로 노드 평가
    print("1. 노드 평가 (OpenAI Embedding)")
    print("-" * 40)
    node_matches = evaluator.evaluate_nodes_with_embeddings(pred_node_texts, gold_node_texts)
    tp_nodes = len(node_matches)
    print(f"  매칭된 노드: {tp_nodes}개")
    
    # 2. difflib으로 관계 평가
    print("\n2. 관계 평가 (Python difflib)")
    print("-" * 40)
    rel_matches = evaluator.evaluate_relations_with_difflib(pred_rel_texts, gold_rel_texts)
    tp_rels = len(rel_matches)
    print(f"  매칭된 관계: {tp_rels}개")
    
    # 메트릭 계산
    node_prec, node_rec, node_f1 = prf(tp_nodes, len(pred_node_texts), len(gold_node_texts))
    rel_prec, rel_rec, rel_f1 = prf(tp_rels, len(pred_rel_texts), len(gold_rel_texts))
    
    # 결과 출력
    print("\n" + "=" * 70)
    print("=== 노드 평가 결과 (OpenAI Embedding) ===")
    print("=" * 70)
    print(f"정답 노드         : {len(gold_node_texts):4d}")
    print(f"예측 노드         : {len(pred_node_texts):4d}")
    print(f"매칭된 노드       : {tp_nodes:4d}")
    print(f"Precision        : {node_prec:.3f}")
    print(f"Recall           : {node_rec:.3f}")
    print(f"F1 Score         : {node_f1:.3f}")
    
    print("\n" + "=" * 70)
    print("=== 관계 평가 결과 (Python difflib) ===")
    print("=" * 70)
    print(f"정답 관계         : {len(gold_rel_texts):4d}")
    print(f"예측 관계         : {len(pred_rel_texts):4d}")
    print(f"매칭된 관계       : {tp_rels:4d}")
    print(f"Precision        : {rel_prec:.3f}")
    print(f"Recall           : {rel_rec:.3f}")
    print(f"F1 Score         : {rel_f1:.3f}")
    
    # 전체 요약
    overall_tp = tp_nodes + tp_rels
    overall_pred = len(pred_node_texts) + len(pred_rel_texts)
    overall_gold = len(gold_node_texts) + len(gold_rel_texts)
    overall_prec, overall_rec, overall_f1 = prf(overall_tp, overall_pred, overall_gold)
    
    print("\n" + "=" * 70)
    print("=== 전체 평가 결과 (노드 + 관계) ===")
    print("=" * 70)
    print(f"전체 정답         : {overall_gold:4d}")
    print(f"전체 예측         : {overall_pred:4d}")
    print(f"전체 매칭         : {overall_tp:4d}")
    print(f"Overall Precision : {overall_prec:.3f}")
    print(f"Overall Recall    : {overall_rec:.3f}")
    print(f"Overall F1 Score  : {overall_f1:.3f}")
    
    if verbose:
        print("\n" + "=" * 70)
        print("=== 상세 매칭 결과 ===")
        print("=" * 70)
        
        # 노드 매칭 상세 결과
        if node_matches:
            print(f"\n--- OpenAI Embedding으로 매칭된 노드들 ({len(node_matches)}개) ---")
            for i, (pred_idx, gold_idx, sim) in enumerate(node_matches, 1):
                print(f"{i:2d}. 유사도 {sim:.3f}: '{pred_node_texts[pred_idx]}' ↔ '{gold_node_texts[gold_idx]}'")
        
        # 매칭되지 않은 노드들
        matched_pred_nodes = {match[0] for match in node_matches}
        fp_node_indices = set(range(len(pred_node_texts))) - matched_pred_nodes
        if fp_node_indices:
            print(f"\n--- 매칭되지 않은 예측 노드들 (FP: {len(fp_node_indices)}개) ---")
            for i, idx in enumerate(sorted(fp_node_indices), 1):
                print(f"{i:2d}. '{pred_node_texts[idx]}'")
        
        matched_gold_nodes = {match[1] for match in node_matches}
        fn_node_indices = set(range(len(gold_node_texts))) - matched_gold_nodes
        if fn_node_indices:
            print(f"\n--- 매칭되지 않은 정답 노드들 (FN: {len(fn_node_indices)}개) ---")
            for i, idx in enumerate(sorted(fn_node_indices), 1):
                print(f"{i:2d}. '{gold_node_texts[idx]}'")
        
        # 관계 매칭 상세 결과
        if rel_matches:
            print(f"\n--- difflib으로 매칭된 관계들 ({len(rel_matches)}개) ---")
            for i, (pred_idx, gold_idx, sim) in enumerate(rel_matches, 1):
                print(f"{i:2d}. 유사도 {sim:.3f}: '{pred_rel_texts[pred_idx]}' ↔ '{gold_rel_texts[gold_idx]}'")
        
        # 매칭되지 않은 관계들
        matched_pred_rels = {match[0] for match in rel_matches}
        fp_rel_indices = set(range(len(pred_rel_texts))) - matched_pred_rels
        if fp_rel_indices:
            print(f"\n--- 매칭되지 않은 예측 관계들 (FP: {len(fp_rel_indices)}개) ---")
            for i, idx in enumerate(sorted(fp_rel_indices), 1):
                print(f"{i:2d}. '{pred_rel_texts[idx]}'")
        
        matched_gold_rels = {match[1] for match in rel_matches}
        fn_rel_indices = set(range(len(gold_rel_texts))) - matched_gold_rels
        if fn_rel_indices:
            print(f"\n--- 매칭되지 않은 정답 관계들 (FN: {len(fn_rel_indices)}개) ---")
            for i, idx in enumerate(sorted(fn_rel_indices), 1):
                print(f"{i:2d}. '{gold_rel_texts[idx]}'")
    
    print("\n" + "=" * 70)
    print("하이브리드 평가 완료!")
    print("=" * 70)


def main():
    parser = argparse.ArgumentParser(description="하이브리드 Knowledge Graph 평가 (노드: OpenAI, 관계: difflib)")
    parser.add_argument("--gold", required=True, help="정답 JSON 파일 경로")
    parser.add_argument("--pred", required=True, help="예측 JSON 파일 경로")
    parser.add_argument("-v", "--verbose", action="store_true", help="상세 매칭 결과 표시")
    parser.add_argument("--node-threshold", type=float, default=0.8, help="노드 유사성 임계값")
    parser.add_argument("--relation-threshold", type=float, default=0.8, help="관계 유사성 임계값")
    parser.add_argument("--embedding-model", default="text-embedding-3-small", 
                       help="OpenAI embedding 모델")
    parser.add_argument("--api-key", help="OpenAI API 키")
    
    args = parser.parse_args()
    

    
    try:
        # 데이터 로드
        print("데이터 로드 중...")
        gold = load_json(Path(args.gold))
        pred = load_json(Path(args.pred))
        
        # 하이브리드 평가기 초기화
        evaluator = HybridKGEvaluator(
            api_key=args.api_key,
            embedding_model=args.embedding_model,
            node_threshold=args.node_threshold,
            relation_threshold=args.relation_threshold
        )
        
        # 평가 수행
        evaluate_hybrid(gold, pred, evaluator, verbose=args.verbose)
        
    except FileNotFoundError as e:
        print(f"오류: 파일을 찾을 수 없습니다 - {e}")
    except json.JSONDecodeError as e:
        print(f"오류: JSON 파일 파싱 실패 - {e}")
    except Exception as e:
        print(f"오류: {e}")


if __name__ == "__main__":
    main()
