import os
from bs4 import BeautifulSoup
import re

def chunk():
    chunks_dir = "./output/chunked_document"
    os.makedirs(chunks_dir, exist_ok=True)

    document_dir = "./output/parsed_document"

    def split_html_by_sentence(html: str, chunk_size: int = 15000) -> list[str]:
        soup = BeautifulSoup(html, "html.parser")
        
        # 텍스트 블록들 HTML 그대로 유지
        blocks = []
        for tag in soup.find_all(["h1", "h2", "h3", "p", "table", "ul", "ol", "figure"]):
            blocks.append(str(tag))

        # 문장 기준 청크 나누기
        chunks = []
        current_chunk = ""

        sentence_end_pattern = re.compile(r"(?<=[.!?。])\s|(?<=</p>)|(?<=</table>)")

        for block in blocks:
            current_chunk += block

            if len(current_chunk) >= chunk_size:
                # 문장 기준으로 나누기
                split_points = sentence_end_pattern.split(current_chunk)
                temp_chunk = ""
                for part in split_points:
                    temp_chunk += part
                    if len(temp_chunk) >= chunk_size:
                        chunks.append(temp_chunk.strip())
                        temp_chunk = ""
                current_chunk = temp_chunk

        if current_chunk.strip():
            chunks.append(current_chunk.strip())

        return chunks

    # 사용 예시
    with open(f"{document_dir}/html_content.txt", "r", encoding="utf-8") as f:
        html_text = f.read()

    chunks = split_html_by_sentence(html_text)


    # docs를 텍스트 파일로 저장
    for i, chunk in enumerate(chunks):
        with open(f"{chunks_dir}/chunked_output_{i}.txt", "w", encoding="utf-8") as f:
            f.write(f"{chunk}")

if __name__ == "__main__": 
    chunk()
