# filename: news_keyword_search.py
import os, json, time, requests
from datetime import datetime
from typing import List, Tuple
from bs4 import BeautifulSoup
from tqdm import tqdm
import numpy as np, faiss
from openai import OpenAI

# ─────────────────────────── 1. OpenAI 클라이언트 ───────────────────────────
# (1) 환경변수 OPENAI_API_KEY를 쓰는 게 가장 안전합니다.
# (2) 로컬 테스트용으로만 직접 문자열을 넣고 싶다면 아래처럼…
API_KEY = "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"  # 그대로!

client = OpenAI(api_key=API_KEY)

EMB_MODEL = "text-embedding-3-small"   # 512 or 256 차원
JSON_PATH = "naver_news_top50.json"
IDX_PATH  = "news_index.faiss"
VEC_PATH  = "news_vectors.npy"

# ─────────────────────────── 2. 네이버 뉴스 크롤러 ───────────────────────────
SECTION_URL = "https://news.naver.com/main/list.naver"
PARAMS_BASE = {
    "mode": "LS2D",
    "mid":  "sec",
    "sid1": "101",     # 경제
    "sid2": "771"      # 기업·경영
}
HEADERS = {
    "User-Agent": "Mozilla/5.0",
    "Referer":   "https://www.naver.com"
}

def crawl_top50() -> List[dict]:
    """오늘 날짜 섹션 페이지를 돌며 기사 50개를 수집해 JSON으로 저장."""
    print("📰  네이버 기사 50개 크롤링 중…")
    links, page = [], 1
    today = datetime.now().strftime("%Y%m%d")

    # ① 링크 수집
    while len(links) < 50:
        params = PARAMS_BASE | {"page": str(page), "date": today}
        res = requests.get(SECTION_URL, headers=HEADERS,
                           params=params, timeout=10)
        res.raise_for_status()
        soup = BeautifulSoup(res.text, "html.parser")

        new = []
        for a in soup.select("div.list_body.newsflash_body ul li dl dt a"):
            txt = a.get_text(strip=True)
            if not txt or txt == "동영상기사":
                continue
            href = a["href"]
            if href.startswith("/"):
                href = "https://news.naver.com" + href
            new.append(href)
        if not new:          # 페이지가 더 없으면 중단
            break
        for l in new:
            if l not in links:
                links.append(l)
                if len(links) >= 50:
                    break
        page += 1
        time.sleep(0.1)

    # ② 본문 파싱
    def parse(url: str) -> dict:
        r = requests.get(url, headers=HEADERS, timeout=10)
        r.raise_for_status()
        s = BeautifulSoup(r.text, "html.parser")

        title_tag = (s.select_one("#articleTitle")
                     or s.select_one("h2.media_end_head_headline")
                     or s.select_one("h2.media_end_head_title")
                     or s.select_one("h3.end_tit"))
        title = title_tag.get_text(strip=True) if title_tag else ""

        body_tag = (s.select_one("#articleBodyContents")
                    or s.select_one("div#newsct_article._article_body")
                    or s.select_one("div#newsEndContents"))
        content = ""
        if body_tag:
            for t in body_tag.select(
                "script, .end_photo_org, .link_news, span.media_end_linked_more_url"
            ):
                t.decompose()
            content = body_tag.get_text("\n", strip=True)
        return {"title": title, "content": content}

    articles = []
    for i, url in enumerate(links, 1):
        try:
            art = parse(url)
            articles.append(art)
            print(f"[{i:02d}/50] {art['title'][:60]}…")
        except Exception as e:
            print(f"  → 실패({e})")

    # ③ JSON 저장
    with open(JSON_PATH, "w", encoding="utf-8") as f:
        json.dump(articles, f, ensure_ascii=False, indent=2)
    print(f"✅  크롤링 완료 → {JSON_PATH} 저장\n")
    return articles

# ─────────────────────────── 3. 임베딩 & 인덱스 ───────────────────────────
def get_embedding(text: str) -> List[float]:
    text = text.replace("\n", " ")
    while True:
        try:
            return client.embeddings.create(
                input=[text], model=EMB_MODEL
            ).data[0].embedding
        except Exception as e:
            print("  ⏳ 재시도:", e)
            time.sleep(2)

def build_or_load_index() -> Tuple[faiss.IndexFlatIP, List[dict]]:
    """JSON→벡터→FAISS 인덱스. 캐시가 있으면 그대로 로드."""
    if not os.path.exists(JSON_PATH):
        crawl_top50()                       # 파일 없으면 자동 크롤링

    if os.path.exists(IDX_PATH) and os.path.exists(VEC_PATH):
        # ─ 캐시 로드 ─
        with open(JSON_PATH, encoding="utf-8") as f:
            articles = json.load(f)
        xb = np.load(VEC_PATH).astype("float32")
        dim = xb.shape[1]
        index = faiss.IndexFlatIP(dim)
        index.add(xb)
        return index, articles

    # ─ 새로 생성 ─
    with open(JSON_PATH, encoding="utf-8") as f:
        articles = json.load(f)

    vectors = []
    for art in tqdm(articles, desc="임베딩 생성"):
        txt = (art["title"] + "\n\n" + art["content"])[:3500]
        vec = np.array(get_embedding(txt), dtype=np.float32)
        vec /= np.linalg.norm(vec) + 1e-10
        vectors.append(vec)

    xb  = np.vstack(vectors).astype("float32")
    dim = xb.shape[1]
    np.save(VEC_PATH, xb)

    index = faiss.IndexFlatIP(dim)
    index.add(xb)
    faiss.write_index(index, IDX_PATH)
    return index, articles

# ─────────────────────────── 4. 키워드 검색 ───────────────────────────
def search_by_keywords(keywords: List[str], top_k: int = 1) -> List[dict]:
    query = " ".join(keywords)
    q_vec = np.array(get_embedding(query), dtype=np.float32)
    q_vec /= np.linalg.norm(q_vec) + 1e-10

    index, articles = build_or_load_index()
    D, I = index.search(q_vec[None, :], top_k)

    results = []
    for score, idx in zip(D[0], I[0]):
        art = articles[int(idx)].copy()
        art["score"] = float(score)
        results.append(art)
    return results

# ─────────────────────────── 5. 실행 ───────────────────────────
if __name__ == "__main__":
    kws = input("키워드를 입력하세요 (공백으로 구분): ").split()
    top = search_by_keywords(kws, top_k=5)

    print("\n🔍  키워드 연관 기사 Top-5")
    for i, art in enumerate(top, 5):
        print(f"[{i}] ({art['score']:.3f}) {art['title']}")
    # 결과 저장
    with open("keyword_results.json", "w", encoding="utf-8") as f:
        json.dump(top, f, ensure_ascii=False, indent=2)
    print("\n✅  결과 → keyword_results.json 저장")
