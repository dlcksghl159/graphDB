"""
namuwiki_clean_crawler.py
────────────────────────────────────────────────────────────────────────
• 나무위키 문서 전체 HTML을 저장한 뒤
  <article> 본문에서 스크립트·스타일·표·각주 등 불필요한 요소를 제거하고
  순수 텍스트만 출력·저장합니다.
────────────────────────────────────────────────────────────────────────
"""
from pathlib import Path
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
from bs4 import BeautifulSoup

# ─────────────────────── 브라우저 설정 ────────────────────────
def set_chrome_driver() -> webdriver.Chrome:
    opt = webdriver.ChromeOptions()
    opt.add_argument("--headless")
    opt.add_argument("--no-sandbox")
    opt.add_argument("--disable-dev-shm-usage")
    opt.add_argument("--disable-gpu")
    opt.add_argument("--lang=ko_KR")
    opt.add_argument("--window-size=1920x1080")
    opt.add_argument(
        "user-agent=Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) "
        "AppleWebKit/537.36 (KHTML, like Gecko) "
        "Chrome/61.0.3163.100 Safari/537.36"
    )
    return webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=opt)

# ────────────────────────── 핵심 로직 ──────────────────────────
def extract_clean_text(html: str) -> str:
    soup = BeautifulSoup(html, "lxml")

    # ① 문서 본문(<article>)만 대상
    article = soup.select_one("article") or soup  # 안전장치: 없으면 전체

    # ② 보기에 방해되는 태그 제거
    for tag in article.select(
        "script, style, sup, figure, table, aside, noscript, .footnote, .wiki-make-top"
    ):
        tag.decompose()

    # ③ 순수 텍스트 추출
    return article.get_text("\n", strip=True)

# ──────────────────────────── 메인 ────────────────────────────
def main():
    url = (
        "https://namu.wiki/w/SKY%20%EC%BA%90%EC%8A%AC"
        
    )

    driver = set_chrome_driver()
    driver.get(url)
    html = driver.page_source
    driver.quit()

    out = Path("output"); out.mkdir(exist_ok=True)
    (out / "namu_page.html").write_text(html, encoding="utf-8")

    clean_text = extract_clean_text(html)
    (out / "namu_page.txt").write_text(clean_text, encoding="utf-8")

    print("✅ 순수 텍스트 추출 완료! → output/namu_page.txt")
    # 필요하다면 바로 확인
    # print(clean_text)

if __name__ == "__main__":
    main()
