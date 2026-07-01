#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."
export MODEL_BENCHMARK_ROOT="$PWD"

ENV_NAME="ml-model-evaluation"

# Load Conda into this non-interactive shell.
# This is required because `conda activate` does not work in scripts
# unless Conda's shell functions are loaded first.
if ! command -v conda >/dev/null 2>&1; then
    echo "ERROR: conda command not found."
    echo "Run: ~/miniconda3/bin/conda init bash && source ~/.bashrc"
    exit 1
fi

CONDA_BASE="$(conda info --base)"
source "$CONDA_BASE/etc/profile.d/conda.sh"

# Create the environment only if it does not already exist.
# If it exists, update it from environment.yml.
if conda env list | awk '{print $1}' | grep -qx "$ENV_NAME"; then
    echo "Conda environment '$ENV_NAME' already exists. Updating from environment.yml..."
    conda env update -n "$ENV_NAME" -f environment.yml --prune
else
    echo "Creating Conda environment '$ENV_NAME' from environment.yml..."
    conda env create -f environment.yml
fi

conda activate "$ENV_NAME"

# Verifying libraries and executables
echo "Using Python:"
which python
python --version

echo "Using Jupyter:"
which jupyter
jupyter --version
jupyter nbconvert --version

# Launching next step scripts
bash scripts/run_eda.sh
bash scripts/run_models.sh
