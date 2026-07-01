from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path


@dataclass(frozen=True)
class ProjectPaths:
    project_root: Path
    raw_data_dir: Path
    processed_data_dir: Path
    dataset_stratified_path: Path
    dataset_remainder_path: Path
    results_metrics_dir: Path
    results_runtime_dir: Path
    results_model_comparison_dir: Path
    results_confusion_matrices_dir: Path
    figures_eda_dir: Path
    figures_learning_curves_dir: Path
    figures_model_complexity_dir: Path
    figures_confusion_matrices_dir: Path
    figures_runtime_dir: Path
    reports_dir: Path

    def ensure(self) -> "ProjectPaths":
        for path in [
            self.raw_data_dir,
            self.processed_data_dir,
            self.results_metrics_dir,
            self.results_runtime_dir,
            self.results_model_comparison_dir,
            self.results_confusion_matrices_dir,
            self.figures_eda_dir,
            self.figures_learning_curves_dir,
            self.figures_model_complexity_dir,
            self.figures_confusion_matrices_dir,
            self.figures_runtime_dir,
            self.reports_dir,
        ]:
            path.mkdir(parents=True, exist_ok=True)
        return self


def get_paths(project_root: str | Path) -> ProjectPaths:
    root = Path(project_root).resolve()
    paths = ProjectPaths(
        project_root=root,
        raw_data_dir=root / "data" / "raw" / "covertype",
        processed_data_dir=root / "data" / "processed",
        dataset_stratified_path=root / "data" / "processed" / "dataset_stratified.csv",
        dataset_remainder_path=root / "data" / "processed" / "dataset_remainder.csv",
        results_metrics_dir=root / "results" / "metrics",
        results_runtime_dir=root / "results" / "runtime",
        results_model_comparison_dir=root / "results" / "model-comparison",
        results_confusion_matrices_dir=root / "results" / "confusion-matrices",
        figures_eda_dir=root / "figures" / "eda",
        figures_learning_curves_dir=root / "figures" / "learning-curves",
        figures_model_complexity_dir=root / "figures" / "model-complexity-curves",
        figures_confusion_matrices_dir=root / "figures" / "confusion-matrices",
        figures_runtime_dir=root / "figures" / "runtime",
        reports_dir=root / "reports",
    )
    return paths.ensure()
