#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENV_DIR="$ROOT_DIR/.venv"
PYTHON="$VENV_DIR/bin/python"
KERNEL_NAME="ocom5100m-pfds"
KERNEL_DISPLAY_NAME="Python (OCOM5100M-PfDS)"
USER_HOME="${HOME:-}"
ANACONDA_VERSION="${ANACONDA_VERSION:-2025.12-2}"
ANACONDA_DIR="${ANACONDA_DIR:-${USER_HOME}/anaconda3}"

cd "$ROOT_DIR"

PACKAGE_MODULE_PAIRS=(
    "jupyterlab:jupyterlab"
    "notebook:notebook"
    "ipykernel:ipykernel"
    "numpy:numpy"
    "pandas:pandas"
    "matplotlib:matplotlib"
    "scikit-learn:sklearn"
    "seaborn:seaborn"
    "joblib:joblib"
    "palmerpenguins:palmerpenguins"
)

usage() {
    cat <<EOF
Usage: $(basename "$0") [OPTION]

Prepare and check the Python environment for OCOM5100M-PfDS notebooks.

Options:
  -c, --check    Check the current environment only; do not install or modify it.
  -i, --install  Check and install missing requirements (default).
  -h, --help     Show this help message and exit.

Prerequisites:
  - macOS or Linux with Bash 3.2+.
  - Homebrew for automatic installation on macOS, or curl/wget on Ubuntu.
  - Python 3 available in PATH when creating the virtual environment.

Examples:
  $(basename "$0")             # Check and install missing requirements
  $(basename "$0") --check     # Report installed and missing tools/versions
  $(basename "$0") --help
EOF
}

MODE="install"
case "${1:-}" in
    "") ;;
    -c|--check) MODE="check" ;;
    -i|--install) MODE="install" ;;
    -h|--help) usage; exit 0 ;;
    *)
        echo "Error: unknown option: $1" >&2
        usage >&2
        exit 2
        ;;
esac

if (( $# > 1 )); then
    echo "Error: expected zero or one option, got extra arguments." >&2
    usage >&2
    exit 2
fi

version_or_missing() {
    local command_name="$1"
    if command -v "$command_name" >/dev/null 2>&1; then
        "$command_name" --version 2>&1 | head -n 1
    else
        printf '%s' 'not installed'
    fi
}

find_conda() {
    local candidate

    if command -v conda >/dev/null 2>&1; then
        command -v conda
        return 0
    fi

    for candidate in \
        "/opt/anaconda3/bin/conda" \
        "/usr/local/anaconda3/bin/conda" \
        "$USER_HOME/anaconda3/bin/conda" \
        "$USER_HOME/miniconda3/bin/conda"; do
        if [[ -x "$candidate" ]]; then
            printf '%s' "$candidate"
            return 0
        fi
    done

    return 1
}

ensure_uv() {
    if command -v uv >/dev/null 2>&1; then
        echo "uv is already installed: $(version_or_missing uv)"
        return 0
    fi

    if command -v brew >/dev/null 2>&1; then
        echo "Installing uv with Homebrew"
        brew install uv
    elif command -v curl >/dev/null 2>&1; then
        echo "Installing uv with the official installer"
        mkdir -p "$USER_HOME/.local/bin"
        curl -LsSf https://astral.sh/uv/install.sh | env UV_INSTALL_DIR="$USER_HOME/.local/bin" sh
        export PATH="$USER_HOME/.local/bin:$PATH"
    elif command -v wget >/dev/null 2>&1; then
        echo "Installing uv with the official installer"
        mkdir -p "$USER_HOME/.local/bin"
        wget -qO- https://astral.sh/uv/install.sh | env UV_INSTALL_DIR="$USER_HOME/.local/bin" sh
        export PATH="$USER_HOME/.local/bin:$PATH"
    else
        echo "Error: uv is missing and neither Homebrew, curl, nor wget was found." >&2
        exit 1
    fi
    hash -r

    if ! command -v uv >/dev/null 2>&1; then
        echo "Error: uv installation finished but uv is not available in PATH." >&2
        exit 1
    fi
}

ensure_anaconda() {
    local conda_bin

    if conda_bin="$(find_conda)"; then
        echo "Anaconda/Conda is already installed: $($conda_bin --version 2>&1)"
        return 0
    fi

    case "$(uname -s)" in
        Darwin)
            if ! command -v brew >/dev/null 2>&1; then
                echo "Error: Anaconda is missing and Homebrew was not found." >&2
                echo "Install Homebrew or Anaconda, then run this script again." >&2
                exit 1
            fi
            echo "Installing Anaconda with Homebrew"
            brew install --cask anaconda
            ;;
        Linux)
            local architecture installer_name installer_path installer_url
            if [[ -z "$USER_HOME" ]]; then
                echo "Error: HOME is not set; cannot choose an Anaconda installation directory." >&2
                exit 1
            fi
            case "$(uname -m)" in
                x86_64) installer_name="Anaconda3-${ANACONDA_VERSION}-Linux-x86_64.sh" ;;
                aarch64|arm64) installer_name="Anaconda3-${ANACONDA_VERSION}-Linux-aarch64.sh" ;;
                *)
                    echo "Error: unsupported Linux architecture: $(uname -m)" >&2
                    exit 1
                    ;;
            esac
            installer_url="https://repo.anaconda.com/archive/$installer_name"
            installer_path="$(mktemp "${TMPDIR:-/tmp}/anaconda-installer.XXXXXX.sh")"
            trap 'rm -f "$installer_path"' EXIT
            echo "Downloading Anaconda $ANACONDA_VERSION for $(uname -m)"
            if command -v curl >/dev/null 2>&1; then
                curl -fL "$installer_url" -o "$installer_path"
            elif command -v wget >/dev/null 2>&1; then
                wget -O "$installer_path" "$installer_url"
            else
                echo "Error: curl or wget is required to download Anaconda on Linux." >&2
                exit 1
            fi
            chmod +x "$installer_path"
            echo "Installing Anaconda to $ANACONDA_DIR"
            bash "$installer_path" -b -p "$ANACONDA_DIR"
            rm -f "$installer_path"
            trap - EXIT
            ;;
        *)
            echo "Error: automatic Anaconda installation supports macOS and Linux only." >&2
            exit 1
            ;;
    esac
    hash -r

    if [[ -x "$ANACONDA_DIR/bin/conda" ]]; then
        export PATH="$ANACONDA_DIR/bin:$PATH"
    fi

    if ! conda_bin="$(find_conda)"; then
        echo "Error: Anaconda installation finished but conda was not found." >&2
        echo "Add the Anaconda bin directory to PATH, then run this script again." >&2
        exit 1
    fi
    echo "Anaconda installed: $($conda_bin --version 2>&1)"
}

report_environment() {
    local status version pair package module

    echo "Environment: $ROOT_DIR"
    printf '%-22s %-14s %s\n' "Tool" "Status" "Version"
    printf '%-22s %-14s %s\n' "----" "------" "-------"

    if command -v uv >/dev/null 2>&1; then
        printf '%-22s %-14s %s\n' "uv" "installed" "$(version_or_missing uv)"
    else
        printf '%-22s %-14s %s\n' "uv" "missing" "-"
    fi
    if command -v python3 >/dev/null 2>&1; then
        printf '%-22s %-14s %s\n' "python3" "installed" "$(python3 --version 2>&1)"
    else
        printf '%-22s %-14s %s\n' "python3" "missing" "-"
    fi
    if [[ -x "$PYTHON" ]]; then
        printf '%-22s %-14s %s\n' ".venv Python" "installed" "$($PYTHON --version 2>&1)"
    else
        printf '%-22s %-14s %s\n' ".venv Python" "missing" "-"
    fi
    if conda_bin="$(find_conda)"; then
        printf '%-22s %-14s %s\n' "Anaconda/conda" "installed" "$($conda_bin --version 2>&1)"
    else
        printf '%-22s %-14s %s\n' "Anaconda/conda" "missing" "-"
    fi

    for pair in "${PACKAGE_MODULE_PAIRS[@]}"; do
        IFS=: read -r package module <<< "$pair"
        if [[ -x "$PYTHON" ]] && "$PYTHON" -c "import $module" >/dev/null 2>&1; then
            version="$($PYTHON -c "from importlib.metadata import version; print(version('$package'))" 2>/dev/null || printf '%s' 'unknown')"
            status="installed"
        else
            status="missing"
            version="-"
        fi
        printf '%-22s %-14s %s\n' "$package" "$status" "$version"
    done

    if [[ -f "$VENV_DIR/share/jupyter/kernels/$KERNEL_NAME/kernel.json" ]]; then
        printf '%-22s %-14s %s\n' "Jupyter kernel" "installed" "$KERNEL_DISPLAY_NAME"
    else
        printf '%-22s %-14s %s\n' "Jupyter kernel" "missing" "$KERNEL_DISPLAY_NAME"
    fi
}

if [[ "$MODE" == "check" ]]; then
    report_environment
    exit 0
fi

ensure_uv
ensure_anaconda

if ! command -v python3 >/dev/null 2>&1 && [[ ! -x "$PYTHON" ]]; then
    echo "Error: Python 3 is required to create the virtual environment." >&2
    exit 1
fi

if [[ ! -x "$PYTHON" ]]; then
    echo "Creating virtual environment in $VENV_DIR"
    uv venv "$VENV_DIR" --python python3
else
    echo "Using existing virtual environment in $VENV_DIR"
fi

missing_packages=()
for pair in "${PACKAGE_MODULE_PAIRS[@]}"; do
    IFS=: read -r package module <<< "$pair"
    if ! "$PYTHON" -c "import importlib.util; raise SystemExit(0 if importlib.util.find_spec('$module') else 1)"; then
        missing_packages+=("$package")
    fi
done

if (( ${#missing_packages[@]} > 0 )); then
    echo "Installing missing packages: ${missing_packages[*]}"
    uv pip install --python "$PYTHON" "${missing_packages[@]}"
else
    echo "All required Python packages are already installed"
fi

# Keep Jupyter state inside the project so setup does not depend on user-directory permissions.
mkdir -p "$ROOT_DIR/.jupyter/config" "$ROOT_DIR/.jupyter/data" "$ROOT_DIR/.jupyter/runtime"

KERNEL_DIR="$VENV_DIR/share/jupyter/kernels/$KERNEL_NAME"
KERNEL_FILE="$KERNEL_DIR/kernel.json"
if [[ ! -f "$KERNEL_FILE" ]] || ! grep -Fq '"'"$PYTHON"'"' "$KERNEL_FILE"; then
    echo "Registering Jupyter kernel: $KERNEL_DISPLAY_NAME"
    JUPYTER_CONFIG_DIR="$ROOT_DIR/.jupyter/config" \
    JUPYTER_DATA_DIR="$ROOT_DIR/.jupyter/data" \
    JUPYTER_RUNTIME_DIR="$ROOT_DIR/.jupyter/runtime" \
    "$PYTHON" -m ipykernel install --sys-prefix \
        --name "$KERNEL_NAME" \
        --display-name "$KERNEL_DISPLAY_NAME"
else
    echo "Jupyter kernel is already registered"
fi

JUPYTER_CONFIG_DIR="$ROOT_DIR/.jupyter/config" \
JUPYTER_DATA_DIR="$ROOT_DIR/.jupyter/data" \
JUPYTER_RUNTIME_DIR="$ROOT_DIR/.jupyter/runtime" \
"$PYTHON" - <<'PY'
import importlib

modules = [
    "jupyterlab",
    "notebook",
    "ipykernel",
    "numpy",
    "pandas",
    "matplotlib",
    "sklearn",
    "seaborn",
    "joblib",
    "palmerpenguins",
]

for module in modules:
    importlib.import_module(module)

from palmerpenguins import load_penguins

assert len(load_penguins()) > 0
print("Environment check passed")
PY

echo
report_environment

echo
echo "Setup complete. Start JupyterLab with:"
echo "  source .venv/bin/activate"
echo "  JUPYTER_CONFIG_DIR=\"\$PWD/.jupyter/config\" JUPYTER_DATA_DIR=\"\$PWD/.jupyter/data\" JUPYTER_RUNTIME_DIR=\"\$PWD/.jupyter/runtime\" jupyter lab"
