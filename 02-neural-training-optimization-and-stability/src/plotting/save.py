from __future__ import annotations

from pathlib import Path
import matplotlib.pyplot as plt


def save_current_figure(path: str | Path, dpi: int = 200) -> Path:
    path = Path(path)
    path.parent.mkdir(parents=True, exist_ok=True)
    plt.savefig(path, dpi=dpi, bbox_inches="tight")
    return path
