from __future__ import annotations

import pandas as pd
from sklearn.metrics import accuracy_score, balanced_accuracy_score, f1_score


def multiclass_summary(y_true, y_pred, model_name: str) -> pd.DataFrame:
    return pd.DataFrame([
        {
            "model": model_name,
            "accuracy": accuracy_score(y_true, y_pred),
            "balanced_accuracy": balanced_accuracy_score(y_true, y_pred),
            "macro_f1": f1_score(y_true, y_pred, average="macro"),
            "weighted_f1": f1_score(y_true, y_pred, average="weighted"),
        }
    ])
