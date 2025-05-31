# main.py – End-to-end pipeline orchestrator
# -----------------------------------------
# 1) schema_lang.py  → JSON schema 추출
# 2) extract_node_lang.py      → 노드 인스턴스 추출
# 3) extract_relation_lang.py  → 관계 인스턴스 추출
# 4) cypher.py                 → Cypher 스크립트 생성
# 5) send_cypher.py            → Neo4j 업로드 + 벡터 임베딩
# 6) rag.py                    → RAG 시스템 데모 실행
# -----------------------------------------------------------
# 모든 단계에서 환경변수 OUTPUT_ROOT 로 출력 경로를 공유합니다.
# 필요 시 --skip-* 옵션으로 일부 스텝을 건너뛸 수 있습니다.

import argparse
import importlib
import os
import subprocess
import sys
from pathlib import Path
from types import ModuleType

# ── 유틸: 안전하게 모듈.main(...) 호출 ─────────────────────────────

def run_main(module: ModuleType, **kwargs):
    """Call module.main(**kwargs) if present, else run as subprocess."""
    if hasattr(module, "main") and callable(module.main):  # type: ignore
        module.main(**kwargs)
    else:
        # 폴더 내 Python 파일 경로 추정
        mod_path = Path(module.__file__).resolve()
        subprocess.run([sys.executable, str(mod_path)], check=True)


# ── 파이프라인 ────────────────────────────────────────────────────

def pipeline(purpose: str, output_root: str, skip_steps: set[str]):
    # 0) 공통 출력 디렉토리 환경변수 설정
    output_root = Path(output_root).expanduser().resolve()
    os.environ["OUTPUT_ROOT"] = str(output_root)
    output_root.mkdir(parents=True, exist_ok=True)
    print(f"[INFO] OUTPUT_ROOT = {output_root}")

    # 단계 정의 (이름, 모듈 import 명)
    steps: list[tuple[str, str, dict]] = [
        ("schema", "schema_multi", {"purpose": purpose}),
        ("nodes", "extract_node_kr", {"purpose": purpose}),
        ("relations", "extract_relation_kr", {"purpose": purpose}),
        ("cypher", "cypher", {}),  # 경로는 OUTPUT_ROOT 하드코딩 내부 모듈 사용
    ]

    # 실행 (Python module)
    for tag, mod_name, kwargs in steps:
        if tag in skip_steps:
            print(f"⏩  Skipping step: {tag}")
            continue
        print(f"\n🚀  [{tag}] running {mod_name}.main() …")
        mod = importlib.import_module(mod_name)
        run_main(mod, **kwargs)  # type: ignore[arg-type]

    # ── 외부 스크립트 (send_cypher.py, rag.py) ──────────────────
    scripts: list[tuple[str, Path]] = [
        ("send_cypher", Path(__file__).with_name("send_cypher.py")),
        ("rag",         Path(__file__).with_name("rag.py")),
    ]

    for tag, path in scripts:
        if tag in skip_steps:
            print(f"⏩  Skipping step: {tag}")
            continue
        print(f"\n🚀  [{tag}] running {path.name} …")
        subprocess.run([sys.executable, str(path)], check=True)

    print("\n🎉  Pipeline finished successfully!")


# ── CLI ───────────────────────────────────────────────────────────

def main():
    parser = argparse.ArgumentParser(
        description="End-to-end KG → Neo4j → RAG 파이프라인 실행기",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )
    parser.add_argument("--purpose", default="기업판매", help="지식 그래프 구축 목적")
    parser.add_argument("--output-root", default="output", help="출력 디렉토리")
    parser.add_argument(
        "--skip",
        nargs="*",
        default=[],
        help="건너뛸 스텝 태그(schema, nodes, relations, cypher, send_cypher, rag)",
    )

    args = parser.parse_args()
    skip_steps = set(args.skip)

    pipeline(args.purpose, args.output_root, skip_steps)


if __name__ == "__main__":
    main()
