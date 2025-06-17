import os
import sys
import time
import shutil
from pathlib import Path
from typing import List
import streamlit as st

# Windows 환경에서 UTF-8 출력 설정
if sys.platform.startswith('win'):
    import locale
    import codecs
    if sys.stdout.encoding != 'utf-8':
        sys.stdout = codecs.getwriter('utf-8')(sys.stdout.buffer, 'strict')
        sys.stderr = codecs.getwriter('utf-8')(sys.stderr.buffer, 'strict')

def setup_environment(output_root: str, purpose: str):
    """환경 변수 설정 및 디렉토리 구조 생성"""
    os.environ["OUTPUT_ROOT"] = output_root
    os.environ["PURPOSE"] = purpose
    
    directories = [
        f"{output_root}/documents",
        f"{output_root}/chunked_document", 
        f"{output_root}/schema",
        f"{output_root}/result"
    ]
    
    for dir_path in directories:
        Path(dir_path).mkdir(parents=True, exist_ok=True)
    
    return True

def preprocess_documents(output_root: str) -> int:
    """documents 폴더의 파일들을 chunked_document로 복사/전처리"""
    documents_dir = Path(output_root) / "documents"
    chunked_dir = Path(output_root) / "chunked_document"
    
    # 기존 chunked_document 내용 삭제
    if chunked_dir.exists():
        shutil.rmtree(chunked_dir)
    chunked_dir.mkdir(parents=True, exist_ok=True)
    
    # 문서 수집
    document_files = []
    for ext in ['*.txt', '*.md', '*.doc', '*.docx', '*.pdf']:
        document_files.extend(documents_dir.glob(ext))
    
    if not document_files:
        raise FileNotFoundError(f"DOCUMENTS 폴더 {documents_dir}에서 문서를 찾을 수 없습니다.")
    
    chunk_count = 0
    for i, doc_file in enumerate(document_files):
        try:
            if doc_file.suffix.lower() in ['.txt', '.md']:
                content = doc_file.read_text(encoding='utf-8')
            else:
                content = f"문서 파일: {doc_file.name}\n내용을 추출할 수 없습니다."
            
            chunk_size = 5000
            if len(content) > chunk_size:
                for j in range(0, len(content), chunk_size):
                    chunk_content = content[j:j+chunk_size]
                    chunk_file = chunked_dir / f"chunked_output_{chunk_count}.txt"
                    chunk_file.write_text(chunk_content, encoding='utf-8')
                    chunk_count += 1
            else:
                chunk_file = chunked_dir / f"chunked_output_{chunk_count}.txt"
                chunk_file.write_text(content, encoding='utf-8')
                chunk_count += 1
                
        except Exception as e:
            print(f"파일 처리 오류 {doc_file.name}: {e}")
            continue
    
    return chunk_count, len(document_files)

@st.cache_data
def load_module_safely(module_name: str):
    """모듈을 안전하게 로드"""
    try:
        if module_name == "extract_schema":
            import extract_schema
            return extract_schema
        elif module_name == "extract_node":
            import extract_node
            return extract_node
        elif module_name == "extract_relation":
            import extract_relation
            return extract_relation
        elif module_name == "deduplication":
            import deduplication
            return deduplication
        elif module_name == "create_cypher":
            import create_cypher
            return create_cypher
        elif module_name == "send_cypher":
            import send_cypher
            return send_cypher
        else:
            return None
    except ImportError as e:
        return None

def run_step_safe(step_name: str, module_name: str, purpose: str = None) -> tuple[bool, str]:
    """안전하게 파이프라인 단계 실행"""
    start_time = time.time()
    
    try:
        # Windows 환경 변수 설정
        env = os.environ.copy()
        env['PYTHONIOENCODING'] = 'utf-8'
        env['PYTHONUNBUFFERED'] = '1'
        
        if module_name == "schema":
            import subprocess
            cmd = [sys.executable, "-c", f"""
import sys
import os
sys.path.append('.')
os.environ['OUTPUT_ROOT'] = r'{os.getenv("OUTPUT_ROOT", "output")}'
os.environ['PURPOSE'] = r'{purpose or "문서 분석"}'
from extract_schema import main
main(r'{purpose or "문서 분석"}')
"""]
            result = subprocess.run(
                cmd, 
                capture_output=True, 
                text=True, 
                encoding='utf-8',
                errors='replace',  # 디코딩 오류 시 대체 문자 사용
                env=env
            )
            if result.returncode != 0:
                raise Exception(f"스키마 추출 실패: {result.stderr}")
                
        elif module_name == "extract_node":
            import subprocess
            cmd = [sys.executable, "-c", f"""
import sys
import os
sys.path.append('.')
os.environ['OUTPUT_ROOT'] = r'{os.getenv("OUTPUT_ROOT", "output")}'
os.environ['PURPOSE'] = r'{purpose or "문서 분석"}'
from extract_node import main
main(r'{purpose or "문서 분석"}')
"""]
            result = subprocess.run(
                cmd, 
                capture_output=True, 
                text=True, 
                encoding='utf-8',
                errors='replace',
                env=env
            )
            if result.returncode != 0:
                raise Exception(f"노드 추출 실패: {result.stderr}")
                
        elif module_name == "extract_relation":
            import subprocess
            cmd = [sys.executable, "-c", f"""
import sys
import os
sys.path.append('.')
os.environ['OUTPUT_ROOT'] = r'{os.getenv("OUTPUT_ROOT", "output")}'
os.environ['PURPOSE'] = r'{purpose or "문서 분석"}'
from extract_relation import main
main(r'{purpose or "문서 분석"}')
"""]
            result = subprocess.run(
                cmd, 
                capture_output=True, 
                text=True, 
                encoding='utf-8',
                errors='replace',
                env=env
            )
            if result.returncode != 0:
                raise Exception(f"관계 추출 실패: {result.stderr}")
                
        elif module_name == "deduplication":
            output_root_raw = os.getenv("OUTPUT_ROOT", "output")
            result_file = f"{output_root_raw}/result/result.json"
            if not Path(result_file).exists():
                return True, f"결과 파일이 없어 중복 제거를 건너뜁니다"
            
            import subprocess
            cmd = [sys.executable, "-c", f"""
import sys
import os
sys.path.append('.')
os.environ['OUTPUT_ROOT'] = r'{output_root_raw}'
from deduplication import deduplicate
deduplicate(r'{result_file}')
"""]
            result = subprocess.run(
                cmd, 
                capture_output=True, 
                text=True, 
                encoding='utf-8',
                errors='replace',
                env=env
            )
            if result.returncode != 0:
                raise Exception(f"중복 제거 실패: {result.stderr}")
                
        elif module_name == "cypher":
            import subprocess
            cmd = [sys.executable, "-c", f"""
import sys
import os
sys.path.append('.')
os.environ['OUTPUT_ROOT'] = r'{os.getenv("OUTPUT_ROOT", "output")}'
from create_cypher import main
main()
"""]
            result = subprocess.run(
                cmd, 
                capture_output=True, 
                text=True, 
                encoding='utf-8',
                errors='replace',
                env=env
            )
            if result.returncode != 0:
                raise Exception(f"Cypher 생성 실패: {result.stderr}")
                
        elif module_name == "neo4j":
            import subprocess
            cmd = [sys.executable, "-c", f"""
import sys
import os
sys.path.append('.')
os.environ['OUTPUT_ROOT'] = r'{os.getenv("OUTPUT_ROOT", "output")}'
from send_cypher import main
main()
"""]
            result = subprocess.run(
                cmd, 
                capture_output=True, 
                text=True, 
                encoding='utf-8',
                errors='replace',
                env=env
            )
            if result.returncode != 0:
                # Neo4j 실패는 경고로 처리 (선택적 기능)
                return False, f"Neo4j 연결 실패 (파일 기반 모드로 동작): {result.stderr[:100]}"
                
        else:
            raise ValueError(f"알 수 없는 모듈: {module_name}")
        
        duration = time.time() - start_time
        return True, f"{step_name} 완료 ({duration:.1f}초)"

    except Exception as e:
        duration = time.time() - start_time
        return False, f"{step_name} 실패 ({duration:.1f}초): {str(e)}"

def run_integrated_pipeline(purpose: str, output_root: str) -> bool:
    """통합 파이프라인 실행"""
    st.markdown("### 🔄 RAG 시스템 구축 진행 상황")
    st.info(f"📌 구축 목적: **{purpose}**에 최적화된 RAG 시스템을 구축합니다.")
    
    progress_bar = st.progress(0)
    status_placeholder = st.empty()
    
    pipeline_start = time.time()
    
    try:
        # 1. 환경 설정
        status_placeholder.info("🔄 환경 설정 중...")
        progress_bar.progress(0.1)
        setup_environment(output_root, purpose)
        st.success("✅ 환경 설정 완료")

        # 2. 문서 전처리
        status_placeholder.info("🔄 문서 전처리 중...")
        progress_bar.progress(0.15)
        chunk_count, file_count = preprocess_documents(output_root)
        if chunk_count == 0:
            raise Exception("처리할 문서가 없습니다.")
        st.success(f"문서 전처리 완료: {file_count}개 파일 → {chunk_count}개 청크")

        # 3. 스키마 추출
        status_placeholder.info("🔄 스키마 추출 중...")
        progress_bar.progress(0.25)
        success, message = run_step_safe("스키마 추출", "schema", purpose)
        if not success:
            st.error(f"❌ {message}")
            with st.expander("🔍 오류 상세 정보"):
                st.code(message)
            raise Exception("스키마 추출 실패")
        st.success(f"✅ {message}")

        # 4. 노드 추출
        status_placeholder.info("🔄 엔티티(노드) 추출 중...")
        progress_bar.progress(0.4)
        success, message = run_step_safe("노드 추출", "extract_node", purpose)
        if not success:
            st.error(f"❌ {message}")
            with st.expander("🔍 오류 상세 정보"):
                st.code(message)
            raise Exception("노드 추출 실패")
        st.success(f"✅ {message}")

        # 5. 관계 추출
        status_placeholder.info("🔄 관계 추출 중...")
        progress_bar.progress(0.55)
        success, message = run_step_safe("관계 추출", "extract_relation", purpose)
        if not success:
            st.error(f"❌ {message}")
            with st.expander("🔍 오류 상세 정보"):
                st.code(message)
            raise Exception("관계 추출 실패")
        st.success(f"✅ {message}")

        # 6. 중복 제거 및 정제
        status_placeholder.info("🔄 중복 제거 및 정제 중...")
        progress_bar.progress(0.7)
        success, message = run_step_safe("중복 제거", "deduplication")
        if success:
            st.success(f"✅ {message}")
        else:
            st.warning(f"⚠️ {message}")

        # 7. Cypher 스크립트 생성
        status_placeholder.info("🔄 Cypher 스크립트 생성 중...")
        progress_bar.progress(0.85)
        success, message = run_step_safe("Cypher 생성", "cypher")
        if not success:
            st.error(f"❌ {message}")
            with st.expander("🔍 오류 상세 정보"):
                st.code(message)
            raise Exception("Cypher 스크립트 생성 실패")
        st.success(f"✅ {message}")

        # 8. Neo4j 데이터베이스 적재
        status_placeholder.info("🔄 Neo4j 데이터베이스 적재 중...")
        progress_bar.progress(0.95)
        success, message = run_step_safe("Neo4j 적재", "neo4j")
        if success:
            st.success(f"✅ {message}")
        else:
            st.warning(f"⚠️ Neo4j 적재 실패: {message.split(':')[0]}")
            st.info("RAG 시스템은 파일 기반으로 동작합니다.")

        # 완료
        progress_bar.progress(1.0)
        status_placeholder.success("✅ RAG 시스템 구축 완료!")
        
        total_time = time.time() - pipeline_start
        st.success(f"🎉 '{purpose}' 목적의 RAG 시스템 구축 완료! (총 {total_time:.1f}초)")
        
        # 최종 결과 요약
        result_file = Path(output_root) / "result" / "result.json"
        if result_file.exists():
            try:
                import json
                with open(result_file, 'r', encoding='utf-8') as f:
                    data = json.load(f)
                st.info(f"📊 추출 결과: 엔티티 {len(data.get('nodes', []))}개, 관계 {len(data.get('relations', []))}개")
            except:
                pass
        
        return True
        
    except Exception as e:
        total_time = time.time() - pipeline_start
        st.error(f"❌ '{purpose}' RAG 시스템 구축 실패 ({total_time:.1f}초): {e}")
        return False

# ───────────────────────────────────────
# Streamlit 인터페이스 시작
# ───────────────────────────────────────

if "stage" not in st.session_state:
    st.session_state.stage = "config"

if st.session_state.stage == "config":
    st.title("📚 문서 기반 RAG 시스템 구축")
    
    st.markdown("""
    ### 📋 사용 안내
    1. **RAG 시스템 구축 목적**을 명확히 입력하세요
    2. **문서 폴더 경로**에 RAG 시스템에서 활용할 문서들이 있는지 확인하세요
    3. 지원 파일 형식: `.txt`, `.md`, `.doc`, `.docx`, `.pdf`
    """)

    with st.form("config_form"):
        purpose = st.text_input("📌 RAG 시스템 구축 목적:", value="기업 판매 지원")
        
        raw_path = st.text_input(
            "📁 문서 폴더 경로 (예: output/documents):",
            value="output/documents",
            help="분석할 문서들이 있는 폴더 경로"
        )

        # 경로 정규화
        import pathlib as pl
        p = pl.Path(raw_path)
        if p.name.lower() == "documents":
            p = p.parent
        output_root = p.as_posix()
        
        submitted = st.form_submit_button("🚀 RAG 시스템 구축 시작", use_container_width=True)

    # 폴더 검증
    if output_root:
        doc_path = Path(output_root) / "documents"  # documents 하위 폴더 확인
        if doc_path.exists():
            doc_files = []
            for ext in ['*.txt', '*.md', '*.doc', '*.docx', '*.pdf']:
                doc_files.extend(doc_path.glob(ext))
            if doc_files:
                st.success(f"✅ {len(doc_files)}개 문서 파일 발견")
            else:
                st.warning("⚠️ documents 폴더에 지원되는 문서 파일이 없습니다.")
        else:
            st.error("❌ documents 폴더가 존재하지 않습니다.")

    if submitted:
        if not purpose.strip():
            st.error("RAG 시스템 구축 목적을 입력해주세요.")
            st.stop()
        
        output_root_path = Path(output_root).expanduser().resolve()
        if not output_root_path.exists():
            st.error(f"지정된 경로가 존재하지 않습니다: {output_root_path}")
            st.stop()

        success = run_integrated_pipeline(purpose, str(output_root_path))
        if success:
            st.session_state.purpose = purpose
            st.session_state.output_root = str(output_root_path)
            st.session_state.stage = "rag"
            st.rerun()

elif st.session_state.stage == "rag":
    st.title("💬 RAG QA Interface")

    purpose = st.session_state.get("purpose", "문서 분석")
    output_root = st.session_state.get("output_root", "output")

    with st.sidebar:
        st.header("📊 시스템 정보")
        st.write(f"**구축 목적:** {purpose}")
        st.write(f"**작업 디렉토리:** {output_root}")
        if st.button("🔄 새로 구축", use_container_width=True):
            st.session_state.stage = "config"
            st.rerun()

    # 시스템 상태 확인
    result_file = Path(output_root) / "result" / "result.json"
    if result_file.exists():
        try:
            import json
            with open(result_file, 'r', encoding='utf-8') as f:
                data = json.load(f)
            st.success("✅ RAG 시스템 준비 완료")
            st.info(f"📊 엔티티: {len(data.get('nodes', []))}개 | 관계: {len(data.get('relations', []))}개")
        except Exception as e:
            st.error(f"결과 파일 읽기 오류: {e}")
    else:
        st.error("❌ RAG 시스템 구축이 완료되지 않았습니다.")
        st.stop()

    # 질문 입력 UI
    st.markdown("### 💬 질문하기")
    query = st.text_input("❓ 질문을 입력하세요:", placeholder=f"{purpose}와 관련된 질문을 입력하세요")
    
    col1, col2 = st.columns([4, 1])
    with col1:
        ask_button = st.button("🔍 답변 생성", use_container_width=True)
    with col2:
        clear_button = st.button("🗑️ 초기화", use_container_width=True)
    
    if clear_button:
        st.rerun()
    
    if ask_button and query.strip():
        with st.spinner("🤔 답변을 생성하고 있습니다..."):
            try:
                # RAG 모듈 동적 로드
                import importlib.util
                rag_path = Path(__file__).with_name("rag.py")
                
                if not rag_path.exists():
                    st.error("rag.py 파일을 찾을 수 없습니다.")
                    st.stop()
                
                spec = importlib.util.spec_from_file_location("rag", rag_path)
                rag = importlib.util.module_from_spec(spec)
                spec.loader.exec_module(rag)
                
                os.environ["OUTPUT_ROOT"] = output_root
                answer = rag.answer(query)
                
                if not answer or answer.strip() == "":
                    answer = f"""
                    죄송합니다. **{purpose}** 목적과 관련된 해당 질문에 대한 답변을 찾을 수 없습니다.
                    
                    다음과 같이 시도해보세요:
                    - 더 구체적인 질문으로 바꿔보세요
                    - 문서에 실제로 포함된 내용인지 확인해보세요
                    - 다른 키워드를 사용해보세요
                    """
                
                st.markdown("---")
                st.markdown("### 📝 답변")
                st.markdown(answer)
                
            except Exception as e:
                st.error(f"답변 생성 중 오류가 발생했습니다: {str(e)}")
                with st.expander("🔍 오류 상세 정보"):
                    import traceback
                    st.code(traceback.format_exc())

# 하단 정보
st.markdown("---")
st.markdown("""
<div style='text-align: center; color: #666; font-size: 12px;'>
🤖 통합 RAG System Builder | Built with Streamlit + Neo4j + OpenAI
</div>
""", unsafe_allow_html=True)