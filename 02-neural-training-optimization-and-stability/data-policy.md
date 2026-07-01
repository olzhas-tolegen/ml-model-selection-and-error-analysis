# Data Policy

## Purpose

This document defines how data is handled in the `ml-model-evaluation-and-optimization` repository.

The goal is to keep the public repository clean, lightweight, reproducible, and compliant with responsible data-management practices.

## Summary

Raw datasets, processed datasets, generated metrics, model artifacts, and notebook outputs are intentionally excluded from Git.

The repository should track:

- Source notebooks
- Python source code
- Scripts
- Documentation
- Environment files
- Folder placeholders such as `.gitkeep`

The repository should not track:

- Raw datasets
- Processed datasets
- Generated CSV files
- Generated figures
- Model binaries
- Notebook execution outputs
- Cache files
- Temporary files

## Why Data Is Not Committed

Datasets and generated artifacts are excluded for several reasons:

1. **Repository size control**  
   ML datasets and generated outputs can quickly make a Git repository large and slow.

2. **Reproducibility discipline**  
   Processed files should be regenerated from documented scripts and notebooks.

3. **Licensing caution**  
   Public redistribution of third-party datasets may be restricted or ambiguous.

4. **Cleaner portfolio review**  
   Recruiters and engineering reviewers should see source code, documentation, and reproducibility instructions, not large generated artifacts.

5. **Better Git history**  
   Generated files create noisy diffs and make version history harder to review.

## Expected Local Data Layout



## Processed Data



## Results and Figures



These directories are preserved with `.gitkeep` files so the folder structure remains visible on GitHub.

## Model Artifacts

Serialized models should not be committed unless there is a specific reason to publish a small final artifact.

Ignored model formats include:

```text
*.pkl
*.pickle
*.joblib
*.pt
*.pth
*.onnx
*.h5
*.ckpt
```

For this portfolio repository, model binaries are not required. The preferred approach is to regenerate models from the notebooks and scripts.

## Notebook Outputs



## `.gitkeep` Policy

Git does not track empty directories. This repository uses `.gitkeep` files to preserve important folder structure.

Examples:

```text
data/raw/covertype/.gitkeep
data/processed/.gitkeep
results/metrics/.gitkeep
figures/eda/.gitkeep
```

These files are intentionally committed.

## `.gitignore` Policy

The repository `.gitignore` should exclude generated and local-only files while explicitly allowing important source files.

Allowed:

```text
README.md
portfolio-summary.md
data-policy.md
environment.yml
requirements.txt
reproducibility.md
notebooks/*.ipynb
src/**/*.py
scripts/*.sh
reports/*.md
.gitkeep
```

Ignored:

```text
data/raw/*
data/processed/*
results/*
figures/*
__pycache__/
.ipynb_checkpoints/
.venv/
*.csv
*.pkl
*.pt
```

## Reproducibility Expectation


## Public Repository Rule


## Recommended Pre-Push Checklist


## Final Policy

This repository is source-controlled as a reproducible ML project, not as a storage location for datasets or generated artifacts.

Data and outputs are regenerated locally. Source code, notebooks, scripts, and documentation are committed publicly.
