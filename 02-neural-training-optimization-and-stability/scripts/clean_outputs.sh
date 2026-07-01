#!/usr/bin/env bash
set -euo pipefail

# Clean generated/redundant files before GitHub push.
# Keeps the project folder structure using .gitkeep files.
#
# Run from project root:
#   bash scripts/clean_outputs.sh

cd "$(dirname "$0")/.."

echo "Cleaning generated files for GitHub push..."
echo "Project root: $PWD"

# ---------------------------------------------------------------------
# Helper: clean directory contents but preserve the folder itself
# ---------------------------------------------------------------------
clean_dir_keep_gitkeep() {
  local dir="$1"

  if [ -d "$dir" ]; then
    echo "Cleaning: $dir"
    find "$dir" -mindepth 1 ! -name ".gitkeep" -exec rm -rf {} +
    touch "$dir/.gitkeep"
  else
    echo "Creating: $dir"
    mkdir -p "$dir"
    touch "$dir/.gitkeep"
  fi
}

# ---------------------------------------------------------------------
# Clean generated data
# ---------------------------------------------------------------------
clean_dir_keep_gitkeep "data/processed"
clean_dir_keep_gitkeep "data/raw/covertype"

# ---------------------------------------------------------------------
# Clean generated metrics/results
# ---------------------------------------------------------------------
clean_dir_keep_gitkeep "results/metrics"
clean_dir_keep_gitkeep "results/runtime"
clean_dir_keep_gitkeep "results/model-comparison"
clean_dir_keep_gitkeep "results/confusion-matrices"

# ---------------------------------------------------------------------
# Clean generated figures
# ---------------------------------------------------------------------
clean_dir_keep_gitkeep "figures/eda"
clean_dir_keep_gitkeep "figures/learning-curves"
clean_dir_keep_gitkeep "figures/model-complexity-curves"
clean_dir_keep_gitkeep "figures/confusion-matrices"
clean_dir_keep_gitkeep "figures/runtime"

# ---------------------------------------------------------------------
# Remove notebook checkpoints and Python cache files
# ---------------------------------------------------------------------
echo "Removing notebook checkpoints and Python caches..."

find . -type d -name ".ipynb_checkpoints" -prune -exec rm -rf {} +
find . -type d -name "__pycache__" -prune -exec rm -rf {} +
find . -type f -name "*.pyc" -delete
find . -type f -name "*.pyo" -delete

# ---------------------------------------------------------------------
# Remove common temporary/runtime files
# ---------------------------------------------------------------------
echo "Removing temporary files..."

find . -type f -name ".DS_Store" -delete
find . -type f -name "*.log" -delete
find . -type f -name "*.tmp" -delete
find . -type f -name "*.bak" -delete

# ---------------------------------------------------------------------
# Strip notebook outputs without requiring nbstripout
# ---------------------------------------------------------------------
echo "Stripping notebook outputs..."

python - <<'PY'
import json
from pathlib import Path

notebook_dir = Path("notebooks")

if not notebook_dir.exists():
    print("No notebooks/ directory found. Skipping notebook output stripping.")
    raise SystemExit(0)

for path in sorted(notebook_dir.glob("*.ipynb")):
    try:
        with path.open("r", encoding="utf-8") as f:
            nb = json.load(f)

        changed = False

        for cell in nb.get("cells", []):
            if cell.get("cell_type") == "code":
                if cell.get("outputs"):
                    cell["outputs"] = []
                    changed = True
                if cell.get("execution_count") is not None:
                    cell["execution_count"] = None
                    changed = True

        if changed:
            with path.open("w", encoding="utf-8") as f:
                json.dump(nb, f, indent=1, ensure_ascii=False)
                f.write("\n")
            print(f"Stripped outputs: {path}")
        else:
            print(f"Already clean: {path}")

    except Exception as exc:
        print(f"WARNING: Could not clean notebook {path}: {exc}")
PY

# ---------------------------------------------------------------------
# Recreate required folder skeleton
# ---------------------------------------------------------------------
echo "Ensuring required folder structure exists..."

required_dirs=(
  "data/raw/covertype"
  "data/processed"
  "results/metrics"
  "results/runtime"
  "results/model-comparison"
  "results/confusion-matrices"
  "figures/eda"
  "figures/learning-curves"
  "figures/model-complexity-curves"
  "figures/confusion-matrices"
  "figures/runtime"
  "reports"
)

for dir in "${required_dirs[@]}"; do
  mkdir -p "$dir"
  touch "$dir/.gitkeep"
done

echo ""
echo "Cleanup complete."
echo ""
echo "Recommended next checks:"
echo "  git status"
echo "  git add ."
echo "  git commit -m \"Clean generated outputs before push\""