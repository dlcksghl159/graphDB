import os
import json
import glob
import textwrap
from dotenv import load_dotenv
from util import merge_json, parse_json
from deduplication import deduplicate
from transformers import AutoTokenizer, AutoModelForCausalLM
import torch
from transformers import BitsAndBytesConfig

# 시스템 메시지: 역할과 출력 형식을 정의합니다.
system_msg = (
    "당신은 RAG 시스템용 지식 그래프 스키마(엔티티/관계 타입)를 텍스트에서 추출합니다. "
    "반드시 올바른 JSON 형식으로만 응답하세요."
)


import torch
from typing import List, Dict
from transformers import PreTrainedTokenizer, PreTrainedModel

import torch
from typing import List, Dict
from transformers import PreTrainedTokenizer, PreTrainedModel
from torch.cuda.amp import autocast
# parse_json 함수는 이미 정의되어 있다고 가정합니다.

def extract_schema_batch(
    texts: List[str],
    batch_size: int,
    tokenizer: PreTrainedTokenizer,
    model: PreTrainedModel,
    purpose: str
) -> List[Dict]:
    """
    4-bit 양자화 + mixed-precision 생성으로 메모리 사용 최소화
    """
    results = []

    for i in range(0, len(texts), batch_size):
        batch = texts[i : i + batch_size]
        prompts = []
        for content in batch:
            prompts.append(f"""아래 텍스트를 읽고, '{purpose}' 목적의 RAG 시스템 구축을 위한 지식 그래프 스키마를 **오직 JSON 하나**로만 출력하세요.

출력 형식(정확히 이 구조만, 추가 텍스트 금지):
{{
  "nodes": [],
  "relations": []
}}

nodes 요소:
- label: 캐멀케이스 단어 (예: Company)
- name: 엔티티 이름 (string)
- properties: key–value, 값 타입은 "string", "int", "float"

relations 요소:
- start_node, end_node: 반드시 위 nodes.label 중 하나
- relationship: 대문자 스네이크케이스 (예: PRODUCES)
- properties: {{}} 또는 key–value, 값 타입은 "string", "int", "float"

제약:
- 오직 1개의 JSON만 출력
- 예시, 설명, 주석 절대 포함 금지

### 텍스트:
{content}
""")

        # 1) Tokenize & to device
        inputs = tokenizer(
            prompts,
            return_tensors="pt",
            padding=True,
            truncation=True,
            max_length=512
        )
        input_ids = inputs.input_ids.to(model.device)
        attention_mask = inputs.attention_mask.to(model.device)

        # 2) empty cache to reduce fragmentation
        torch.cuda.empty_cache()

        # 3) Compute remaining capacity
        max_ctx = model.config.max_position_embeddings
        prompt_lens = attention_mask.sum(dim=1)
        max_new = max(1, max_ctx - int(prompt_lens.max().item()))

        # 4) Generate under autocast (fp16) even for a 4-bit model
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

        # 5) Post-processing: remove prompt & extract JSON
        for idx, prompt_len in enumerate(prompt_lens):
            gen_ids = output_ids[idx, prompt_len:]
            raw = tokenizer.decode(gen_ids, skip_special_tokens=True)

            # 첫 '{'에서 매칭되는 '}'까지 자르기
            start = raw.find('{')
            if start != -1:
                depth = 0
                end = None
                for j, ch in enumerate(raw[start:], start):
                    if ch == '{': depth += 1
                    elif ch == '}':
                        depth -= 1
                        if depth == 0:
                            end = j
                            break
                json_str = raw[start:end+1] if end is not None else raw[start:]
            else:
                json_str = raw

            print('------------print_text---------------------------')
            print(json_str)
            print('------------print_text_end---------------------------')

            results.append(parse_json(json_str))

    return results

def main(
    purpose: str = "기업판매",
    batch_size: int = 4,
    #model_name: str = "meta-llama/Llama-3.1-8B-Instruct"
    model_name: str = "Qwen/Qwen3-8B",
):
    load_dotenv()
    hf_token = os.getenv("HF_TOKEN")

    OUTPUT_ROOT = os.getenv("OUTPUT_ROOT", "output")
    schema_dir = os.path.join(OUTPUT_ROOT, "schema")
    chunks_dir = os.path.join(OUTPUT_ROOT, "chunked_document")
    os.makedirs(schema_dir, exist_ok=True)

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
        trust_remote_code=True, # Allow the model to use custom code from the repository
        quantization_config=bnb, # Apply the 4-bit quantization configuration
        attn_implementation='sdpa', # Use scaled-dot product attention for better performance
        torch_dtype=torch.float16, # Set the data type for the model
        device_map='auto'
    )

    files = sorted(glob.glob(os.path.join(chunks_dir, "chunked_output_*.txt")))
    merged_path = os.path.join(schema_dir, "schema.json")

    for start in range(0, len(files), batch_size):
        batch_files = files[start: start + batch_size]
        texts, indices = [], []
        for idx, fp in enumerate(batch_files, start=start):
            with open(fp, "r", encoding="utf-8") as f:
                texts.append(f.read())
            indices.append(idx)

        schemas = extract_schema_batch(texts, batch_size, tokenizer, model, purpose)

        for idx, parsed_schema in zip(indices, schemas):
            # LLM 출력 인스턴스를 JSON Schema 문서로 래핑
            final_schema = parsed_schema

            individual_path = os.path.join(schema_dir, f"schema_{idx}.json")
            with open(individual_path, "w", encoding="utf-8") as f:
                json.dump(final_schema, f, ensure_ascii=False, indent=2)

            if os.path.exists(merged_path):
                with open(merged_path, "r", encoding="utf-8") as mf:
                    old = json.load(mf)
                merged = merge_json(old, final_schema, node_key=("label",))
            else:
                merged = final_schema

            with open(merged_path, "w", encoding="utf-8") as mf:
                json.dump(merged, mf, ensure_ascii=False, indent=2)

            deduplicate(merged_path)
            print(f"[{idx}] schema 추출 완료 (JSON Schema 문서)")

if __name__ == "__main__":
    main()