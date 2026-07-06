# Applied ML Model Selection & Error Analysis

<p align="center">
  <strong>Production-oriented evaluation of five supervised learning families for imbalanced multiclass classification.</strong>
</p>

<p align="center">
  <img src="assets/project-overview.png" alt="Applied ML model selection project overview" width="100%">
</p>

<p align="center">
  <img alt="Python" src="https://img.shields.io/badge/Python-3.10%2B-blue">
  <img alt="scikit-learn" src="https://img.shields.io/badge/scikit--learn-Model%20Evaluation-orange">
  <img alt="PyTorch" src="https://img.shields.io/badge/PyTorch-Neural%20Networks-red">
  <img alt="Task" src="https://img.shields.io/badge/Task-Multiclass%20Classification-green">
  <img alt="Focus" src="https://img.shields.io/badge/Focus-Model%20Selection%20%7C%20Error%20Analysis-lightgrey">
</p>

## Executive summary

This project evaluates **Decision Tree, k-Nearest Neighbors, RBF Support Vector Machine, scikit-learn MLP, and a compact PyTorch MLP** on the Forest Covertype classification problem.

The goal was not to produce a single leaderboard winner. The goal was to determine which model is most defensible under competing requirements:

- predictive quality;
- minority-class recognition;
- training and inference cost;
- interpretability;
- sensitivity to class imbalance;
- generalization to a large, locked external test set.

The study used a **20,000-row stratified development sample** for training and validation, followed by final evaluation on **561,012 previously unseen records**. The central result is that model choice changes with the operational objective:

- **kNN** achieved the best external accuracy and Macro-F1;
- **RBF SVM** achieved the best balanced accuracy and strongest average class recall;
- **Decision Tree** delivered the strongest interpretability-runtime compromise;
- the neural networks were sensitive to optimization and class weighting and did not outperform the simpler nonlinear baselines.

## Key results

| Model | Selected configuration | Accuracy | Macro-F1 | Balanced accuracy | Fit time | Prediction time | Best use case |
|---|---|---:|---:|---:|---:|---:|---|
| Decision Tree | `max_depth=22`, `min_samples_leaf=5` | 0.767 | 0.659 | 0.639 | 0.198 s | 0.457 s | Interpretable, low-cost baseline |
| **kNN** | `k=1`, distance weighting, scaled numeric features | **0.808** | **0.699** | 0.695 | **0.035 s** | 22.811 s | Best overall accuracy and Macro-F1 |
| **RBF SVM** | `C=10`, `gamma=0.1` | 0.762 | 0.676 | **0.762** | 17.089 s | 754.200 s | Best balanced class recognition |
| scikit-learn MLP | width `128`, `alpha=1e-5`, SGD | 0.738 | 0.494 | 0.474 | 36.803 s | 2.437 s | Neural baseline under plain-SGD constraints |
| PyTorch MLP | `[64,64]`, class-weighted CE, SGD | 0.640 | 0.553 | 0.702 | 2.971 s | **0.333 s** | Fast inference with improved minority recall |

<p align="center">
  <img src="assets/model-metrics-comparison.png" alt="External test performance across five models" width="92%">
</p>

## Why this project matters

A high overall accuracy score can conceal severe failures on rare classes. The dataset is strongly imbalanced: classes 1 and 2 dominate the observations, while class 4 represents less than 1% of the data. For that reason, the evaluation prioritizes **Macro-F1, balanced accuracy, per-class F1, confusion matrices, learning curves, and runtime**, rather than accuracy alone.

The project demonstrates that selecting a model requires a **decision framework**, not a single metric:

| Deployment priority | Recommended model | Rationale |
|---|---|---|
| Highest accuracy and Macro-F1 | kNN | Strongest external predictive scores |
| Minority-class recall | RBF SVM | Highest balanced accuracy |
| Interpretability and low latency | Decision Tree | Competitive quality with sub-second inference |
| Fast neural inference | PyTorch MLP | Lowest prediction time, stronger minority recall than the sklearn MLP |
| Lowest operational complexity | Decision Tree | No feature scaling or instance-store dependency at inference |

## Experimental design

<p align="center">
  <img src="assets/evaluation-protocol.png" alt="Leakage-aware train validation and external test protocol" width="94%">
</p>

The evaluation protocol was designed to minimize leakage:

1. Start with 581,012 rows and 54 predictors across seven target classes.
2. Create a 20,000-row stratified development sample.
3. Split development data into 16,000 training rows and 4,000 validation rows.
4. Perform model selection and hyperparameter tuning using the development split only.
5. Evaluate each selected model once on the locked 561,012-row external test set.

### Model search space

| Model family | Main variables explored |
|---|---|
| Decision Tree | maximum depth, minimum leaf size |
| kNN | neighbor count, uniform vs. distance weighting, feature scaling |
| SVM | linear vs. RBF kernel, `C`, `gamma` |
| scikit-learn MLP | hidden width, L2 regularization, epoch behavior |
| PyTorch MLP | learning rate, architecture, width, class weighting, early stopping |
| Activation study | ReLU, GELU, SiLU/Swish, Tanh |

## Error analysis

The aggregate leaderboard hides materially different class-level behavior.

<p align="center">
  <img src="assets/per-class-f1-heatmap.png" alt="Per-class F1 heatmap across models" width="82%">
</p>

The most important findings were:

- Classes 1 and 2 were easiest because they dominate the training distribution.
- Classes 4, 5, and 6 were the hardest due to rarity and overlapping feature patterns.
- The dominant majority-class error was confusion between classes 1 and 2.
- Classes 3 and 6 also showed a recurring two-way confusion pattern.
- Class weighting improved minority recall in the PyTorch model, but created many false positives.
- The scikit-learn MLP achieved acceptable accuracy while performing poorly on minority classes, demonstrating why accuracy alone is insufficient.

## Performance-cost trade-off

<p align="center">
  <img src="assets/performance-cost-tradeoff.png" alt="Macro-F1 versus external prediction time" width="80%">
</p>

The models form a clear quality-cost frontier:

- **kNN** has negligible fitting cost but must compare new observations against stored training instances.
- **RBF SVM** provides the best class-balanced performance but is the least scalable inference option in this experiment.
- **Decision Tree** provides strong practical value because it combines competitive predictive quality with fast inference and transparent decision logic.
- **PyTorch MLP** predicts quickly but did not achieve sufficient Macro-F1 to justify replacing the stronger classical baselines.

## Technical capabilities demonstrated

- Leakage-aware train, validation, and external-test design
- Imbalanced multiclass evaluation
- Hyperparameter and model-complexity analysis
- Learning-curve interpretation and bias-variance diagnosis
- Per-class precision, recall, F1, and confusion-matrix analysis
- Feature scaling for distance- and margin-based models
- Classical ML and PyTorch model implementation
- Runtime profiling and deployment-oriented trade-off analysis
- Evidence-based model selection rather than metric-only ranking

## Repository structure

```text
ml-model-selection-and-error-analysis/
├── README.md
├── assets/
│   ├── project-overview.png
│   ├── evaluation-protocol.png
│   ├── model-metrics-comparison.png
│   ├── performance-cost-tradeoff.png
│   └── per-class-f1-heatmap.png
├── notebooks/
│   ├── 01_data_audit_and_split_validation.ipynb
│   ├── 02_decision_tree_analysis.ipynb
│   ├── 03_knn_analysis.ipynb
│   ├── 04_svm_analysis.ipynb
│   ├── 05_sklearn_mlp_analysis.ipynb
│   ├── 06_pytorch_mlp_analysis.ipynb
│   └── 07_activation_function_study.ipynb
├── src/
│   ├── data.py
│   ├── evaluation.py
│   └── visualization.py
├── results/
├── reports/
│   └── model-selection-technical-report.pdf
├── environment.yml
├── requirements.txt
└── run_all.sh
```

## Reproduction

### Conda

```bash
conda env create -f environment.yml
conda run -n ml-model-selection jupyter lab
```

### pip fallback

```bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
jupyter lab
```

The raw dataset should remain outside version control. Generated results and figures should be reproducible from the documented data-preparation and notebook execution pipeline.

## Limitations and next experiments

- The 20,000-row development sample is restrictive; several learning curves were still improving.
- Minority-class estimates have higher variance because classes 4 and 5 contain few development examples.
- The SVM search space was constrained by runtime.
- The selected `k=1` kNN model may be sensitive to noise and high-dimensional distance effects.
- The neural baselines require broader optimization studies, including learning-rate schedules, longer training, and more systematic cost-sensitive learning.
- A shared automated split validator should verify row counts and prevent accidental use of inconsistent holdout sets.

The most valuable follow-up would compare class weighting, stratified oversampling, cost-sensitive loss, feature selection, and approximate nearest-neighbor or kernel methods under a larger development budget.
