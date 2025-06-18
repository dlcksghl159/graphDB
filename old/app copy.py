import os
import subprocess
import sys
import json
import time
from pathlib import Path
from typing import Dict, List
import streamlit as st

def run_pipeline(purpose: str, output_root: str):
    """Run main.py synchronously in a subprocess with detailed progress tracking."""
    # output_root에서 documents 부분 제거 (main.py에서 자동으로 documents 폴더 찾음)
    if output_root.endswith('/documents') or output_root.endswith('\\documents'):
        clean_output_root = str(Path(output_root).parent)
    else:
        clean_output_root = output_root

    cmd = [sys.executable, "main.py", "--purpose", purpose, "--output-root", clean_output_root]

    # 실시간 로그 표시를 위한 컨테이너들
    main_status = st.empty()
    progress_bar = st.progress(0)
    current_step = st.empty()
    log_container = st.container()
    log_placeholder = log_container.empty()

    # 파이프라인 단계 정의
    pipeline_steps = [
        "환경 설정",
        "문서 전처리", 
        "스키마 추출",
        "노드 추출",
        "관계 추출",
        "중복 제거",
        "Cypher 변환",
        "Neo4j 연동"
    ]
    current_step_idx = 0
    step_progress = {}

    # 디버그 모드 - session_state에 저장해서 새로고침 방지
    if 'debug_mode' not in st.session_state:
        st.session_state.debug_mode = False
    
    # 사이드바에서 디버그 모드 설정 (key를 사용해 고유성 보장)
    debug_mode = st.sidebar.checkbox(
        "디버그 모드 (로그 패턴 확인)", 
        value=st.session_state.debug_mode,
        key="debug_checkbox_pipeline"
    )
    st.session_state.debug_mode = debug_mode

    # 프로세스 실행 - Windows 한글 호환성을 위해 encoding 설정
    process = subprocess.Popen(
        cmd,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        text=True,
        bufsize=1,
        universal_newlines=True,
        encoding='utf-8',  # UTF-8 인코딩 명시적 지정
        errors='replace'   # 디코딩 오류 시 대체 문자 사용
    )

    # 실시간 로그 출력 및 진행 상황 파싱
    full_log = []
    last_step_update = 0  # 마지막 단계 업데이트 시간

    for line in process.stdout:
        line = line.rstrip()
        full_log.append(line)

        # 디버그 모드에서 모든 로그 라인 표시
        if debug_mode and line.strip():
            st.sidebar.text(f"LOG: {line[:50]}...")

        # 진행 상황 파싱 및 업데이트
        step_info = parse_pipeline_progress(line)
        if step_info:
            if debug_mode:
                st.sidebar.success(f"PARSED: {step_info['step']} - {step_info['status']}")
            current_step_idx = update_progress_display(
                step_info, pipeline_steps, current_step_idx, main_status, progress_bar, current_step, step_progress
            )
            last_step_update = time.time()
        else:
            # 개선된 폴백 로직 - 더 많은 패턴 인식
            current_time = time.time()
            
            # 단계별 키워드 매칭으로 더 정확한 진행 상황 추적
            if any(keyword in line.lower() for keyword in ["환경 설정", "setup_environment", "output_root:", "purpose:"]):
                if current_step_idx == 0:
                    main_status.info("🔄 환경 설정 중...")
                    progress_bar.progress(0.05)
                    current_step.info("⚙️ 작업 환경 준비 중")
                    
            elif any(keyword in line.lower() for keyword in ["1단계", "문서 전처리", "preprocess", "docs:"]):
                if current_step_idx <= 1:
                    current_step_idx = max(current_step_idx, 1)
                    main_status.info("🔄 문서 전처리 진행 중...")
                    progress_bar.progress(0.15)
                    current_step.info("📄 문서 파일 분석 및 청크 분할 중")
                    
            elif any(keyword in line.lower() for keyword in ["2단계", "스키마", "schema"]):
                if current_step_idx <= 2:
                    current_step_idx = max(current_step_idx, 2)
                    main_status.info("🔄 스키마 추출 진행 중...")
                    progress_bar.progress(0.3)
                    current_step.info("🗂️ 지식 그래프 스키마 생성 중")
                    
            elif any(keyword in line.lower() for keyword in ["3단계", "노드", "엔티티", "extract_node"]):
                if current_step_idx <= 3:
                    current_step_idx = max(current_step_idx, 3)
                    main_status.info("🔄 노드 추출 진행 중...")
                    progress_bar.progress(0.45)
                    current_step.info("🏷️ 엔티티 노드 추출 중")
                    
            elif any(keyword in line.lower() for keyword in ["4단계", "관계", "relation"]):
                if current_step_idx <= 4:
                    current_step_idx = max(current_step_idx, 4)
                    main_status.info("🔄 관계 추출 진행 중...")
                    progress_bar.progress(0.6)
                    current_step.info("🔗 엔티티 간 관계 추출 중")
                    
            elif any(keyword in line.lower() for keyword in ["5단계", "중복", "deduplication"]):
                if current_step_idx <= 5:
                    current_step_idx = max(current_step_idx, 5)
                    main_status.info("🔄 중복 제거 진행 중...")
                    progress_bar.progress(0.75)
                    current_step.info("🧹 중복 데이터 정제 중")
                    
            elif any(keyword in line.lower() for keyword in ["6단계", "cypher"]):
                if current_step_idx <= 6:
                    current_step_idx = max(current_step_idx, 6)
                    main_status.info("🔄 Cypher 변환 진행 중...")
                    progress_bar.progress(0.85)
                    current_step.info("⚡ Neo4j 쿼리 변환 중")
                    
            elif any(keyword in line.lower() for keyword in ["7단계", "neo4j", "send_cypher"]):
                if current_step_idx <= 7:
                    current_step_idx = max(current_step_idx, 7)
                    main_status.info("🔄 Neo4j 연동 진행 중...")
                    progress_bar.progress(0.95)
                    current_step.info("🔗 그래프 데이터베이스 구축 중")

            # 일반적인 진행 표시 - 너무 오래 업데이트가 없을 때
            elif current_time - last_step_update > 10:  # 10초 이상 업데이트 없으면
                if not step_progress:  # 아직 아무 단계도 시작되지 않았으면
                    main_status.info("🔄 RAG 시스템 구축 시작...")
                    progress_bar.progress(0.1)
                last_step_update = current_time

        # 최근 로그 표시 (더 많은 로그 라인 표시)
        recent_logs = full_log[-20:] if len(full_log) > 20 else full_log
        log_placeholder.code('\n'.join(recent_logs))

    process.wait()

    # 최종 결과 표시
    if process.returncode != 0:
        progress_bar.progress(1.0)
        main_status.error("❌ RAG 시스템 구축 실패")
        current_step.error(f"오류 코드: {process.returncode}")
        with st.expander("전체 실행 로그 보기"):
            st.code('\n'.join(full_log))
        return False
    else:
        progress_bar.progress(1.0)
        main_status.success("✅ RAG 시스템 구축 완료!")
        current_step.success("모든 단계가 성공적으로 완료되었습니다")
        # 성공 시에도 로그 확인 옵션 제공
        with st.expander("실행 로그 보기"):
            st.code('\n'.join(full_log))
        return True

def parse_pipeline_progress(log_line: str) -> Dict:
    """로그 라인에서 파이프라인 진행 상황을 파싱 - 개선된 패턴 매칭"""
    step_info = {}
    
    # 로그 라인을 소문자로 변환해서 매칭 정확도 향상
    line_lower = log_line.lower()
    
    # 더 포괄적인 패턴 매칭으로 개선
    
    # === 파이프라인 시작 ===
    if any(keyword in line_lower for keyword in ["파이프라인 시작", "rag 시스템 구축", "목적 지향"]):
        step_info = {"step": "환경 설정", "status": "진행중", "detail": "RAG 시스템 구축 시작"}
    
    # === 1단계: 환경 설정 ===
    elif any(keyword in line_lower for keyword in ["환경 설정 완료", "=== 환경 설정 완료 ==="]):
        step_info = {"step": "환경 설정", "status": "완료", "detail": "작업 환경 준비 완료"}
    elif any(keyword in log_line for keyword in ["OUTPUT_ROOT:", "PURPOSE:"]):
        step_info = {"step": "환경 설정", "status": "진행중", "detail": "작업 환경 설정 중"}
    
    # === 2단계: 문서 전처리 ===
    elif "docs:" in line_lower and ("개 파일" in line_lower or "개 청크" in line_lower):
        detail = log_line.split("DOCS: ")[-1] if "DOCS: " in log_line else "문서 청크 분할 완료"
        step_info = {"step": "문서 전처리", "status": "완료", "detail": detail}
    elif any(keyword in line_lower for keyword in ["1단계", "문서 전처리"]):
        step_info = {"step": "문서 전처리", "status": "진행중", "detail": "문서 파일 분석 및 청크 분할 중"}
    
    # === 3단계: 스키마 추출 ===
    elif any(keyword in line_lower for keyword in ["스키마 추출 완료", "schema.json"]):
        step_info = {"step": "스키마 추출", "status": "완료", "detail": "지식 그래프 스키마 생성 완료"}
    elif any(keyword in line_lower for keyword in ["2단계", "스키마 추출", "스키마"]):
        if "[" in log_line and "]" in log_line:
            import re
            match = re.search(r'\[(\d+)\]', log_line)
            if match:
                current_doc = match.group(1)
                step_info = {"step": "스키마 추출", "status": "진행중", "detail": f"{current_doc}번째 문서 스키마 분석 중"}
        else:
            step_info = {"step": "스키마 추출", "status": "진행중", "detail": "문서별 스키마 추출 중"}
    
    # === 4단계: 노드 추출 ===
    elif "노드 추출 완료" in line_lower:
        if "총 노드:" in log_line:
            detail = f"엔티티 노드 추출 완료 - {log_line.split('총 노드:')[-1].strip()}"
        else:
            detail = "엔티티 노드 추출 완료"
        step_info = {"step": "노드 추출", "status": "완료", "detail": detail}
    elif any(keyword in line_lower for keyword in ["3단계", "엔티티", "노드 추출"]):
        if "[" in log_line and "]" in log_line and "처리" in line_lower:
            import re
            match = re.search(r'\[(\d+)\]', log_line)
            if match:
                current_doc = match.group(1)
                step_info = {"step": "노드 추출", "status": "진행중", "detail": f"{current_doc}번째 문서 엔티티 추출 중"}
        else:
            step_info = {"step": "노드 추출", "status": "진행중", "detail": "엔티티 노드 추출 중"}
    
    # === 5단계: 관계 추출 ===
    elif "관계 추출 완료" in line_lower:
        step_info = {"step": "관계 추출", "status": "완료", "detail": "엔티티 간 관계 추출 완료"}
    elif any(keyword in line_lower for keyword in ["4단계", "관계 추출"]):
        if "크로스" in line_lower or "교차" in line_lower:
            step_info = {"step": "관계 추출", "status": "진행중", "detail": "문서 간 교차 관계 분석 중"}
        elif "[" in log_line and "]" in log_line:
            import re
            match = re.search(r'\[(\d+)\]', log_line)
            if match:
                current_doc = match.group(1)
                step_info = {"step": "관계 추출", "status": "진행중", "detail": f"{current_doc}번째 문서 관계 분석 중"}
        else:
            step_info = {"step": "관계 추출", "status": "진행중", "detail": "엔티티 간 관계 추출 중"}
    
    # === 6단계: 중복 제거 ===
    elif any(keyword in line_lower for keyword in ["중복 제거 완료", "품질 개선 완료"]):
        step_info = {"step": "중복 제거", "status": "완료", "detail": "데이터 품질 개선 완료"}
    elif any(keyword in line_lower for keyword in ["5단계", "중복 제거"]):
        if "llm" in line_lower or "지능형" in line_lower:
            step_info = {"step": "중복 제거", "status": "진행중", "detail": "AI 기반 중복 데이터 정제 중"}
        else:
            step_info = {"step": "중복 제거", "status": "진행중", "detail": "중복 데이터 정제 중"}
    
    # === 7단계: Cypher 변환 ===
    elif any(keyword in line_lower for keyword in ["cypher script saved", "cypher 생성 완료"]):
        step_info = {"step": "Cypher 변환", "status": "완료", "detail": "Neo4j 쿼리 변환 완료"}
    elif any(keyword in line_lower for keyword in ["6단계", "cypher"]):
        step_info = {"step": "Cypher 변환", "status": "진행중", "detail": "그래프 데이터를 Cypher 쿼리로 변환 중"}
    
    # === 8단계: Neo4j 연동 ===
    elif any(keyword in line_lower for keyword in ["all nodes are now embedded", "done inserting data", "neo4j 적재 완료"]):
        step_info = {"step": "Neo4j 연동", "status": "완료", "detail": "그래프 데이터베이스 구축 완료"}
    elif any(keyword in line_lower for keyword in ["7단계", "neo4j"]):
        if "applied" in line_lower and "schema" in line_lower:
            step_info = {"step": "Neo4j 연동", "status": "진행중", "detail": "데이터베이스 스키마 적용 중"}
        elif "committed" in line_lower and "data" in line_lower:
            step_info = {"step": "Neo4j 연동", "status": "진행중", "detail": "그래프 데이터 저장 중"}
        elif "embedded" in line_lower and "nodes" in line_lower:
            step_info = {"step": "Neo4j 연동", "status": "진행중", "detail": "노드 벡터 임베딩 생성 중"}
        else:
            step_info = {"step": "Neo4j 연동", "status": "진행중", "detail": "Neo4j 데이터베이스 연동 중"}
    
    # === 범용 완료 패턴 ===
    elif "ok:" in line_lower:
        if "스키마" in line_lower:
            step_info = {"step": "스키마 추출", "status": "완료", "detail": "스키마 추출 완료"}
        elif "노드" in line_lower:
            step_info = {"step": "노드 추출", "status": "완료", "detail": "노드 추출 완료"}
        elif "관계" in line_lower:
            step_info = {"step": "관계 추출", "status": "완료", "detail": "관계 추출 완료"}
        elif "중복" in line_lower:
            step_info = {"step": "중복 제거", "status": "완료", "detail": "중복 제거 완료"}
        elif "cypher" in line_lower:
            step_info = {"step": "Cypher 변환", "status": "완료", "detail": "Cypher 변환 완료"}
        elif "neo4j" in line_lower:
            step_info = {"step": "Neo4j 연동", "status": "완료", "detail": "Neo4j 연동 완료"}
    
    # === 최종 성공 메시지 ===
    elif any(keyword in line_lower for keyword in ["rag 시스템 구축 완료", "success:"]):
        step_info = {"step": "Neo4j 연동", "status": "완료", "detail": "RAG 시스템 구축 완료!"}
    
    return step_info

def update_progress_display(step_info: Dict, pipeline_steps: List[str], current_step_idx: int, main_status, progress_bar, current_step, step_progress) -> int:
    """진행 상황 디스플레이 업데이트"""
    step_name = step_info.get("step", "")
    status = step_info.get("status", "")
    detail = step_info.get("detail", "")

    if step_name in pipeline_steps:
        step_idx = pipeline_steps.index(step_name)
        # 현재 단계 인덱스 업데이트
        if step_idx > current_step_idx:
            current_step_idx = step_idx

        # 단계별 진행 상황 저장
        step_progress[step_name] = {"status": status, "detail": detail}

        # 진행률 계산
        if status == "완료":
            progress = min((step_idx + 1) / len(pipeline_steps), 1.0)
        else:
            progress = step_idx / len(pipeline_steps)
        progress_bar.progress(progress)

        # 메인 상태 표시
        if status == "완료":
            main_status.success(f"✅ {step_name} 완료")
        elif status == "진행중":
            main_status.info(f"🔄 {step_name} 진행 중...")
        else:
            main_status.info(f"⏳ {step_name} 시작...")

        # 현재 단계 상세 정보
        if detail:
            if status == "완료":
                current_step.success(f"✅ {detail}")
            elif status == "진행중":
                current_step.info(f"🔄 {detail}")
            else:
                current_step.info(f"⏳ {detail}")

    return current_step_idx

# ────────────────────────────────────────────────────────────────
# Streamlit pages (simple manual switch via session_state)
# ────────────────────────────────────────────────────────────────

if "stage" not in st.session_state:
    st.session_state.stage = "config"

# config → rag
if st.session_state.stage == "config":
    st.title("📚 문서 기반 RAG 시스템 구축")
    st.markdown("""
    ### 📋 사용 안내
    1. **RAG 시스템 구축 목적**을 명확히 입력하세요 (예: "기업 판매 지원", "고객 문의 응답", "기술 문서 검색")
    2. **문서 폴더 경로**에 RAG 시스템에서 활용할 문서들이 있는지 확인하세요
    3. 지원 파일 형식: `.txt`, `.md`, `.doc`, `.docx`, `.pdf`
    4. 구축된 RAG 시스템은 입력된 목적에 맞게 최적화됩니다
    """)

    with st.form("config_form"):
        purpose = st.text_input(
            "* RAG 시스템 구축 목적을 입력하세요:",
            value="기업 판매 지원",
            help="RAG 시스템이 어떤 용도로 사용될지 명확히 입력하세요 (예: 기업 판매 지원, 고객 문의 응답, 기술 문서 검색)"
        )
        output_root = st.text_input(
            "* 문서가 위치한 폴더 경로를 입력하세요:",
            value="output/documents",
            help="분석할 문서들이 있는 폴더 경로 (예: C:/documents, ./my_docs/documents)"
        )
        submitted = st.form_submit_button("🚀 RAG 시스템 구축 시작", use_container_width=True)

        # 폴더 검증
        if output_root:
            doc_path = Path(output_root)
            if doc_path.exists():
                # 문서 파일 개수 확인
                doc_files = []
                for ext in ['*.txt', '*.md', '*.doc', '*.docx', '*.pdf']:
                    doc_files.extend(doc_path.glob(ext))
                if doc_files:
                    st.success(f"✅ {len(doc_files)}개 문서 파일 발견")
                    with st.expander("발견된 파일 목록"):
                        for file in doc_files[:10]:  # 최대 10개만 표시
                            st.text(f"📄 {file.name}")
                        if len(doc_files) > 10:
                            st.text(f"... 외 {len(doc_files) - 10}개 파일")
                else:
                    st.warning("⚠️ 지원되는 문서 파일이 없습니다. (.txt, .md, .doc, .docx, .pdf)")
            else:
                st.error("❌ 폴더가 존재하지 않습니다.")

        if submitted:
            if not purpose.strip():
                st.error("RAG 시스템 구축 목적을 입력해주세요.")
                st.stop()
            output_root_path = Path(output_root).expanduser().resolve()
            # documents 폴더가 없다면 생성
            if not output_root_path.exists():
                st.error(f"지정된 경로가 존재하지 않습니다: {output_root_path}")
                st.stop()

            st.markdown("---")
            st.markdown("### 🔄 RAG 시스템 구축 진행 상황")
            st.info(f"📌 구축 목적: **{purpose}**에 최적화된 RAG 시스템을 구축합니다.")
            success = run_pipeline(purpose, str(output_root_path))
            if success:
                st.session_state.purpose = purpose
                st.session_state.output_root = str(output_root_path.parent if output_root_path.name == 'documents' else output_root_path)
                st.session_state.stage = "rag"
                st.rerun()

elif st.session_state.stage == "rag":
    st.title("💬 RAG QA Interface")
    purpose = st.session_state.get("purpose", "문서 분석")
    output_root = st.session_state.get("output_root", "output")

    # 사이드바 정보
    with st.sidebar:
        st.header("📊 RAG 시스템 정보")
        st.write(f"**구축 목적:** {purpose}")
        st.write(f"**작업 디렉토리:** {output_root}")
        if st.button("🔄 새 RAG 시스템 구축", use_container_width=True):
            st.session_state.stage = "config"
            st.rerun()

    # 시스템 상태 확인
    st.markdown("---")
    st.subheader("🔍 시스템 상태")

    # 파일 존재 여부 확인
    result_file = Path(output_root) / "result" / "result.json"
    cypher_file = Path(output_root) / "graph.cypher"

    if result_file.exists():
        st.success("✅ RAG 시스템 준비 완료")
        try:
            import json
            with open(result_file, 'r', encoding='utf-8') as f:
                data = json.load(f)
            st.write(f"- 추출된 엔티티: {len(data.get('nodes', []))} 개")
            st.write(f"- 추출된 관계: {len(data.get('relations', []))} 개")
        except:
            pass
    else:
        st.error("❌ RAG 시스템 구축 미완료")

    # Neo4j 연결 테스트
    try:
        from dotenv import load_dotenv
        load_dotenv()
        NEO4J_URI = os.getenv("NEO4J_URI", "bolt://localhost:7687")
        NEO4J_USERNAME = os.getenv("NEO4J_USERNAME", "neo4j")
        NEO4J_PASSWORD = os.getenv("NEO4J_PASSWORD", "password")

        from neo4j import GraphDatabase
        driver = GraphDatabase.driver(NEO4J_URI, auth=(NEO4J_USERNAME, NEO4J_PASSWORD))
        with driver.session() as session:
            result = session.run("RETURN 1 as test")
            if result.single():
                st.success("✅ Neo4j 연결됨")
            else:
                st.error("❌ Neo4j 연결 실패")
        driver.close()
    except Exception as e:
        st.warning("⚠️ Neo4j 연결 불가 (파일 기반 모드)")
        with st.expander("Neo4j 설정 도움말"):
            st.write("""
            **Neo4j 설정 단계:**
            1. Neo4j Desktop 설치 및 실행
            2. 새 데이터베이스 생성
            3. APOC 플러그인 설치
            4. .env 파일에 연결 정보 설정
            """)

    # 샘플 질문
    st.markdown("---")
    st.subheader("💡 샘플 질문")

    # RAG 목적에 따른 맞춤형 질문 생성
    if "판매" in purpose.lower() or "영업" in purpose.lower():
        sample_questions = [
            "주요 제품이나 서비스는 무엇인가요?",
            "경쟁사 대비 우리의 강점은 무엇인가요?",
            "주요 고객은 누구인가요?",
            "가격 정책은 어떻게 되나요?",
            "성공 사례를 알려주세요"
        ]
    elif "기술" in purpose.lower() or "개발" in purpose.lower():
        sample_questions = [
            "주요 기술 스택은 무엇인가요?",
            "API 사용 방법을 알려주세요",
            "시스템 요구사항은 무엇인가요?",
            "문제 해결 방법을 알려주세요",
            "업데이트 내역을 확인하고 싶습니다"
        ]
    elif "고객" in purpose.lower() or "문의" in purpose.lower():
        sample_questions = [
            "자주 묻는 질문이 무엇인가요?",
            "문제 해결 절차를 알려주세요",
            "연락처나 지원 방법은?",
            "서비스 이용 방법을 설명해주세요",
            "요금이나 정책을 알려주세요"
        ]
    else:
        sample_questions = [
            "주요 내용을 요약해주세요",
            "핵심 인물은 누구인가요?",
            "중요한 개념이나 용어는?",
            "주요 사건이나 이벤트는?",
            "관련 조직이나 기관은?"
        ]

    for i, q in enumerate(sample_questions):
        if st.button(f"Q{i+1}: {q}", key=f"sample_{i}", use_container_width=True):
            st.session_state.current_query = q

    # RAG 모듈 로드
    if "rag_module" not in st.session_state:
        try:
            import importlib.util
            rag_path = Path(__file__).with_name("rag.py")
            spec = importlib.util.spec_from_file_location("rag", rag_path)
            rag = importlib.util.module_from_spec(spec)
            spec.loader.exec_module(rag)
            st.session_state.rag_module = rag
        except Exception as e:
            st.error(f"RAG 모듈 로드 실패: {e}")
            st.stop()

    rag_mod = st.session_state.rag_module

    # 질문 입력
    default_query = st.session_state.get("current_query", "")
    # 목적에 맞는 플레이스홀더 텍스트
    if "판매" in purpose.lower():
        placeholder = "예: 우리 제품의 주요 특징과 경쟁 우위를 설명해주세요"
    elif "기술" in purpose.lower():
        placeholder = "예: 이 시스템의 주요 기능과 사용 방법을 알려주세요"
    elif "고객" in purpose.lower():
        placeholder = "예: 이 문제를 해결하는 방법을 단계별로 설명해주세요"
    else:
        placeholder = "예: 주요 내용을 요약하고 핵심 포인트를 알려주세요"

    query = st.text_input(
        "❓ 질문을 입력하세요:",
        value=default_query,
        placeholder=placeholder
    )

    # 현재 쿼리 초기화
    if "current_query" in st.session_state:
        del st.session_state.current_query

    col1, col2 = st.columns([3, 1])
    with col1:
        ask_button = st.button("🔍 답변 생성", use_container_width=True)
    with col2:
        clear_button = st.button("🗑️ 초기화", use_container_width=True)
    if clear_button:
        st.rerun()

    if ask_button and query.strip():
        with st.spinner("🤔 답변을 생성하고 있습니다..."):
            try:
                # 환경 변수 설정 (RAG 모듈에서 사용)
                os.environ["OUTPUT_ROOT"] = output_root
                answer = rag_mod.answer(query)
                if not answer or answer.strip() == "":
                    answer = f"""
                    죄송합니다. **{purpose}** 목적과 관련된 해당 질문에 대한 답변을 찾을 수 없습니다.
                    다음과 같이 시도해보세요:
                    - 구축된 RAG 시스템의 목적({purpose})에 맞는 질문인지 확인해보세요
                    - 더 구체적인 질문으로 바꿔보세요
                    - 문서에 실제로 포함된 내용인지 확인해보세요
                    - 다른 키워드를 사용해보세요
                    """
            except Exception as e:
                answer = f"""
                **{purpose}** RAG 시스템 답변 생성 중 오류가 발생했습니다: {str(e)}
                문제 해결을 위해:
                1. Neo4j 데이터베이스가 실행 중인지 확인하세요
                2. OpenAI API 키가 올바르게 설정되었는지 확인하세요
                3. RAG 시스템 구축이 성공적으로 완료되었는지 확인하세요
                4. 질문이 구축 목적({purpose})에 적합한지 확인하세요
                """
                st.error(f"오류 세부사항: {str(e)}")

        # 답변 표시
        st.markdown("---")
        st.markdown("### 📝 답변")
        st.markdown(answer)

        # 답변 히스토리 저장 (선택적)
        if "qa_history" not in st.session_state:
            st.session_state.qa_history = []
        st.session_state.qa_history.append({
            "question": query,
            "answer": answer,
            "timestamp": time.time()
        })

        # 히스토리 표시 (최근 3개)
        if len(st.session_state.qa_history) > 1:
            with st.expander("📚 최근 질문 히스토리"):
                for i, qa in enumerate(reversed(st.session_state.qa_history[-3:])):
                    st.markdown(f"**Q{len(st.session_state.qa_history)-i}:** {qa['question']}")
                    st.markdown(f"**A:** {qa['answer'][:200]}...")

    st.markdown("---")
    st.markdown("")
