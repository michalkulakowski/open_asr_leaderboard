#!/bin/bash

TEMP=$(getopt -n "$0" -a -l "url:,model" -- -- "$@")

[ $? -eq 0 ] || exit

eval set --  "$TEMP"

while [ $# -gt 0 ]
do
            case "$1" in
                --url) URL="$2"; shift;;
                --model) MODEL_ID="$2"; shift;;
                --) shift;;
            esac
            shift;
done

export PYTHONPATH="..":$PYTHONPATH

MAX_WORKERS=10

python run_eval.py \
    --dataset_path="hf-audio/esb-datasets-test-only-sorted" \
    --dataset="ami" \
    --split="test" \
    --model_name ${MODEL_ID} \
    --url ${URL} \
    --max_workers ${MAX_WORKERS}

python run_eval.py \
    --dataset_path="hf-audio/esb-datasets-test-only-sorted" \
    --dataset="earnings22" \
    --split="test" \
    --model_name ${MODEL_ID} \
    --url ${URL} \
    --max_workers ${MAX_WORKERS}

python run_eval.py \
    --dataset_path="hf-audio/esb-datasets-test-only-sorted" \
    --dataset="gigaspeech" \
    --split="test" \
    --model_name ${MODEL_ID} \
    --url ${URL} \
    --max_workers ${MAX_WORKERS}

python run_eval.py \
    --dataset_path "hf-audio/esb-datasets-test-only-sorted" \
    --dataset "librispeech" \
    --split "test.clean" \
    --model_name ${MODEL_ID} \
    --url ${URL} \
    --max_workers ${MAX_WORKERS}

python run_eval.py \
    --dataset_path "hf-audio/esb-datasets-test-only-sorted" \
    --dataset "librispeech" \
    --split "test.other" \
    --model_name ${MODEL_ID} \
    --url ${URL} \
    --max_workers ${MAX_WORKERS}

python run_eval.py \
    --dataset_path="hf-audio/esb-datasets-test-only-sorted" \
    --dataset="spgispeech" \
    --split="test" \
    --model_name ${MODEL_ID} \
    --url ${URL} \
    --max_workers ${MAX_WORKERS}

python run_eval.py \
    --dataset_path="hf-audio/esb-datasets-test-only-sorted" \
    --dataset="tedlium" \
    --split="test" \
    --model_name ${MODEL_ID} \
    --url ${URL} \
    --max_workers ${MAX_WORKERS}

python run_eval.py \
    --dataset_path="hf-audio/esb-datasets-test-only-sorted" \
    --dataset="voxpopuli" \
    --split="test" \
    --model_name ${MODEL_ID} \
    --url ${URL} \
    --max_workers ${MAX_WORKERS}

# Evaluate results
RUNDIR=`pwd` && \
cd ../normalizer && \
python -c "import eval_utils; eval_utils.score_results('${RUNDIR}/results', '${MODEL_ID}')" && \
cd $RUNDIR
