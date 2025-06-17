#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
main.py - 통합 지식 그래프 RAG 파이프라인
=====================================
app.py에서 받은 purpose와 output_root를 사용하여 전체 파이프라인 실행

실행 순서:
1. 문서 전처리 (documents → chunked_document)
2. 스키마 추출 (schema_multi.py)
3. 노드 추출 (extract_node_kr.py)
4. 관계 추출 (extract_relation_kr.py)
5. 중복 제거 (deduplication.py)
6. Cypher 생성 (cypher.py)
7. Neo4j 적재 (send_cypher.py)
"""

import os
import sys
import argparse
import time
import shutil
from pathlib import Path
from typing import List
import subprocess

# Windows 환경에서 UTF-8 출력 설정
if sys.platform.startswith('win'):
    import locale
    import codecs
    # stdout을 UTF-8로 재설정
    if sys.stdout.encoding != 'utf-8':
        sys.stdout = codecs.getwriter('utf-8')(sys.stdout.buffer, 'strict')
        sys.stderr = codecs.getwriter('utf-8')(sys.stderr.buffer, 'strict')

def setup_environment(output_root: str, purpose: str):
    """환경 변수 설정 및 디렉토리 구조 생성"""
    # 환경 변수 설정
    os.environ["OUTPUT_ROOT"] = output_root
    os.environ["PURPOSE"] = purpose
    
    # 필요한 디렉토리들 생성
    directories = [
        f"{output_root}/documents",
        f"{output_root}/chunked_document", 
        f"{output_root}/schema",
        f"{output_root}/result",
    ]
    
    for dir_path in directories:
        Path(dir_path).mkdir(parents=True, exist_ok=True)
    
    print(f"=== 환경 설정 완료 ===")
    print(f"   - OUTPUT_ROOT: {output_root}")
    print(f"   - PURPOSE: {purpose}")

def preprocess_documents(output_root: str) -> int:
    """documents 폴더의 파일들을 chunked_document로 복사/전처리"""
    documents_dir = Path(output_root) / "documents"
    chunked_dir = Path(output_root) / "chunked_document"
    
    # 기존 chunked_document 내용 삭제
    if chunked_dir.exists():
        shutil.rmtree(chunked_dir)
    chunked_dir.mkdir(parents=True, exist_ok=True)
    
    # documents 폴더에서 파일 찾기
    document_files = []
    for ext in ['*.txt', '*.md', '*.doc', '*.docx', '*.pdf']:
        document_files.extend(documents_dir.glob(ext))
    
    if not document_files:
        raise FileNotFoundError(f"DOCUMENTS 폴더 {documents_dir}에서 문서를 찾을 수 없습니다.")
    
    # 파일들을 chunked_output_X.txt 형태로 복사
    chunk_count = 0
    for i, doc_file in enumerate(document_files):
        try:
            # 텍스트 파일 읽기
            if doc_file.suffix.lower() in ['.txt', '.md']:
                content = doc_file.read_text(encoding='utf-8')
            else:
                # 다른 형태의 문서는 간단히 파일명만 저장 (실제로는 문서 파싱 필요)
                content = f"문서 파일: {doc_file.name}\n내용을 추출할 수 없습니다."
            
            # 긴 문서는 청크로 분할 (5000자 기준)
            chunk_size = 5000
            if len(content) > chunk_size:
                # 청크로 분할
                for j in range(0, len(content), chunk_size):
                    chunk_content = content[j:j+chunk_size]
                    chunk_file = chunked_dir / f"chunked_output_{chunk_count}.txt"
                    chunk_file.write_text(chunk_content, encoding='utf-8')
                    chunk_count += 1
            else:
                # 작은 문서는 그대로 저장
                chunk_file = chunked_dir / f"chunked_output_{chunk_count}.txt"
                chunk_file.write_text(content, encoding='utf-8')
                chunk_count += 1
                
        except Exception as e:
            print(f"WARNING: 파일 처리 오류 {doc_file.name}: {e}")
            continue
    
    print(f"DOCS: 문서 전처리 완료: {len(document_files)}개 파일 -> {chunk_count}개 청크")
    return chunk_count

def run_step(step_name: str, module_name: str, purpose: str = None) -> bool:
    """파이프라인 단계 실행"""
    print(f"\n--- {step_name} 시작...")
    start_time = time.time()
    
    try:
        if module_name == "schema_multi":
            from extract_schema import main as run_schema
            run_schema(purpose or "문서 분석")
            
        elif module_name == "extract_node_kr":
            from extract_node import main as run_extract_nodes
            run_extract_nodes(purpose or "문서 분석")
            
        elif module_name == "extract_relation_kr":
            from extract_relation import main as run_extract_relations
            run_extract_relations(purpose or "문서 분석")
            
        elif module_name == "deduplication":
            from deduplication import deduplicate
            output_root = os.getenv("OUTPUT_ROOT", "output")
            result_file = f"{output_root}/result/result.json"
            deduplicate(result_file)
            
        elif module_name == "cypher":
            from create_cypher import main as run_cypher
            run_cypher()
            
        elif module_name == "send_cypher":
            from send_cypher import main as run_send_cypher
            run_send_cypher()
            
        else:
            raise ValueError(f"알 수 없는 모듈: {module_name}")
        
        duration = time.time() - start_time
        print(f"OK: {step_name} 완료 ({duration:.1f}초)")
        return True
        
    except Exception as e:
        duration = time.time() - start_time
        print(f"ERROR: {step_name} 실패 ({duration:.1f}초): {e}")
        return False

def validate_pipeline_results(output_root: str) -> dict:
    """파이프라인 결과 검증"""
    results = {}
    
    # 1. 스키마 파일 확인
    schema_file = Path(output_root) / "schema" / "schema.json"
    results["schema"] = schema_file.exists()
    
    # 2. 결과 파일 확인
    result_file = Path(output_root) / "result" / "result.json"
    results["extraction"] = result_file.exists()
    
    # 3. Cypher 파일 확인
    cypher_file = Path(output_root) / "graph.cypher"
    results["cypher"] = cypher_file.exists()
    
    # 4. 결과 통계
    if results["extraction"]:
        import json
        try:
            with open(result_file, 'r', encoding='utf-8') as f:
                data = json.load(f)
            results["node_count"] = len(data.get("nodes", []))
            results["relation_count"] = len(data.get("relations", []))
        except:
            results["node_count"] = 0
            results["relation_count"] = 0
    
    return results

def run_pipeline(purpose: str, output_root: str) -> bool:
    """전체 파이프라인 실행"""
    print("=== 목적 지향 RAG 시스템 구축 파이프라인 시작 ===")
    print(f"RAG 시스템 목적: {purpose}")
    print(f"작업 디렉토리: {output_root}")
    
    pipeline_start = time.time()
    
    try:
        # 0. 환경 설정
        setup_environment(output_root, purpose)
        
        # 1. 문서 전처리
        print("\n" + "="*60)
        print("1단계: 문서 전처리")
        print("="*60)
        chunk_count = preprocess_documents(output_root)
        if chunk_count == 0:
            raise Exception("처리할 문서가 없습니다.")
        
        # 2. 스키마 추출
        print("\n" + "="*60)
        print("2단계: 스키마 추출")
        print("="*60)
        if not run_step("스키마 추출", "schema_multi", purpose):
            raise Exception("스키마 추출 실패")
        
        # 3. 노드 추출
        print("\n" + "="*60)
        print("3단계: 엔티티(노드) 추출")
        print("="*60)
        if not run_step("노드 추출", "extract_node_kr", purpose):
            raise Exception("노드 추출 실패")
        
        # 4. 관계 추출
        print("\n" + "="*60)
        print("4단계: 관계 추출")
        print("="*60)
        if not run_step("관계 추출", "extract_relation_kr", purpose):
            raise Exception("관계 추출 실패")
        
        # 5. 중복 제거
        print("\n" + "="*60)
        print("5단계: 중복 제거 및 정제")
        print("="*60)
        if not run_step("중복 제거", "deduplication"):
            print("WARNING: 중복 제거 실패, 계속 진행...")
        
        # 6. Cypher 스크립트 생성
        print("\n" + "="*60)
        print("6단계: Cypher 스크립트 생성")
        print("="*60)
        if not run_step("Cypher 생성", "cypher"):
            raise Exception("Cypher 스크립트 생성 실패")
        
        # 7. Neo4j 데이터베이스 적재
        print("\n" + "="*60)
        print("7단계: Neo4j 데이터베이스 적재")
        print("="*60)
        if not run_step("Neo4j 적재", "send_cypher"):
            print("WARNING: Neo4j 적재 실패, RAG는 파일 기반으로 동작...")
        
        # 8. 결과 검증
        print("\n" + "="*60)
        print("8단계: 결과 검증")
        print("="*60)
        validation_results = validate_pipeline_results(output_root)
        
        print("=== 파이프라인 결과 ===")
        print(f"   - 스키마 생성: {'OK' if validation_results['schema'] else 'FAIL'}")
        print(f"   - 데이터 추출: {'OK' if validation_results['extraction'] else 'FAIL'}")
        print(f"   - Cypher 생성: {'OK' if validation_results['cypher'] else 'FAIL'}")
        if 'node_count' in validation_results:
            print(f"   - 추출된 노드: {validation_results['node_count']:,}개")
            print(f"   - 추출된 관계: {validation_results['relation_count']:,}개")
        
        total_time = time.time() - pipeline_start
        print(f"\n=== '{purpose}' 목적의 RAG 시스템 구축 완료! (총 {total_time:.1f}초) ===")
        
        return True
        
    except Exception as e:
        total_time = time.time() - pipeline_start
        print(f"\nERROR: '{purpose}' RAG 시스템 구축 실패 ({total_time:.1f}초): {e}")
        return False

def main():
    """메인 실행 함수"""
    parser = argparse.ArgumentParser(description="목적 지향 RAG 시스템 구축 파이프라인")
    parser.add_argument("--purpose", default="범용 RAG 시스템", help="RAG 시스템 구축 목적 (예: 기업 판매 지원, 고객 문의 응답)")
    parser.add_argument("--output-root", default="output", help="출력 루트 디렉토리")
    parser.add_argument("--skip-neo4j", action="store_true", help="Neo4j 적재 생략")
    
    args = parser.parse_args()
    
    # 출력 디렉토리 절대 경로로 변환
    output_root = str(Path(args.output_root).resolve())
    
    # 파이프라인 실행
    success = run_pipeline(args.purpose, output_root)
    
    if success:
        print("\n" + "="*60)
        print(f"SUCCESS: '{args.purpose}' 목적의 RAG 시스템 구축 완료!")
        print("="*60)
        print("이제 다음과 같이 질문할 수 있습니다:")
        print()
        print("Python에서:")
        print("  from rag import answer")
        print("  result = answer('당신의 질문')")
        print()
        print("Streamlit에서:")
        print("  streamlit run app.py")
        print()
        print(f"INFO: 구축된 RAG 시스템은 '{args.purpose}' 목적에 최적화되었습니다.")
        sys.exit(0)
    else:
        print(f"\nFAILED: '{args.purpose}' RAG 시스템 구축 실패")
        sys.exit(1)

if __name__ == "__main__":
    main()