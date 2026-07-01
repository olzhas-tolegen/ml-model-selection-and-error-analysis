### Complete set of works for model evaluation, training, optimization and representation

The machine learning repository focused on model benchmarking, error analysis, neural-network optimization, training stability, representation learning, clustering, and reproducible experimentation.

This repository demonstrates a machine learning workflow on the multiclass classification dataset. The goal is not simply to maximize accuracy. The goal is to explain model behavior using evidence from metrics, learning curves, complexity curves, runtime profiling, class-level errors, optimization behavior, and representation quality. It covers three connected but independently reproducible subprojects:

Subproject	Purpose
01-model-benchmarking-and-error-analysis	Compare classical and neural supervised models using leakage-safe evaluation, runtime profiling, learning curves, and class-level error analysis
02-neural-training-optimization-and-stability	Study optimizer behavior, regularization, seed stability, compute budgets, and neural-network training dynamics
03-representation-learning-and-clustering	Analyze feature-space structure using clustering, PCA, ICA, randomized projections, and downstream neural-network evaluation

## Status

| Projects | Status |
|---|---|
| `01-model-benchmarking-and-error-analysis` | Active / Deployment-ready | Compare classical and neural supervised models using leakage-safe evaluation, runtime profiling, learning curves, and error analysis | Study optimizer behavior, regularization, seed stability, compute budgets, and training dynamics |
| `02-neural-training-optimization-and-stability` | In progress |
| `03-representation-learning-and-clustering` | Planned | Analyze feature-space structure using clustering, PCA, ICA, randomized projections, and downstream neural-network evaluation |

## Reproducibility

Each subproject records:

- random seeds,
- package versions,
- hardware notes,
- train/validation/test split logic,
- preprocessing rules,
- run commands,
- generated outputs,
- known reproducibility caveats.