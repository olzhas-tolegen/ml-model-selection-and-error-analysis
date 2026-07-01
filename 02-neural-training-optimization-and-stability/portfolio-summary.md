# Portfolio Summary: ML Model Evaluation and Optimization

## Executive Summary

This repository demonstrates a disciplined approach to machine-learning experimentation: benchmarking multiple learning algorithms, enforcing clean train/validation/test separation, measuring runtime behavior, analyzing model errors, and packaging the work as a reproducible software project.

The project is intentionally structured to show more than notebook execution. It shows the workflow expected in real ML environments:

- Controlled experiment design
- Repeatable environment setup
- Consistent data paths
- Scripted execution
- Metrics and runtime tracking
- Error analysis
- GitHub-ready source control hygiene

This makes the repository useful as a portfolio signal for AI/ML engineering, applied ML, ML systems, and AI/ML Technical Program Manager roles.

## Why This Project Matters

Many academic ML projects stop at model training. This portfolio pushes further by showing the operational discipline behind credible model evaluation.

The central question is not simply:

> Which model has the highest score?

The stronger question is:

> Which model performs best under a controlled evaluation protocol, how stable is its behavior, what does it cost at runtime, and where does it fail?

That framing is directly relevant to production ML and AI infrastructure work.

## Core Portfolio Signal

This repository signals the ability to:

1. Convert academic ML assignments into professional-grade engineering artifacts.
2. Build reproducible ML workflows instead of isolated notebooks.
3. Separate model selection from final testing.
4. Compare model families across accuracy, macro-F1, balanced accuracy, and runtime.
5. Explain tradeoffs between interpretability, nonlinearity, compute cost, and generalization.
6. Maintain a clean public GitHub repository suitable for recruiter and engineering-manager review.

## Project 01: Model Benchmarking and Error Analysis

The first module focuses on supervised learning using the Forest Cover Type classification problem.

### Models Included

- Decision Tree
- k-Nearest Neighbors
- Support Vector Machine with linear and RBF kernels
- scikit-learn MLP trained with SGD
- PyTorch MLP trained with SGD
- Extra-credit activation function comparison

### Evaluation Dimensions

| Dimension | Why It Matters |
|---|---|
| Accuracy | Measures overall correctness |
| Macro-F1 | Exposes minority-class performance |
| Balanced accuracy | Controls for class imbalance |
| Runtime | Shows computational feasibility |
| Confusion matrices | Reveals systematic class-level errors |
| Learning curves | Shows underfitting/overfitting behavior |
| Model-complexity curves | Shows sensitivity to hyperparameters |

## Experimental Protocol

The benchmark uses a deliberate split design:

```text
dataset_stratified.csv
├── 80% training
└── 20% validation

dataset_remainder.csv
└── untouched final test set
```

This is a strong portfolio choice because it avoids the common mistake of repeatedly testing on the same holdout set during model selection.

The final test set is used once after model selection, which makes the final metrics more credible.

## Technical Capabilities Demonstrated

### 1. Reproducible ML Experimentation

The project includes environment files, scripts, and documentation so that a reviewer can reproduce the workflow locally.

Artifacts:

- `environment.yml`
- `requirements.txt`
- `reproducibility.md`
- `scripts/run_all.sh`
- `scripts/run_eda.sh`
- `scripts/run_models.sh`
- `scripts/clean_outputs.sh`

### 2. Notebook-to-Project Engineering

The notebooks are placed inside a structured project layout with reusable source modules:

```text
src/
├── data/
├── preprocessing/
├── models/
├── evaluation/
└── plotting/
```

This prevents the repository from looking like a one-off notebook dump.

### 3. Model Selection Discipline

The benchmark separates:

- training data
- validation data
- final test data

This is one of the most important signals for real ML work because it shows understanding of leakage, overfitting to validation, and fair final evaluation.

### 4. Runtime Awareness

The repository measures runtime behavior, which matters for ML systems and AI infrastructure roles.

Examples:

- kNN has cheap fitting but expensive prediction.
- SVM performance depends heavily on kernel choice and tuning search size.
- Neural networks require careful comparison across convergence behavior, architecture, and optimizer settings.

### 5. Error Analysis

The project includes confusion-matrix and class-level analysis to identify where models fail.

This matters because production ML work is rarely about a single aggregate score. It is about understanding error modes, failure concentration, and model behavior across classes.

## Relevance to AI/ML TPM and ML Systems Roles

For AI/ML Technical Program Manager roles, this repository is useful because it shows the ability to communicate across engineering, data science, and execution layers.

Relevant signals:

- Ability to define a clean evaluation protocol
- Ability to identify model tradeoffs
- Ability to track runtime and operational constraints
- Ability to structure reproducible workflows
- Ability to turn ambiguous experimentation into organized deliverables
- Ability to communicate technical findings in portfolio-ready documentation

For ML systems or applied ML roles, the repository signals:

- Practical model evaluation skill
- Understanding of compute/performance tradeoffs
- Experience with scikit-learn and PyTorch
- Ability to write reusable Python project utilities
- Ability to maintain clean experiment artifacts

## Reviewer Guide

A reviewer should inspect the repository in this order:

1. Root `README.md`
2. `portfolio-summary.md`
3. `data-policy.md`
4. `01-model-benchmarking-and-error-analysis/README.md`
5. `01-model-benchmarking-and-error-analysis/reproducibility.md`
6. Notebooks in numerical order
7. `src/` modules
8. `scripts/` automation files

The notebooks are numbered intentionally to reflect the experiment workflow.

## Suggested Interview Talking Points

### Model Benchmarking

> I evaluated multiple supervised learning algorithms under a fixed split protocol, using the stratified dataset for model development and a separate remainder dataset for final testing. This helped prevent leakage and made model comparison more defensible.

### Runtime Tradeoffs

> I did not only compare predictive performance. I also measured fit and prediction runtime because model feasibility depends on operational cost, not just accuracy.

### kNN Tradeoff

> kNN is useful as a nonlinear local baseline, but it shifts cost from training to inference. That is important when discussing scalability.

### SVM Tradeoff

> Linear SVM provides a scalable baseline, while RBF SVM can capture nonlinear structure but requires careful tuning of `C` and `gamma` and can be expensive.

### Neural Network Tradeoff

> The neural-network notebooks compare scikit-learn and PyTorch implementations under SGD constraints, which makes optimization behavior visible rather than hiding it behind adaptive optimizers.

### Error Analysis

> I used confusion matrices and class-level metrics because aggregate accuracy alone can hide poor minority-class performance.

## Portfolio Gaps and Next Improvements

The current repository is strong for supervised model evaluation. To make it stronger for ML systems and AI infrastructure positioning, the next upgrades should be:

1. Add experiment tracking with MLflow or a lightweight local alternative.
2. Add a final consolidated model-comparison dashboard.
3. Add CI validation that checks notebook syntax and script execution.
4. Add memory/runtime profiling beyond wall-clock time.
5. Add a Dockerfile for environment-level reproducibility.
6. Add larger-scale training experiments in a separate HPC/ML systems repository.
7. Add model-card style summaries for final selected models.

## Recommended Public GitHub Positioning

The repository should be described as:

> A reproducible ML benchmarking and error-analysis portfolio that compares classical and neural models under a controlled train/validation/final-test protocol, with runtime profiling, model-complexity analysis, and clean experiment packaging.

This positioning is stronger than calling it a class assignment.

## Final Assessment

This repository is a credible foundation for an AI/ML portfolio because it demonstrates applied ML judgment, reproducibility, and engineering organization.

Its strongest value is not the specific dataset or model scores. Its strongest value is the disciplined workflow:

```text
structured data split
→ controlled model selection
→ final holdout testing
→ runtime analysis
→ error analysis
→ reproducible execution
→ clean public repository
```

That is the correct signal for serious AI/ML career positioning.
