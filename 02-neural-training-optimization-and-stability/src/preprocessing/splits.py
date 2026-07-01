from __future__ import annotations

import pandas as pd
from sklearn.model_selection import train_test_split


def stratified_train_validation_split(
    df: pd.DataFrame,
    target_col: str = "Cover_Type",
    validation_size: float = 0.20,
    random_state: int = 42,
):
    X = df.drop(columns=[target_col])
    y = df[target_col]
    return train_test_split(
        X,
        y,
        test_size=validation_size,
        random_state=random_state,
        stratify=y,
    )
