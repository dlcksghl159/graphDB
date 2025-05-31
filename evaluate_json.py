import json
import argparse
from pathlib import Path
from typing import Tuple, Set, Dict

###############################################################################
# KG Evaluation Script
# --------------------
# usage: python evaluate_kg.py --gold movie_answer.json --pred result.json
#
# Metrics reported:
#   • Node precision / recall / F1 (label+name key)
#   • Relation precision / recall / F1 (start name, rel type, end name key)
#   • Detailed false‑positive / false‑negative lists (optional flag)
###############################################################################

def load_json(path: Path) -> Dict:
    with path.open("r", encoding="utf-8") as f:
        return json.load(f)


def canonical_node(node: Dict) -> Tuple[str, str]:
    """Return canonical key for a node (label, name), trimmed & lowered."""
    return node["label"].strip(), node["name"].strip()


def canonical_rel(rel: Dict) -> Tuple[str, str, str]:
    return (
        rel["start_node"].strip(),
        rel["relationship"].strip(),
        rel["end_node"].strip(),
    )


def prf(tp: int, pred: int, gold: int):
    prec = tp / pred if pred else 0.0
    rec  = tp / gold if gold else 0.0
    if prec + rec == 0:
        f1 = 0.0
    else:
        f1 = 2 * prec * rec / (prec + rec)
    return prec, rec, f1


def evaluate(gold: Dict, pred: Dict, verbose: bool = False):
    gold_nodes: Set[Tuple[str, str]] = {canonical_node(n) for n in gold.get("nodes", [])}
    pred_nodes: Set[Tuple[str, str]] = {canonical_node(n) for n in pred.get("nodes", [])}

    gold_rels: Set[Tuple[str, str, str]] = {canonical_rel(r) for r in gold.get("relations", [])}
    pred_rels: Set[Tuple[str, str, str]] = {canonical_rel(r) for r in pred.get("relations", [])}

    tp_nodes = gold_nodes & pred_nodes
    tp_rels  = gold_rels & pred_rels

    node_prec, node_rec, node_f1 = prf(len(tp_nodes), len(pred_nodes), len(gold_nodes))
    rel_prec,  rel_rec,  rel_f1  = prf(len(tp_rels),  len(pred_rels),  len(gold_rels))

    print("=== Nodes ===")
    print(f"Gold      : {len(gold_nodes):4d}")
    print(f"Predicted : {len(pred_nodes):4d}")
    print(f"TP        : {len(tp_nodes):4d}")
    print(f"Precision : {node_prec:.3f}\nRecall    : {node_rec:.3f}\nF1        : {node_f1:.3f}\n")

    print("=== Relations ===")
    print(f"Gold      : {len(gold_rels):4d}")
    print(f"Predicted : {len(pred_rels):4d}")
    print(f"TP        : {len(tp_rels):4d}")
    print(f"Precision : {rel_prec:.3f}\nRecall    : {rel_rec:.3f}\nF1        : {rel_f1:.3f}\n")

    if verbose:
        fp_nodes = pred_nodes - gold_nodes
        fn_nodes = gold_nodes - pred_nodes
        fp_rels  = pred_rels - gold_rels
        fn_rels  = gold_rels - pred_rels

        def _print_set(title: str, items):
            if items:
                print(f"--- {title} ({len(items)}) ---")
                for itm in sorted(items):
                    print(itm)
                print()

        _print_set("FP Nodes", fp_nodes)
        _print_set("FN Nodes", fn_nodes)
        _print_set("FP Relations", fp_rels)
        _print_set("FN Relations", fn_rels)


def main():
    p = argparse.ArgumentParser(description="Evaluate extracted KG against gold JSON")
    p.add_argument("--gold", required=True, help="data/movie_answer.json")
    p.add_argument("--pred", required=True, help="output/result/result.json")
    p.add_argument("-v", "--verbose", action="store_true", help="Show FP/FN details")
    args = p.parse_args()

    gold = load_json(Path(args.gold))
    pred = load_json(Path(args.pred))
    evaluate(gold, pred, verbose=args.verbose)


if __name__ == "__main__":
    main()
