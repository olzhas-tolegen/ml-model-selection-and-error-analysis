#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
export MODEL_BENCHMARK_ROOT="$PWD"
for nb in           notebooks/03_decision_tree.ipynb           notebooks/04_knn_evaluation.ipynb           notebooks/05_svm_evaluation.ipynb           notebooks/06_sklearn_mlp_sgd.ipynb           notebooks/07_pytorch_sgd.ipynb           notebooks/08_activation_functions_evaluation.ipynb
do
  jupyter nbconvert --to notebook --execute --inplace "$nb"
done
