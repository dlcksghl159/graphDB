# filename: save_news_chunks.py
"""검색된 Top-50 뉴스( keyword_results.json )를 각각
   ./output/chunked_document/chunked_output_{i}.txt 로 저장한다.
   ─ 작동 흐름 ─────────────────────────────────────────────
   1. ./output/news/keyword_results.json 을 읽는다 (이전 스크립트가 생성).
   2. ./output/chunked_document 폴더가 없으면 생성.
   3. 결과 리스트의 앞 50개를 순서대로 파일로 기록.
      (파일 내용: "제목\n\n본문")
"""

import os
import json

# ----------------------------- 경로 -----------------------------
OUTPUT_ROOT = os.getenv("OUTPUT_ROOT", "output")   # 기본값 "output"

NEWS_DIR     = os.path.join(OUTPUT_ROOT, "news")
RESULT_JSON  = os.path.join(NEWS_DIR, "keyword_results.json")
CHUNK_DIR    = os.path.join(OUTPUT_ROOT, "chunked_document")

os.makedirs(NEWS_DIR, exist_ok=True)

# -------------------------- 유틸 함수 ---------------------------

def save_chunks(max_docs: int = 50):
    if not os.path.exists(RESULT_JSON):
        raise FileNotFoundError(
            f"결과 파일을 찾을 수 없습니다: {RESULT_JSON}\n"
            "먼저 news_keyword_search.py 를 실행해 keyword_results.json 을 생성하세요."
        )

    # 결과 로드
    with open(RESULT_JSON, encoding="utf-8") as f:
        articles = json.load(f)

    if not articles:
        raise ValueError("keyword_results.json 이 비어 있습니다.")

    # 출력 폴더 준비
    os.makedirs(CHUNK_DIR, exist_ok=True)

    # 상위 max_docs 개만 저장
    for i, art in enumerate(articles[:max_docs]):
        title   = art.get("title", "")
        content = art.get("content", "")
        text = f"{title}\n\n{content}"

        filepath = os.path.join(CHUNK_DIR, f"chunked_output_{i}.txt")
        with open(filepath, "w", encoding="utf-8") as out:
            out.write(text)
        print(f"✅  저장 완료 → {filepath}")

    print(f"\n🎉  총 {min(max_docs, len(articles))} 개 기사 저장 완료")

# ----------------------------- 실행 -----------------------------
def main():
    save_chunks(50)
if __name__ == "__main__":
    main()
