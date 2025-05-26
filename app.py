import os
import subprocess
import sys
from pathlib import Path

import streamlit as st
#streamlit run app.py 로 실행
# ---------------------------------------------------------------
# Streamlit UI for Knowledge‑Graph → RAG pipeline
# ---------------------------------------------------------------
# • Page 1: Configure purpose / output dir → Run pipeline
# • Page 2: Ask RAG questions once pipeline is ready
# ---------------------------------------------------------------

def run_pipeline(purpose: str, output_root: str):
    """Run main.py synchronously in a subprocess."""
    cmd = [sys.executable, "main.py", "--purpose", purpose, "--output-root", output_root]
    process = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)

    log_placeholder = st.empty()
    for line in process.stdout:  # type: ignore[union-attr]
        log_placeholder.text(line.rstrip())
    process.wait()

    if process.returncode != 0:
        st.error(f"Pipeline failed with code {process.returncode}")
    else:
        st.success("Pipeline finished!")


# ────────────────────────────────────────────────────────────────
# Streamlit pages (simple manual switch via session_state)
# ────────────────────────────────────────────────────────────────
if "stage" not in st.session_state:
    st.session_state.stage = "config"  # config → rag

if st.session_state.stage == "config":
    st.title("📄 KG ➜ Neo4j ➜ RAG 파이프라인")

    with st.form("config_form"):
        purpose = st.text_input("📌 그래프 목적 (purpose)", "기업판매")
        output_root = st.text_input("📁 Output 디렉토리", "output")
        submitted = st.form_submit_button("🚀 파이프라인 실행")

    if submitted:
        output_root_path = Path(output_root).expanduser().resolve()
        output_root_path.mkdir(parents=True, exist_ok=True)

        with st.spinner("Running pipeline … (this may take a while)"):
            run_pipeline(purpose, str(output_root_path))

        st.session_state.purpose = purpose
        st.session_state.output_root = str(output_root_path)
        st.session_state.stage = "rag"
        st.experimental_rerun()

elif st.session_state.stage == "rag":
    st.title("💬 RAG QA Interface")

    purpose = st.session_state.get("purpose", "기업판매")
    output_root = st.session_state.get("output_root", "output")

    st.sidebar.write(f"**Purpose:** {purpose}")
    st.sidebar.write(f"**Output dir:** {output_root}")
    st.sidebar.button("🔄 새 파이프라인 실행", on_click=lambda: st.session_state.update(stage="config"))

    # Lazy‑import rag module once
    if "rag_module" not in st.session_state:
        import importlib.util
        rag_path = Path(__file__).with_name("rag.py")
        spec = importlib.util.spec_from_file_location("rag", rag_path)
        rag = importlib.util.module_from_spec(spec)  # type: ignore[arg-type]
        spec.loader.exec_module(rag)  # type: ignore[union-attr]
        st.session_state.rag_module = rag

    rag_mod = st.session_state.rag_module

    query = st.text_input("❓ 질문을 입력하세요")
    if st.button("Ask") and query.strip():
        with st.spinner("Generating answer …"):
            try:
                answer = rag_mod.answer(query, kg_dir=output_root)  # rag.py 에 'answer' 함수가 있다고 가정
            except AttributeError:
                answer = "rag.py 에 answer(question, kg_dir=…) 함수가 정의되어 있지 않습니다."
        st.markdown("---")
        st.markdown(f"**Q:** {query}")
        st.markdown(f"**A:** {answer}")
