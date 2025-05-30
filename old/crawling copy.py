# filename: crawling.py
"""네이버 **연예→드라마** 섹션(모바일) 기사 N개를 크롤링해 임베딩·FAISS 인덱스를 만든 뒤
   키워드 검색 결과를 출력/저장한다. 모든 산출물은 ./output/news 폴더에 저장된다.
   ─ 업데이트: 2025‑05‑12 (완전판: mid=shm, main() 포함)
"""

from __future__ import annotations

import os
import json
import time
import itertools
from typing import List, Tuple

import requests
from bs4 import BeautifulSoup
from tqdm import tqdm
import numpy as np
import faiss
from openai import OpenAI
from dotenv import load_dotenv

# ---------------------- 0. 환경 및 경로 설정 ----------------------
load_dotenv()
API_KEY = os.getenv("OPENAI_API_KEY")
if not API_KEY:
    raise RuntimeError("⚠️  OPENAI_API_KEY 환경변수를 설정하세요!")

client = OpenAI(api_key=API_KEY)

# 산출물을 저장할 폴더 ────────────────
OUTPUT_ROOT = os.getenv("OUTPUT_ROOT", "output")   # 기본값 "output"
OUTPUT_DIR = os.path.join(OUTPUT_ROOT, "news")
os.makedirs(OUTPUT_DIR, exist_ok=True)

TOP_N     = int(os.getenv("TOP_N", "100"))        # 크롤링·임베딩할 기사 수
EMB_MODEL = "text-embedding-3-small"               # 256/512차원

# 파일 경로 ---------------------------------------------------------
JSON_PATH   = f"{OUTPUT_DIR}/naver_news_top{TOP_N}.json"
IDX_PATH    = f"{OUTPUT_DIR}/news_index_{TOP_N}.faiss"
VEC_PATH    = f"{OUTPUT_DIR}/news_vectors_{TOP_N}.npy"
RESULT_PATH = f"{OUTPUT_DIR}/keyword_results.json"

# ---------------------- 1. 네이버 뉴스 크롤러 ----------------------
MOBILE_HEADERS = {
    "User-Agent": (
        "Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) "
        "AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1"
    ),
    "Referer": "https://m.entertain.naver.com/",
}

SECTION_URL = "https://news.naver.com/main/list.naver"
PARAMS_BASE_DEFAULT = {
    "mode": "LS2D",
    "mid": "sec",
    "sid1": "101",  # 경제
    "sid2": "771",  # 기업·경영
}
HEADERS = {
    "User-Agent": "Mozilla/5.0",
    "Referer": "https://www.naver.com",
}

def reset_paths(output_root: str):
    if not output_root:
        output_root = "output"
    global OUTPUT_ROOT, OUTPUT_DIR, JSON_PATH, IDX_PATH, VEC_PATH, RESULT_PATH
    OUTPUT_ROOT = output_root
    OUTPUT_DIR  = os.path.join(OUTPUT_ROOT, "news")
    os.makedirs(OUTPUT_DIR, exist_ok=True)

    JSON_PATH   = f"{OUTPUT_DIR}/naver_news_top{TOP_N}.json"
    IDX_PATH    = f"{OUTPUT_DIR}/news_index_{TOP_N}.faiss"
    VEC_PATH    = f"{OUTPUT_DIR}/news_vectors_{TOP_N}.npy"
    RESULT_PATH = f"{OUTPUT_DIR}/keyword_results.json"

def crawl_top_n(n: int = TOP_N) -> List[dict]:
    """오늘 날짜 기준 기업·경영 섹션에서 기사 n개 수집"""
    print(f"📰  네이버 기사 {n}개 크롤링 중…")
    links, page = [], 1
    today = datetime.now().strftime("%Y%m%d")

    # ① 링크 수집
    while len(links) < n:
        params = PARAMS_BASE | {"page": str(page), "date": today}
        res = requests.get(SECTION_URL, headers=HEADERS, params=params, timeout=10)
        res.raise_for_status()
        soup = BeautifulSoup(res.text, "html.parser")

        new_links = [
            ("https://news.naver.com" + a["href"] if a["href"].startswith("/") else a["href"])
            for a in soup.select("div.list_body.newsflash_body ul li dl dt a")
            if (txt := a.get_text(strip=True)) and txt != "동영상기사"
        ]
        if not new_links:
            break  # 더 이상 기사 없음
        for l in new_links:
            if l not in links:
                links.append(l)
                if len(links) >= n:
                    break
        page += 1
        time.sleep(0.1)

    # ② 본문 파싱
    def parse(url: str) -> dict:
        r = requests.get(url, headers=HEADERS, timeout=10)
        r.raise_for_status()
        s = BeautifulSoup(r.text, "html.parser")

    title_tag = (
        s.select_one("h2.media_end_head_headline")
        or s.select_one("h2.media_end_head_title")
        or s.select_one("#articleTitle")
        or s.select_one("h3.end_tit")
    )
    title = title_tag.get_text(strip=True) if title_tag else ""

    body_tag = (
        s.select_one("#newsct_article")
        or s.select_one("#articleBodyContents")
        or s.select_one("#newsEndContents")
    )
    content = ""
    if body_tag:
        for dirty in body_tag.select(
            "script, style, .end_photo_org, .link_news, span.media_end_linked_more_url"
        ):
            dirty.decompose()
        content = body_tag.get_text("\n", strip=True)
    return {"title": title, "content": content}

# --------------------------------------------------------------
# 1) 기사 크롤러
# --------------------------------------------------------------

def crawl_top_n(n: int = TOP_N, params_base: dict | None = None) -> List[dict]:
    """오늘 날짜 기준 연예→드라마 섹션에서 기사 n개 수집"""
    params_base = params_base or PARAMS_BASE_DEFAULT
    print(f"📰  네이버 드라마 기사 {n}개 크롤링 중…")

    links: list[str] = []
    for page in itertools.count(1):
        soup = BeautifulSoup(_fetch_list(params_base, page), "html.parser")

        boxes = (
            soup.select("ul.type06_headline li dl dt:not(.photo) > a")
            or soup.select("ul.type06 li dl dt:not(.photo) > a")
        )
        if not boxes:
            break

        for a in boxes:
            href = a["href"]
            link = "https://news.naver.com" + href if href.startswith("/") else href
            if link not in links:
                links.append(link)
                if len(links) >= n:
                    break
        if len(links) >= n:
            break
        time.sleep(0.1)

    # -------- 기사 본문 파싱 --------
    articles: list[dict] = []
    for i, url in enumerate(links, 1):
        try:
            art = _parse_article(url)
            articles.append(art)
            print(f"[{i:02d}/{n}] {art['title'][:60]}…")
        except Exception as e:
            print(f"  → 실패({e})")

    with open(JSON_PATH, "w", encoding="utf-8") as f:
        json.dump(articles, f, ensure_ascii=False, indent=2)
    print(f"✅  크롤링 완료 → {JSON_PATH} 저장\n")
    return articles

# --------------------------------------------------------------
# 2) 임베딩 & 인덱스 빌드
# --------------------------------------------------------------

def _get_embedding(text: str) -> List[float]:
    text = text.replace("\n", " ")
    while True:
        try:
            return client.embeddings.create(input=[text], model=EMB_MODEL).data[0].embedding
        except Exception as e:
            print("  ⏳ 재시도:", e)
            time.sleep(2)


def build_or_load_index() -> Tuple[faiss.IndexFlatIP, List[dict]]:
    """기사 JSON → 임베딩 → FAISS 인덱스. 캐시 활용"""
    if not os.path.exists(JSON_PATH):  # JSON 없으면 크롤링
        crawl_top_n(TOP_N)

    with open(JSON_PATH, encoding="utf-8") as f:
        articles: List[dict] = json.load(f)

    if len(articles) < TOP_N:  # 기사 부족 시 재크롤링
        articles = crawl_top_n(TOP_N)

    # 캐시된 벡터·인덱스가 있으면 로드
    if os.path.exists(IDX_PATH) and os.path.exists(VEC_PATH):
        xb = np.load(VEC_PATH).astype("float32")
        dim = xb.shape[1]
        index = faiss.IndexFlatIP(dim)
        index.add(xb)
        return index, articles

    # 새로 임베딩 생성
    print("\n🧮  임베딩 생성 중…")
    vectors = []
    for art in tqdm(articles, desc="임베딩"):
        txt = (art["title"] + "\n\n" + art["content"])[:3500]
        vec = np.asarray(get_embedding(txt), dtype=np.float32)
        vec /= np.linalg.norm(vec) + 1e-10
        vectors.append(vec)

    xb = np.vstack(vectors).astype("float32")
    np.save(VEC_PATH, xb)

    dim = xb.shape[1]
    index = faiss.IndexFlatIP(dim)
    index.add(xb)
    faiss.write_index(index, IDX_PATH)
    print("✅  임베딩 & 인덱스 저장 완료\n")
    return index, articles

# ---------------------- 3. 키워드 검색 ----------------------

def search_by_keywords(keywords: List[str], top_k: int = 50) -> List[dict]:
    query = " ".join(keywords)
    q_vec = np.asarray(get_embedding(query), dtype=np.float32)
    q_vec /= np.linalg.norm(q_vec) + 1e-10

    index, articles = build_or_load_index()
    D, I = index.search(q_vec[None, :], top_k)

    results = []
    for score, idx in zip(D[0], I[0]):
        art = articles[int(idx)].copy()
        art["score"] = float(score)
        results.append(art)
    return results

# ---------------------- 4. 실행 ----------------------
def main(params_base):
    global PARAMS_BASE
    PARAMS_BASE = params_base
    output_root = os.getenv("OUTPUT_ROOT", "output")
    reset_paths(output_root)
    print(PARAMS_BASE)
    kws = input("키워드를 입력하세요 (공백으로 구분): ").split()
    top_results = search_by_keywords(kws, top_k=50)

    print("\n🔍  키워드 연관 기사 Top-50")
    for rank, art in enumerate(top_results, 1):
        print(f"[{rank:02d}] ({art['score']:.3f}) {art['title']}")

    with open(RESULT_PATH, "w", encoding="utf-8") as f:
        json.dump(top_results, f, ensure_ascii=False, indent=2)
    print(f"\n✅  결과 → {RESULT_PATH} 저장")

if __name__ == "__main__": 
    main({
        "mode": "LS2D",
        "mid": "sec",
        "sid1": "101",  # 경제
        "sid2": "771",  # 기업·경영
    })
