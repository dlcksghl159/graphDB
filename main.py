#!/usr/bin/env python3
"""
enhanced_main_pipeline.py
========================
향상된 지식 그래프 구축 파이프라인 통합 실행 스크립트

PDF 분석을 바탕으로 개선된 전체 파이프라인을 순차적으로 실행합니다.
각 단계별 품질 검증과 성능 모니터링을 포함합니다.
"""

import os
import sys
import time
import json
import argparse
from pathlib import Path
from typing import Dict, List, Any
from datetime import datetime

# 개선된 모듈들 import
try:
    from enhanced_schema_multi import main as extract_enhanced_schema
    from enhanced_extract_node_kr import main as extract_enhanced_nodes
    from enhanced_extract_relation_kr import main as extract_enhanced_relations
    from enhanced_deduplication_validation import main_enhanced_deduplication
    from cypher import main as generate_cypher
    from send_cypher import main as send_cypher
    from enhanced_rag import enhanced_answer, analyze_entity_connections
except ImportError as e:
    print(f"⚠️ 모듈 import 오류: {e}")
    print("개선된 모듈 파일들이 같은 디렉토리에 있는지 확인하세요.")
    sys.exit(1)

class PipelineMonitor:
    """파이프라인 실행 모니터링 클래스"""
    
    def __init__(self, output_root: str):
        self.output_root = Path(output_root)
        self.start_time = time.time()
        self.steps = {}
        self.log_file = self.output_root / "pipeline_log.json"
        
    def start_step(self, step_name: str, description: str = ""):
        """단계 시작 기록"""
        self.steps[step_name] = {
            "description": description,
            "start_time": time.time(),
            "end_time": None,
            "duration": 0,
            "status": "running",
            "metrics": {},
            "errors": []
        }
        print(f"🚀 {step_name}: {description}")
        
    def end_step(self, step_name: str, status: str = "success", metrics: Dict = None, errors: List = None):
        """단계 완료 기록"""
        if step_name in self.steps:
            self.steps[step_name]["end_time"] = time.time()
            self.steps[step_name]["duration"] = self.steps[step_name]["end_time"] - self.steps[step_name]["start_time"]
            self.steps[step_name]["status"] = status
            self.steps[step_name]["metrics"] = metrics or {}
            self.steps[step_name]["errors"] = errors or []
            
            duration = self.steps[step_name]["duration"]
            status_emoji = "✅" if status == "success" else "❌" if status == "error" else "⚠️"
            print(f"{status_emoji} {step_name} 완료 ({duration:.1f}초)")
            
            if metrics:
                for key, value in metrics.items():
                    print(f"   📊 {key}: {value}")
    
    def save_log(self):
        """로그 저장"""
        log_data = {
            "pipeline_start": self.start_time,
            "pipeline_end": time.time(),
            "total_duration": time.time() - self.start_time,
            "timestamp": datetime.now().isoformat(),
            "steps": self.steps
        }
        
        with open(self.log_file, "w", encoding="utf-8") as f:
            json.dump(log_data, f, ensure_ascii=False, indent=2)
        
        print(f"📝 실행 로그 저장: {self.log_file}")

def validate_environment():
    """환경 설정 검증"""
    required_env_vars = ["OPENAI_API_KEY", "NEO4J_URI", "NEO4J_USERNAME", "NEO4J_PASSWORD"]
    missing_vars = []
    
    for var in required_env_vars:
        if not os.getenv(var):
            missing_vars.append(var)
    
    if missing_vars:
        print(f"❌ 필수 환경 변수가 설정되지 않았습니다: {missing_vars}")
        return False
    
    print("✅ 환경 설정 검증 완료")
    return True

def check_input_files(chunks_dir: Path) -> Dict[str, Any]:
    """입력 파일 검증"""
    if not chunks_dir.exists():
        return {"status": "error", "message": f"청크 디렉토리가 없습니다: {chunks_dir}"}
    
    chunk_files = list(chunks_dir.glob("chunked_output_*.txt"))
    if not chunk_files:
        return {"status": "error", "message": "청크 파일이 없습니다"}
    
    total_size = sum(f.stat().st_size for f in chunk_files)
    
    return {
        "status": "success",
        "file_count": len(chunk_files),
        "total_size_mb": total_size / (1024 * 1024),
        "files": [f.name for f in chunk_files[:5]]  # 처음 5개만
    }

def analyze_extraction_quality(result_file: Path) -> Dict[str, Any]:
    """추출 품질 분석"""
    if not result_file.exists():
        return {"status": "error", "message": "결과 파일이 없습니다"}
    
    try:
        with open(result_file, "r", encoding="utf-8") as f:
            data = json.load(f)
        
        nodes = data.get("nodes", [])
        relations = data.get("relations", [])
        
        # 노드 분석
        node_types = {}
        nodes_with_aliases = 0
        nodes_with_properties = 0
        
        for node in nodes:
            label = node.get("label", "UNKNOWN")
            node_types[label] = node_types.get(label, 0) + 1
            
            props = node.get("properties", {})
            if "aliases" in props:
                nodes_with_aliases += 1
            if len(props) > 0:
                nodes_with_properties += 1
        
        # 관계 분석
        relation_types = {}
        for rel in relations:
            rel_type = rel.get("relationship", "UNKNOWN")
            relation_types[rel_type] = relation_types.get(rel_type, 0) + 1
        
        # 연결성 분석
        referenced_nodes = set()
        for rel in relations:
            referenced_nodes.add(rel.get("start_node"))
            referenced_nodes.add(rel.get("end_node"))
        
        connectivity = len(referenced_nodes) / len(nodes) if nodes else 0
        
        return {
            "status": "success",
            "total_nodes": len(nodes),
            "total_relations": len(relations),
            "node_types": node_types,
            "relation_types": relation_types,
            "nodes_with_aliases": nodes_with_aliases,
            "nodes_with_properties": nodes_with_properties,
            "connectivity_score": connectivity,
            "orphaned_nodes": len(nodes) - len(referenced_nodes)
        }
    
    except Exception as e:
        return {"status": "error", "message": str(e)}

def run_enhanced_pipeline(purpose: str = "뉴스 기사 분석", skip_steps: List[str] = None):
    """향상된 파이프라인 실행"""
    
    skip_steps = skip_steps or []
    OUTPUT_ROOT = os.getenv("OUTPUT_ROOT", "output")
    monitor = PipelineMonitor(OUTPUT_ROOT)
    
    # 환경 검증
    if not validate_environment():
        return False
    
    # 입력 파일 검증
    chunks_dir = Path(OUTPUT_ROOT) / "chunked_document"
    input_check = check_input_files(chunks_dir)
    if input_check["status"] == "error":
        print(f"❌ 입력 파일 검증 실패: {input_check['message']}")
        return False
    
    print(f"📁 입력 파일: {input_check['file_count']}개 ({input_check['total_size_mb']:.1f}MB)")
    
    try:
        # 1단계: 향상된 스키마 추출
        if "schema" not in skip_steps:
            monitor.start_step("enhanced_schema", "확장된 스키마 추출")
            try:
                extract_enhanced_schema(purpose)
                
                # 스키마 품질 검증
                schema_file = Path(OUTPUT_ROOT) / "schema" / "schema.json"
                if schema_file.exists():
                    with open(schema_file, "r", encoding="utf-8") as f:
                        schema_data = json.load(f)
                    
                    schema_metrics = {
                        "node_types": len(schema_data.get("nodes", [])),
                        "relation_types": len(schema_data.get("relations", [])),
                        "file_size_kb": schema_file.stat().st_size / 1024
                    }
                    monitor.end_step("enhanced_schema", "success", schema_metrics)
                else:
                    monitor.end_step("enhanced_schema", "error", errors=["스키마 파일 생성 실패"])
                    
            except Exception as e:
                monitor.end_step("enhanced_schema", "error", errors=[str(e)])
                raise
        
        # 2단계: 향상된 노드 추출
        if "nodes" not in skip_steps:
            monitor.start_step("enhanced_nodes", "향상된 엔티티 추출 (NER 폴백 포함)")
            try:
                extract_enhanced_nodes(purpose)
                
                # 노드 품질 분석
                result_file = Path(OUTPUT_ROOT) / "result" / "result.json"
                node_quality = analyze_extraction_quality(result_file)
                if node_quality["status"] == "success":
                    monitor.end_step("enhanced_nodes", "success", node_quality)
                else:
                    monitor.end_step("enhanced_nodes", "warning", errors=[node_quality["message"]])
                    
            except Exception as e:
                monitor.end_step("enhanced_nodes", "error", errors=[str(e)])
                raise
        
        # 3단계: 향상된 관계 추출
        if "relations" not in skip_steps:
            monitor.start_step("enhanced_relations", "확장된 관계 추출 (패턴 매칭 + 크로스청크)")
            try:
                extract_enhanced_relations(purpose)
                
                # 관계 품질 분석
                enhanced_result_file = Path(OUTPUT_ROOT) / "result" / "result_enhanced.json"
                if enhanced_result_file.exists():
                    relation_quality = analyze_extraction_quality(enhanced_result_file)
                    if relation_quality["status"] == "success":
                        monitor.end_step("enhanced_relations", "success", relation_quality)
                    else:
                        monitor.end_step("enhanced_relations", "warning", errors=[relation_quality["message"]])
                else:
                    monitor.end_step("enhanced_relations", "error", errors=["관계 추출 파일 생성 실패"])
                    
            except Exception as e:
                monitor.end_step("enhanced_relations", "error", errors=[str(e)])
                raise
        
        # 4단계: 향상된 중복 제거 및 검증
        if "deduplication" not in skip_steps:
            monitor.start_step("enhanced_dedup", "지능형 중복 제거 및 품질 검증")
            try:
                result_file = Path(OUTPUT_ROOT) / "result" / "result.json"
                
                # 중복 제거 전 품질 측정
                pre_quality = analyze_extraction_quality(result_file)
                
                main_enhanced_deduplication(str(result_file))
                
                # 중복 제거 후 품질 측정
                post_quality = analyze_extraction_quality(result_file)
                
                if pre_quality["status"] == "success" and post_quality["status"] == "success":
                    dedup_metrics = {
                        "nodes_before": pre_quality["total_nodes"],
                        "nodes_after": post_quality["total_nodes"],
                        "relations_before": pre_quality["total_relations"],
                        "relations_after": post_quality["total_relations"],
                        "connectivity_improvement": post_quality["connectivity_score"] - pre_quality["connectivity_score"],
                        "orphaned_reduction": pre_quality["orphaned_nodes"] - post_quality["orphaned_nodes"]
                    }
                    monitor.end_step("enhanced_dedup", "success", dedup_metrics)
                else:
                    monitor.end_step("enhanced_dedup", "error", errors=["품질 분석 실패"])
                    
            except Exception as e:
                monitor.end_step("enhanced_dedup", "error", errors=[str(e)])
                raise
        
        # 5단계: Cypher 스크립트 생성
        if "cypher" not in skip_steps:
            monitor.start_step("cypher_generation", "Neo4j Cypher 스크립트 생성")
            try:
                generate_cypher()
                
                cypher_file = Path(OUTPUT_ROOT) / "graph.cypher"
                if cypher_file.exists():
                    cypher_metrics = {
                        "file_size_kb": cypher_file.stat().st_size / 1024,
                        "line_count": len(cypher_file.read_text(encoding="utf-8").splitlines())
                    }
                    monitor.end_step("cypher_generation", "success", cypher_metrics)
                else:
                    monitor.end_step("cypher_generation", "error", errors=["Cypher 파일 생성 실패"])
                    
            except Exception as e:
                monitor.end_step("cypher_generation", "error", errors=[str(e)])
                raise
        
        # 6단계: Neo4j 데이터베이스 로딩
        if "neo4j" not in skip_steps:
            monitor.start_step("neo4j_loading", "Neo4j 데이터베이스 로딩 및 임베딩")
            try:
                # Neo4j 로딩은 별도 함수가 없으므로 send_cypher 모듈 실행
                import subprocess
                result = subprocess.run([sys.executable, "send_cypher.py"], 
                                      capture_output=True, text=True)
                
                if result.returncode == 0:
                    neo4j_metrics = {
                        "loading_success": True,
                        "stdout_lines": len(result.stdout.splitlines()),
                        "stderr_lines": len(result.stderr.splitlines())
                    }
                    monitor.end_step("neo4j_loading", "success", neo4j_metrics)
                else:
                    monitor.end_step("neo4j_loading", "error", errors=[result.stderr])
                    
            except Exception as e:
                monitor.end_step("neo4j_loading", "error", errors=[str(e)])
                raise
        
        # 최종 품질 리포트
        monitor.start_step("final_report", "최종 품질 리포트 생성")
        try:
            final_result_file = Path(OUTPUT_ROOT) / "result" / "result.json"
            final_quality = analyze_extraction_quality(final_result_file)
            
            if final_quality["status"] == "success":
                print("\n" + "="*60)
                print("📊 최종 지식 그래프 품질 리포트")
                print("="*60)
                print(f"총 노드: {final_quality['total_nodes']:,}개")
                print(f"총 관계: {final_quality['total_relations']:,}개")
                print(f"연결성 점수: {final_quality['connectivity_score']:.3f}")
                print(f"고립된 노드: {final_quality['orphaned_nodes']}개")
                print(f"별칭 보유 노드: {final_quality['nodes_with_aliases']}개")
                print(f"속성 보유 노드: {final_quality['nodes_with_properties']}개")
                
                print("\n📈 노드 타입 분포:")
                for node_type, count in sorted(final_quality['node_types'].items(), key=lambda x: x[1], reverse=True):
                    print(f"   {node_type}: {count}개")
                
                print("\n📈 관계 타입 분포 (상위 10개):")
                sorted_relations = sorted(final_quality['relation_types'].items(), key=lambda x: x[1], reverse=True)
                for rel_type, count in sorted_relations[:10]:
                    print(f"   {rel_type}: {count}개")
                
                monitor.end_step("final_report", "success", final_quality)
            else:
                monitor.end_step("final_report", "error", errors=[final_quality["message"]])
                
        except Exception as e:
            monitor.end_step("final_report", "error", errors=[str(e)])
        
        # 로그 저장
        monitor.save_log()
        
        total_duration = time.time() - monitor.start_time
        print(f"\n🎉 향상된 파이프라인 실행 완료 (총 {total_duration:.1f}초)")
        return True
        
    except Exception as e:
        print(f"\n❌ 파이프라인 실행 실패: {e}")
        monitor.save_log()
        return False

def quick_test_rag(test_questions: List[str] = None):
    """RAG 시스템 간단 테스트"""
    if test_questions is None:
        test_questions = [
            "구글에서 일하는 사람은 누구인가요?",
            "삼성전자의 본사는 어디에 있나요?",
            "네이버와 협력하는 회사는 어떤 곳들이 있나요?",
            "AI 기술을 개발하는 회사들을 알려주세요",
            "최근에 투자받은 회사는 어디인가요?"
        ]
    
    print("\n" + "="*50)
    print("🧪 RAG 시스템 성능 테스트")
    print("="*50)
    
    for i, question in enumerate(test_questions, 1):
        print(f"\n[{i}/{len(test_questions)}] 질문: {question}")
        
        start_time = time.time()
        try:
            answer = enhanced_answer(question)
            duration = time.time() - start_time
            
            print(f"답변: {answer}")
            print(f"응답시간: {duration:.2f}초")
            
        except Exception as e:
            print(f"❌ 오류: {e}")

def main():
    """메인 실행 함수"""
    parser = argparse.ArgumentParser(description="향상된 지식 그래프 구축 파이프라인")
    parser.add_argument("--purpose", default="뉴스 기사 분석", help="분석 목적")
    parser.add_argument("--skip", nargs="*", default=[], 
                       choices=["schema", "nodes", "relations", "deduplication", "cypher", "neo4j"],
                       help="건너뛸 단계들")
    parser.add_argument("--test-rag", action="store_true", help="RAG 시스템 테스트 실행")
    parser.add_argument("--quick-test", action="store_true", help="빠른 테스트만 실행")
    
    args = parser.parse_args()
    
    print("🚀 향상된 지식 그래프 구축 파이프라인 시작")
    print(f"📋 분석 목적: {args.purpose}")
    if args.skip:
        print(f"⏭️ 건너뛸 단계: {args.skip}")
    
    if args.quick_test:
        # 빠른 테스트만 실행
        quick_test_rag()
        return
    
    # 전체 파이프라인 실행
    success = run_enhanced_pipeline(args.purpose, args.skip)
    
    if success and args.test_rag:
        # RAG 테스트 실행
        quick_test_rag()

if __name__ == "__main__":
    main()