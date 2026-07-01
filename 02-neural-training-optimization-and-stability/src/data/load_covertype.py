from __future__ import annotations

from pathlib import Path
import pandas as pd

COVERTYPE_COLUMNS = [
    "Elevation", "Aspect", "Slope",
    "Horizontal_Distance_To_Hydrology", "Vertical_Distance_To_Hydrology",
    "Horizontal_Distance_To_Roadways", "Hillshade_9am", "Hillshade_Noon",
    "Hillshade_3pm", "Horizontal_Distance_To_Fire_Points",
    *[f"Wilderness_Area_{i}" for i in range(1, 5)],
    *[f"Soil_Type_{i}" for i in range(1, 41)],
    "Cover_Type",
]


def load_raw_covertype(path: str | Path) -> pd.DataFrame:
    path = Path(path)
    if not path.exists():
        raise FileNotFoundError(f"Raw Covertype file not found: {path}")
    return pd.read_csv(path, header=None, names=COVERTYPE_COLUMNS)


def load_csv(path: str | Path) -> pd.DataFrame:
    path = Path(path)
    if not path.exists():
        raise FileNotFoundError(f"CSV not found: {path}")
    return pd.read_csv(path)
