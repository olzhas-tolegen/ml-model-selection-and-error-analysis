# Reproducibility Notes

## Environment

Use either Conda or pip. Conda is recommended for a local AI/ML workstation because it handles binary dependencies consistently.

```bash
conda env create -f environment.yml
conda activate ml-model-benchmarking
```

or:

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

## Data

The raw dataset is expected at:

```text
data/raw/covertype/covtype.data
```

```01_eda_dataset_original``` creates the stratified 20,000-row development sample and the untouched remainder test file under `data/processed/`.

## Random seeds

The notebooks use fixed seeds (`42`) for NumPy, scikit-learn splitting, and PyTorch where applicable. Runtime numbers may still vary across CPU architecture, BLAS implementation, thread count, and available memory.

## Validation protocol

Model notebooks use:

- `dataset_stratified.csv` split into 80% training and 20% validation.
- `dataset_remainder.csv` as the final untouched test set.

The remainder file must not be used for hyperparameter selection.
