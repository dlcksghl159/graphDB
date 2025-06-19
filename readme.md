# 문서 기반 지식 그래프 및 RAG 구축 파이프라인

> 문서 기반 한국어 지식 그래프 구축 및 RAG 시스템

## 사용방법
**(선택적) 목적 기반 뉴스 기사 자동 추출**
```
python crawling.py
python save_news.py
```

**1. 문서 파일을 documents 디렉토리에 배치**
```
cp your_files/* output/documents
```

**2. 전체 파이프라인 실행**
```
streamlit run app.py
```
**3. 성능 평가**
```
python evaluate_rag.py
```

## 환경설정
**python 3.10.16**
```
pip install -r requirements.txt
```
각 모듈의 구체적인 버전은 raw_requirements.txt 에서 확인 가능합니다.

## 개별 실행 방법 
**app.py를 통한 통합 인터페이스가 아닌 개별 파일로 각 step을 실행하고 싶다면 아래와 같은 순서로 실행 가능합니다.**
1. crawling.py (뉴스 기사 수집)
2. save_news.py (뉴스 기사 저장 -> output/documents)
3. extract_schema.py (output/schema/schema.json)
4. extract_node.py (output/result/result.json) 
5. extract_relation.py (output/result/result.json)
6. creat_cypher.py (output/graph.cypher)
7. send_cypher.py
8. rag.py

**각 지식그래프 및 RAG 시스템에 대해 성능을 평가하고 싶다면 아래와 같이 실행 가능합니다.**  
  
&nbsp;&nbsp;(1) 지식그래프 평가 
1. data/answer.json 으로 정답 스키마를 저장한다.
2. evaluate_json.py --gold data/answer.json --pred output/result/result.json 을 실행한다.
   
&nbsp;&nbsp;(2) RAG 평가
1. data/QAset.json 으로 각 정답 질의응답 데이터를 저장한다.
2. evaluate_rag.py를 실행한다. 
