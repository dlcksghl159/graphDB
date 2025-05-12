# main.py
import os, argparse
import crawling, save_news, schema, extract_node_kr, extract_relation_kr, cypher, namuwiki


def main():

    # 환경변수로 전달하면 모든 모듈이 import 없이 접근 가능
    output_root = f"output"
    os.environ["OUTPUT_ROOT"] = output_root
    print(f"[INFO] OUTPUT_ROOT = {output_root}")

    # 파이프라인 실행부 ---------------------------------------------------
    # print("1. Crawling news..."); crawling.main()
    namuwiki.main()
    print("2. Saving news data..."); save_news.main()
    print("3. Generating schema..."); schema.main()
    print("4. Extracting nodes (KR)…");       extract_node_kr.main()
    print("5. Extracting relations (KR)…");   extract_relation_kr.main()
    print("6. Creating Cypher queries…");     cypher.main()
    print("✅ Pipeline completed successfully.")

if __name__ == "__main__":
    main()
