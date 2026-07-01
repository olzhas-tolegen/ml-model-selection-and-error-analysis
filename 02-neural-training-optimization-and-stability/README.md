# ML Model Evaluation and Optimization Portfolio

This repository is a structured machine-learning portfolio focused on **model benchmarking, error analysis, optimization behavior, and reproducible ML experimentation**.

The work is organized as a production-style ML project rather than a loose collection of notebooks. It demonstrates how to evaluate classical and neural learning algorithms under a controlled experimental protocol, preserve train/validation/test discipline, automate notebook execution, and communicate results in a form useful to technical reviewers, engineering managers, and AI/ML program stakeholders.

## Portfolio Overview

The emphasis is not only on training models, but on building an auditable evaluation workflow:

- Clear dataset split protocol
- Repeatable environment setup
- Scripted notebook execution
- Centralized project paths
- Metrics, runtime, and model-comparison outputs
- Error analysis through confusion matrices and class-level performance
- Clean GitHub hygiene with generated artifacts excluded from source control

## Repository Structure

```text
ml-model-evaluation-and-optimization/
├── README.md
├── portfolio-summary.md
├── data-policy.md
│
└── 01-model-benchmarking-and-error-analysis/
    ├── README.md
    ├── environment.yml
    ├── requirements.txt
    ├── reproducibility.md
    │
    ├── notebooks/
    │   ├── 01_eda_dataset_original.ipynb
    │   ├── 02_eda_dataset_sampled.ipynb
    │   ├── 03_decision_tree.ipynb
    │   ├── 04_knn_evaluation.ipynb
    │   ├── 05_svm_evaluation.ipynb
    │   ├── 06_sklearn_mlp_sgd.ipynb
    │   ├── 07_pytorch_mlp_sgd.ipynb
    │   └── 08_activation_functions_extra_credit.ipynb
    │
    ├── src/
    │   ├── data/
    │   ├── preprocessing/
    │   ├── models/
    │   ├── evaluation/
    │   └── plotting/
    │
    ├── results/
    │   ├── metrics/
    │   ├── runtime/
    │   ├── model-comparison/
    │   └── confusion-matrices/
    │
    ├── figures/
    │   ├── eda/
    │   ├── learning-curves/
    │   ├── model-complexity-curves/
    │   ├── confusion-matrices/
    │   └── runtime/
    │
    ├── reports/
    │   ├── summary.md
    │   └── repro-notes.md
    │
    └── scripts/
        ├── run_all.sh
        ├── run_eda.sh
        ├── run_models.sh
        └── clean_outputs.sh
```

## Project 01: Model Benchmarking and Error Analysis

The first project, `01-model-benchmarking-and-error-analysis`, is a portfolio-grade supervised learning benchmark for the UCI Forest Cover Type dataset.

It compares:

| Model | Purpose |
|---|---|
| Decision Tree | Interpretable nonlinear baseline and model-complexity analysis |
| k-Nearest Neighbors | Distance-based nonlinear learner and scaling/runtime comparison |
| Support Vector Machine | Linear vs. nonlinear kernel comparison with `C` and `gamma` tuning |
| scikit-learn MLP with SGD | Neural baseline using constrained optimizer setup |
| PyTorch MLP with SGD | Custom neural-network training loop and training diagnostics |
| Activation Function Study | Extra-credit comparison of ReLU, GELU, SiLU/Swish, and Tanh |

## Experimental Protocol

The project uses a strict split protocol:

```text
dataset_stratified.csv
├── 80% training
└── 20% validation

dataset_remainder.csv
└── untouched final test set
```

Model selection is performed only on the training and validation split of the stratified dataset. The remainder dataset is reserved for final test evaluation only.

This prevents accidental leakage from validation into final testing and makes the reported metrics more defensible.

## Execution Order

Run the notebooks in the following order:

1. `notebooks/01_eda_dataset_original.ipynb`  
   Loads `data/raw/covertype/covtype.data`, validates schema, performs EDA, and creates:
   - `data/processed/dataset_stratified.csv`
   - `data/processed/dataset_remainder.csv`

2. `notebooks/02_eda_dataset_sampled.ipynb`  
   Performs EDA on the 20,000-row stratified working sample.

3. `notebooks/03_decision_tree.ipynb`

4. `notebooks/04_knn_evaluation.ipynb`

5. `notebooks/05_svm_evaluation.ipynb`

6. `notebooks/06_sklearn_mlp_sgd.ipynb`

7. `notebooks/07_pytorch_mlp_sgd.ipynb`

8. `notebooks/08_activation_functions_extra_credit.ipynb`

## Directory Contract

The project writes generated artifacts into these directories:

```text
results/metrics/                  # final metrics, split summaries, classification reports
results/runtime/                  # runtime tables and hardware notes
results/model-comparison/         # hyperparameter sweeps, learning-curve tables, comparison tables
results/confusion-matrices/       # confusion matrix CSV files

figures/eda/                      # EDA plots
figures/learning-curves/          # learning curves and epoch curves
figures/model-complexity-curves/  # model-complexity and hyperparameter plots
figures/confusion-matrices/       # confusion matrix plots
figures/runtime/                  # runtime plots when generated
```

Generated outputs are intentionally excluded from Git by `.gitignore`. Directory structure is preserved with `.gitkeep`.

## Raw Data Placement

Place the raw Covertype file here before running notebook 01:

```text
01-model-benchmarking-and-error-analysis/
└── data/
    └── raw/
        └── covertype/
            └── covtype.data
```

Notebook 01 generates:

```text
01-model-benchmarking-and-error-analysis/
└── data/
    └── processed/
        ├── dataset_stratified.csv
        └── dataset_remainder.csv
```

## Reproducibility

Each module provides:

- `environment.yml` for Conda-based setup
- `requirements.txt` as a pip fallback
- `reproducibility.md` with execution instructions
- `scripts/run_all.sh` for batch execution
- `scripts/clean_outputs.sh` for GitHub cleanup

Recommended Conda setup:

```bash
cd 01-model-benchmarking-and-error-analysis
conda env create -f environment.yml
conda activate ml-model-evaluation
bash scripts/run_all.sh
```

Alternative `venv` setup:

```bash
cd 01-model-benchmarking-and-error-analysis
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
bash scripts/run_all.sh
```

## Run All Notebooks

From inside the module directory:

```bash
cd 01-model-benchmarking-and-error-analysis
bash scripts/run_all.sh
```

The cleanup script removes:

- generated data
- generated figures
- generated metrics
- notebook outputs
- cache files
- temporary files

It preserves the project folder structure through `.gitkeep`.

## Data Policy

Raw and generated datasets are intentionally excluded from Git.

Expected local data placement:

```text
01-model-benchmarking-and-error-analysis/
└── data/
    ├── raw/
    │   └── covertype/
    │       └── covtype.data
    └── processed/
        ├── dataset_stratified.csv
        └── dataset_remainder.csv
```

See [`data-policy.md`](./data-policy.md) for details.

## What This Repository Contains

- Dataset preparation and stratified sampling
- Train/validation/test discipline
- Baseline modeling and model-complexity analysis
- Hyperparameter tuning under compute constraints
- Runtime profiling for fit and prediction stages
- Error analysis using confusion matrices and class-level metrics
- Reproducible notebook execution
- Clean source-control practices for ML projects
- Communication of results for technical and non-technical stakeholders

## Project Use

1. Read this root `README.md`
2. Open `portfolio-summary.md`
3. Review `01-model-benchmarking-and-error-analysis/README.md`
4. Inspect the notebooks in numerical order
5. Review `reproducibility.md`
6. Run `scripts/run_all.sh` locally if data is available
