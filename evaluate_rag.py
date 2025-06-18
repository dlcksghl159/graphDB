import argparse, json, csv, time
from pathlib import Path
from statistics import mean
from typing import List, Dict

from rouge_score import rouge_scorer
from bert_score import score as bert_score
from rag import answer
from tqdm import tqdm

######################################################################
# QA Evaluation Script
# --------------------
# Supports two categories of questions (mark via "type" field):
#   • short  – 단답형 (정답이 명확)  → accuracy
#   • long   – 서술형            → ROUGE-L / BERTScore
# Input file (JSONL or CSV) requires columns:
#   id, question, reference, prediction, latency (sec), type {short|long}
######################################################################

def load_records(path: Path) -> List[Dict]:
    recs: List[Dict] = []
    if path.suffix.lower() == ".jsonl":
        for line in path.read_text(encoding="utf-8").splitlines():
            recs.append(json.loads(line))
    elif path.suffix.lower() == ".csv":
        with path.open(newline="", encoding="utf-8") as f:
            for row in csv.DictReader(f):
                recs.append(row)
    else:
        raise ValueError("Only .jsonl or .csv supported")
    return recs


def evaluate(records: List[Dict]):
    # Split by type
    short_q  = [r for r in records if r.get("type", "short") == "short"]
    long_q   = [r for r in records]# if r.get("type", "short") == "short"]

    # --- Short answer accuracy ---
    acc = sum(1 for r in short_q if r["prediction"].strip().lower() == r["reference"].strip().lower()) / max(1, len(short_q))

    # --- Long answer ROUGE + BERTScore ---
    rouge_l, bert_p, bert_r, bert_f = 0, 0, 0, 0
    if long_q:
        refs  = [r["reference"] for r in long_q]
        preds = [r["prediction"] for r in long_q]
        # ROUGE-L (sentence level)
        rs = rouge_scorer.RougeScorer(["rougeL"], use_stemmer=True)
        rouge_l = mean(rs.score(ref, pred)["rougeL"].fmeasure for ref, pred in zip(refs, preds))
        # BERTScore
        bert_p, bert_r, bert_f = bert_score(preds, refs, lang="ko", verbose=False)
        bert_p, bert_r, bert_f = float(bert_p.mean()), float(bert_r.mean()), float(bert_f.mean())

    # --- Latency ---
    lat = mean(float(r.get("latency", 0)) for r in records) if records else 0

    # --- Output ---
    print("=== Short-answer (정답형) ===")
    print(f"Samples: {len(short_q)}  Accuracy: {acc:.3f}\n")

    print("=== Long-answer (서술형) ===")
    print(f"Samples: {len(long_q)}  ROUGE-L: {rouge_l:.3f}  BERTScore(F): {bert_f:.3f}\n")

    print("=== 전체 평균 응답 시간 ===")
    print(f"{lat:.2f} sec\n")


def main():
    # 1) Run QA over RAG and build eval set
    output_file = 'data/QA-set-eval.jsonl'
    try:
        with open('data/QA-set.json', 'r', encoding='utf-8') as f:
            records = json.load(f)
    except FileNotFoundError:
        records = []

    if records:
        i=0
        for rec in tqdm(records, desc="Evaluating QA records"):
            i+=1
            if i >10: 
                break
            question = rec['Q']
            ans = rec['A']
            before = time.time()
            try:
                prediction = answer(question)
            except Exception:
                prediction = ''
            latency = time.time() - before
            rec.update({
                'question': question,
                'reference': ans,
                'prediction': prediction or "No answer found",
                'latency': latency,
                'type': 'long' if len(ans.split()) > 10 else 'short'
            })
        # Save intermediate eval file
        Path(output_file).parent.mkdir(parents=True, exist_ok=True)
        with open(output_file, 'w', encoding='utf-8') as f:
            for rec in records:
                f.write(json.dumps(rec, ensure_ascii=False) + '\n')

    # 2) Parse command-line argument (optional)
    parser = argparse.ArgumentParser(description="Evaluate QA predictions (short vs long)")
    parser.add_argument('file', nargs='?', default=output_file,
                        help=f"Path to .jsonl or .csv file to evaluate (default: {output_file})")
    args = parser.parse_args()

    recs = load_records(Path(args.file))
    if not recs:
        print(f"No records found in {args.file}")
        return
    evaluate(recs)

if __name__ == "__main__":
    main()