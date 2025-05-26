from selenium import webdriver
from selenium.webdriver.common.by import By
import pandas as pd, time

NETFLIX_IDS = [81252357, 80214497]          # 예시: Don't Look Up, 1899
BASE_URL = "https://www.netflix.com/kr/title/{}"

driver = webdriver.Chrome()
records = []

for nid in NETFLIX_IDS:
    driver.get(BASE_URL.format(nid))
    time.sleep(2)                           # 렌더링 대기 (필요 시 WebDriverWait)
    
    title   = driver.find_element(By.TAG_NAME, "h1").text
    year    = driver.find_element(By.CSS_SELECTOR, '[data-uia="title-info-release-year"]').text
    genres  = driver.find_element(By.XPATH, "//span[text()='Genres']/following-sibling::span").text
    actors  = driver.find_element(By.XPATH, "//span[text()='Starring']/following-sibling::span").text
    
    records.append({
        "netflix_id": nid,
        "title": title,
        "year": year,
        "genres": [g.strip() for g in genres.split(",")],
        "actors": [a.strip() for a in actors.split(",")]
    })

driver.quit()
pd.DataFrame(records).to_csv("netflix_meta_dom.csv", index=False)
