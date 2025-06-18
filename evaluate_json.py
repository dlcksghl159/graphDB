import json
import argparse
import os
from pathlib import Path
from typing import Tuple, Set, Dict, List
import numpy as np
from openai import OpenAI
from dotenv import load_dotenv
import time
load_dotenv()
api_key = os.getenv("OPENAI_API_KEY")
###############################################################################
# OpenAI Embedding 기반 Knowledge Graph 평가 시스템
# ------------------------------------------------
# 사용법: python evaluate_kg_openai.py --gold movie_answer.json --pred result.json --threshold 0.8
#
# 평가 지표:
#   • Node precision / recall / F1 (OpenAI embedding 유사성 기반)
#   • Relation precision / recall / F1 (OpenAI embedding 유사성 기반)
#   • 상세한 매칭 결과 (선택적 플래그)
###############################################################################

class OpenAIEmbeddingEvaluator:
    def __init__(self, api_key: str = None, model: str = "text-embedding-3-small", threshold: float = 0.8):
        """
        OpenAI Embedding 기반 평가기 초기화
        
        Args:
            api_key: OpenAI API 키 (환경변수에서 자동 로드)
            model: 사용할 OpenAI embedding 모델
            threshold: 유사성 임계값 (0.0-1.0)
        """
        # API 키 설정
        if api_key:
            self.client = OpenAI(api_key=api_key)
        else:
            # 환경변수에서 자동으로 로드
            self.client = OpenAI()
        
        self.model = model
        self.threshold = threshold
        
        print(f"OpenAI Embedding 모델: {model}")
        print(f"유사성 임계값: {threshold}")
    
    def get_embedding(self, text: str) -> List[float]:
        """단일 텍스트의 임베딩 벡터 생성"""
        try:
            response = self.client.embeddings.create(
                input=text,
                model=self.model
            )
            return response.data[0].embedding
        except Exception as e:
            print(f"임베딩 생성 중 오류 발생: {e}")
            return None
    
    def get_embeddings_batch(self, texts: List[str]) -> List[List[float]]:
        """여러 텍스트의 임베딩 벡터를 배치로 생성"""
        try:
            response = self.client.embeddings.create(
                input=texts,
                model=self.model
            )
            return [data.embedding for data in response.data]
        except Exception as e:
            print(f"배치 임베딩 생성 중 오류 발생: {e}")
            return None
    
    def cosine_similarity(self, vec1: List[float], vec2: List[float]) -> float:
        """두 벡터 간의 코사인 유사도 계산"""
        vec1 = np.array(vec1)
        vec2 = np.array(vec2)
        
        dot_product = np.dot(vec1, vec2)
        norm_vec1 = np.linalg.norm(vec1)
        norm_vec2 = np.linalg.norm(vec2)
        
        if norm_vec1 == 0 or norm_vec2 == 0:
            return 0.0
        
        return dot_product / (norm_vec1 * norm_vec2)
    
    def find_best_matches(self, pred_texts: List[str], gold_texts: List[str]) -> List[Tuple[int, int, float]]:
        """
        예측 텍스트와 정답 텍스트 간의 최적 매칭 찾기
        
        Returns:
            List of (pred_index, gold_index, similarity_score) tuples
        """
        if not pred_texts or not gold_texts:
            return []
        
        print(f"  임베딩 생성 중: 예측 {len(pred_texts)}개, 정답 {len(gold_texts)}개...")
        
        # 배치로 임베딩 생성 (API 호출 최적화)
        pred_embeddings = self.get_embeddings_batch(pred_texts)
        time.sleep(0.1)  # API 레이트 리미트 고려
        gold_embeddings = self.get_embeddings_batch(gold_texts)
        
        if pred_embeddings is None or gold_embeddings is None:
            return []
        
        print("  유사도 계산 및 매칭 중...")
        
        # 모든 조합의 유사도 계산
        similarities = []
        for i, pred_emb in enumerate(pred_embeddings):
            for j, gold_emb in enumerate(gold_embeddings):
                sim = self.cosine_similarity(pred_emb, gold_emb)
                if sim >= self.threshold:
                    similarities.append((i, j, sim))
        
        # 유사도 기준으로 정렬 (높은 순)
        similarities.sort(key=lambda x: x[2], reverse=True)
        
        # 탐욕적 매칭 (각 항목은 최대 한 번만 매칭)
        matches = []
        used_pred = set()
        used_gold = set()
        
        for pred_idx, gold_idx, sim in similarities:
            if pred_idx not in used_pred and gold_idx not in used_gold:
                matches.append((pred_idx, gold_idx, sim))
                used_pred.add(pred_idx)
                used_gold.add(gold_idx)
        
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


def evaluate_with_openai_embeddings(gold: Dict, pred: Dict, evaluator: OpenAIEmbeddingEvaluator, verbose: bool = False):
    """OpenAI Embedding을 사용한 Knowledge Graph 평가"""
    
    print("=" * 60)
    print("OpenAI Embedding 기반 Knowledge Graph 평가 시작")
    print("=" * 60)
    
    # 노드들을 텍스트로 변환
    gold_node_texts = [node_to_text(n) for n in gold.get("nodes", [])]
    pred_node_texts = [node_to_text(n) for n in pred.get("nodes", [])]
    
    # 관계들을 텍스트로 변환
    gold_rel_texts = [relation_to_text(r) for r in gold.get("relations", [])]
    pred_rel_texts = [relation_to_text(r) for r in pred.get("relations", [])]
    
    print(f"정답 노드: {len(gold_node_texts)}개, 예측 노드: {len(pred_node_texts)}개")
    print(f"정답 관계: {len(gold_rel_texts)}개, 예측 관계: {len(pred_rel_texts)}개")
    print()
    
    # 노드 매칭
    print("노드 매칭 수행 중...")
    node_matches = evaluator.find_best_matches(pred_node_texts, gold_node_texts)
    tp_nodes = len(node_matches)
    print(f"  매칭된 노드: {tp_nodes}개")
    
    # 관계 매칭
    print("\n관계 매칭 수행 중...")
    rel_matches = evaluator.find_best_matches(pred_rel_texts, gold_rel_texts)
    tp_rels = len(rel_matches)
    print(f"  매칭된 관계: {tp_rels}개")
    
    # 메트릭 계산
    node_prec, node_rec, node_f1 = prf(tp_nodes, len(pred_node_texts), len(gold_node_texts))
    rel_prec, rel_rec, rel_f1 = prf(tp_rels, len(pred_rel_texts), len(gold_rel_texts))
    
    # 결과 출력
    print("\n" + "=" * 60)
    print("=== OpenAI Embedding 기반 노드 평가 결과 ===")
    print("=" * 60)
    print(f"정답 노드      : {len(gold_node_texts):4d}")
    print(f"예측 노드      : {len(pred_node_texts):4d}")
    print(f"매칭된 노드    : {tp_nodes:4d}")
    print(f"Precision     : {node_prec:.3f}")
    print(f"Recall        : {node_rec:.3f}")
    print(f"F1 Score      : {node_f1:.3f}")
    
    print("\n" + "=" * 60)
    print("=== OpenAI Embedding 기반 관계 평가 결과 ===")
    print("=" * 60)
    print(f"정답 관계      : {len(gold_rel_texts):4d}")
    print(f"예측 관계      : {len(pred_rel_texts):4d}")
    print(f"매칭된 관계    : {tp_rels:4d}")
    print(f"Precision     : {rel_prec:.3f}")
    print(f"Recall        : {rel_rec:.3f}")
    print(f"F1 Score      : {rel_f1:.3f}")
    
    if verbose:
        print("\n" + "=" * 60)
        print("=== 상세 매칭 결과 ===")
        print("=" * 60)
        
        # 매칭된 노드들
        if node_matches:
            print(f"\n--- 매칭된 노드들 ({len(node_matches)}개) ---")
            for i, (pred_idx, gold_idx, sim) in enumerate(node_matches, 1):
                print(f"{i:2d}. 유사도 {sim:.3f}: '{pred_node_texts[pred_idx]}' ↔ '{gold_node_texts[gold_idx]}'")
        
        # 매칭되지 않은 예측 노드들 (False Positives)
        matched_pred_nodes = {match[0] for match in node_matches}
        fp_node_indices = set(range(len(pred_node_texts))) - matched_pred_nodes
        if fp_node_indices:
            print(f"\n--- 매칭되지 않은 예측 노드들 (FP: {len(fp_node_indices)}개) ---")
            for i, idx in enumerate(sorted(fp_node_indices), 1):
                print(f"{i:2d}. '{pred_node_texts[idx]}'")
        
        # 매칭되지 않은 정답 노드들 (False Negatives)
        matched_gold_nodes = {match[1] for match in node_matches}
        fn_node_indices = set(range(len(gold_node_texts))) - matched_gold_nodes
        if fn_node_indices:
            print(f"\n--- 매칭되지 않은 정답 노드들 (FN: {len(fn_node_indices)}개) ---")
            for i, idx in enumerate(sorted(fn_node_indices), 1):
                print(f"{i:2d}. '{gold_node_texts[idx]}'")
        
        # 매칭된 관계들
        if rel_matches:
            print(f"\n--- 매칭된 관계들 ({len(rel_matches)}개) ---")
            for i, (pred_idx, gold_idx, sim) in enumerate(rel_matches, 1):
                print(f"{i:2d}. 유사도 {sim:.3f}: '{pred_rel_texts[pred_idx]}' ↔ '{gold_rel_texts[gold_idx]}'")
        
        # 매칭되지 않은 예측 관계들 (False Positives)
        matched_pred_rels = {match[0] for match in rel_matches}
        fp_rel_indices = set(range(len(pred_rel_texts))) - matched_pred_rels
        if fp_rel_indices:
            print(f"\n--- 매칭되지 않은 예측 관계들 (FP: {len(fp_rel_indices)}개) ---")
            for i, idx in enumerate(sorted(fp_rel_indices), 1):
                print(f"{i:2d}. '{pred_rel_texts[idx]}'")
        
        # 매칭되지 않은 정답 관계들 (False Negatives)
        matched_gold_rels = {match[1] for match in rel_matches}
        fn_rel_indices = set(range(len(gold_rel_texts))) - matched_gold_rels
        if fn_rel_indices:
            print(f"\n--- 매칭되지 않은 정답 관계들 (FN: {len(fn_rel_indices)}개) ---")
            for i, idx in enumerate(sorted(fn_rel_indices), 1):
                print(f"{i:2d}. '{gold_rel_texts[idx]}'")
    
    print("\n" + "=" * 60)
    print("평가 완료!")
    print("=" * 60)


def main():
    parser = argparse.ArgumentParser(description="OpenAI Embedding을 사용한 Knowledge Graph 평가")
    parser.add_argument("--gold", required=True, help="정답 JSON 파일 경로")
    parser.add_argument("--pred", required=True, help="예측 JSON 파일 경로")
    parser.add_argument("-v", "--verbose", action="store_true", help="상세 매칭 결과 표시")
    parser.add_argument("--threshold", type=float, default=0.8, help="유사성 임계값 (0.0-1.0)")
    parser.add_argument("--model", default="text-embedding-3-small", 
                       help="OpenAI embedding 모델 (text-embedding-3-small, text-embedding-3-large)")
    parser.add_argument("--api-key", help="OpenAI API 키 (환경변수 사용 권장)")
    
    args = parser.parse_args()
    
    
    try:
        # 데이터 로드
        print("데이터 로드 중...")
        gold = load_json(Path(args.gold))
        pred = load_json(Path(args.pred))
        
        # OpenAI Embedding 평가기 초기화
        evaluator = OpenAIEmbeddingEvaluator(
            api_key=args.api_key,
            model=args.model,
            threshold=args.threshold
        )
        
        # 평가 수행
        evaluate_with_openai_embeddings(gold, pred, evaluator, verbose=args.verbose)
        
    except FileNotFoundError as e:
        print(f"오류: 파일을 찾을 수 없습니다 - {e}")
    except json.JSONDecodeError as e:
        print(f"오류: JSON 파일 파싱 실패 - {e}")
    except Exception as e:
        print(f"오류: {e}")


if __name__ == "__main__":
    main()
