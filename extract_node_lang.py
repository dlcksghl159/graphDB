import os
import json
import glob
from typing import List, Dict

import torch
from torch.cuda.amp import autocast
from dotenv import load_dotenv
from transformers import AutoTokenizer, AutoModelForCausalLM

from util import merge_json, parse_json
from deduplication import deduplicate
from transformers import BitsAndBytesConfig

# 시스템 메시지: 역할과 출력 형식을 정의합니다.
system_msg = (
    "당신은 주어진 스키마에 따라 텍스트에서 엔티티와 관계 인스턴스를 추출하여 "
    "RAG 시스템용 지식 그래프를 구축합니다. 반드시 하나의 JSON만 출력하세요."
)


def extract_node_batch(
    texts: List[str],
    schema_json: Dict,
    purpose: str,
    batch_size: int,
    tokenizer: AutoTokenizer,
    model: AutoModelForCausalLM,
) -> List[Dict]:
    """텍스트 배치를 받아 노드/관계 인스턴스를 추출한다."""

    results: List[Dict] = []

    for i in range(0, len(texts), batch_size):
        batch = texts[i : i + batch_size]
        prompts: List[str] = []

        for content in batch:
            prompts.append(
                f"""{system_msg}

### 목적
'{purpose}' RAG 시스템을 위한 엔티티/관계 인스턴스를 추출하세요.

### 출력 형식 (추가 텍스트 금지)
{{
  \"nodes\": [],
  \"relations\": []
}}

제약:
- 스키마에 명시된 label 및 property 타입만 사용
- 불필요한 일반 개념 노드 생성 금지
- 관계의 start_node, end_node에는 반드시 노드 label 사용
- node.name은 명확한 명사/명사구
- 오직 1개의 JSON만 출력

### 스키마
{json.dumps(schema_json, ensure_ascii=False)}

### 텍스트
{content}
"""
            )

        # 1) Tokenize & to device
        inputs = tokenizer(
            prompts, return_tensors="pt", padding=True, truncation=True, max_length=512
        )
        input_ids = inputs.input_ids.to(model.device)
        attention_mask = inputs.attention_mask.to(model.device)

        # 2) Empty CUDA cache to reduce fragmentation
        torch.cuda.empty_cache()

        # 3) Compute remaining capacity
        max_ctx = model.config.max_position_embeddings
        prompt_lens = attention_mask.sum(dim=1)
        max_new = max(1, max_ctx - int(prompt_lens.max().item()))

        # 4) Generate under autocast (fp16) even for a 4‑bit model
        with autocast():
            output_ids = model.generate(
                input_ids=input_ids,
                attention_mask=attention_mask,
                max_new_tokens=max_new,
                do_sample=False,
                early_stopping=True,
                eos_token_id=tokenizer.eos_token_id,
                pad_token_id=tokenizer.eos_token_id,
            )

        # 5) Post‑processing: remove prompt & extract JSON
        for idx, prompt_len in enumerate(prompt_lens):
            gen_ids = output_ids[idx, prompt_len:]
            raw = tokenizer.decode(gen_ids, skip_special_tokens=True)

            # 첫 '{'와 매칭되는 '}' 사이를 잘라 JSON 문자열 확보
            start = raw.find("{")
            if start != -1:
                depth = 0
                end = None
                for j, ch in enumerate(raw[start:], start):
                    if ch == "{":
                        depth += 1
                    elif ch == "}":
                        depth -= 1
                        if depth == 0:
                            end = j
                            break
                json_str = raw[start : end + 1] if end is not None else raw[start:]
            else:
                json_str = raw

            print("------ generated ------")
            print(json_str)
            print("-----------------------")

            results.append(parse_json(json_str))

    return results


def main(
    purpose: str = "기업판매", batch_size: int = 4, model_name: str = "Qwen/Qwen3-8B"
):
    """extract_node_lang.py 메인 진입점."""

    # 0) 환경 변수 및 경로 준비
    load_dotenv()
    hf_token = os.getenv("HF_TOKEN")

    OUTPUT_ROOT = os.getenv("OUTPUT_ROOT", "output")
    chunks_dir = os.path.join(OUTPUT_ROOT, "chunked_document")
    schema_dir = os.path.join(OUTPUT_ROOT, "schema")
    result_dir = os.path.join(OUTPUT_ROOT, "result")
    os.makedirs(result_dir, exist_ok=True)

    # 1) 스키마 로드
    schema_path = os.path.join(schema_dir, "schema.json")
    if not os.path.exists(schema_path):
        raise FileNotFoundError("schema.json not found — 먼저 스키마를 추출하세요.")
    with open(schema_path, "r", encoding="utf-8") as sf:
        schema_json = json.load(sf)

    # 2) 모델/토크나이저 로드
    tokenizer = AutoTokenizer.from_pretrained(model_name, token=hf_token)
    if tokenizer.pad_token_id is None:
        tokenizer.pad_token_id = tokenizer.eos_token_id

    bnb = BitsAndBytesConfig(
        load_in_4bit=True,
        bnb_4bit_use_double_quant=True,
        bnb_4bit_quant_type="nf4",       # or "fp4"
        bnb_4bit_compute_dtype=torch.float16,
    )

    model = AutoModelForCausalLM.from_pretrained(
        model_name,
        token=hf_token,
        quantization_config=bnb,     # <─ 4-bit
        device_map="auto",           # <─ 자동 할당, to("cuda") 제거
    )

    # 3) 입력 파일 수집
    files = sorted(glob.glob(os.path.join(chunks_dir, "chunked_output_*.txt")))
    merged_path = os.path.join(result_dir, "result.json")

    # 4) 배치 단위 처리
    for start in range(0, len(files), batch_size):
        batch_files = files[start : start + batch_size]
        texts: List[str] = []
        indices: List[int] = []
        for idx, fp in enumerate(batch_files, start=start):
            with open(fp, "r", encoding="utf-8") as f:
                texts.append(f.read())
            indices.append(idx)

        # 4‑1) 노드/관계 추출
        batch_results = extract_node_batch(
            texts, schema_json, purpose, batch_size, tokenizer, model
        )

        # 4‑2) 저장 및 병합
        for idx, parsed in zip(indices, batch_results):
            indiv_path = os.path.join(result_dir, f"result_{idx}.json")
            with open(indiv_path, "w", encoding="utf-8") as f:
                json.dump(parsed, f, ensure_ascii=False, indent=2)

            if os.path.exists(merged_path):
                with open(merged_path, "r", encoding="utf-8") as mf:
                    old = json.load(mf)
                merged = merge_json(old, parsed, node_key=("label", "name"))
            else:
                merged = parsed

            with open(merged_path, "w", encoding="utf-8") as mf:
                json.dump(merged, mf, ensure_ascii=False, indent=2)

            # 4‑3) 중복 제거 및 진행 상황 출력
            deduplicate(merged_path)
            print(f"[{idx}] node 추출 완료 (총 {len(batch_results)}개)")


if __name__ == "__main__":
    main()
