#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

echo "==> Detecting operating system..."

os="$(uname -s)"
case "$os" in
  Darwin)
    echo "==> macOS detected"
    "$script_dir/scripts/install-mac.sh"
    ;;
  Linux)
    # Linux support is scoped to Ubuntu (matching .devcontainer's base image).
    # Fail loudly here instead of somewhere deep inside an apt-get call.
    if ! grep -qE '^(ID|ID_LIKE)=.*ubuntu' /etc/os-release 2>/dev/null; then
      echo "Error: Linux support is Ubuntu-only" >&2
      exit 1
    fi
    echo "==> Ubuntu detected"
    "$script_dir/scripts/install-ubuntu.sh"
    ;;
  *)
    echo "Error: unsupported OS: $os" >&2
    exit 1
    ;;
esac

"$script_dir/scripts/install-common.sh"

echo "==> Linking dotfiles..."
"$script_dir/scripts/symlinks.sh"

echo "==> Base install complete."
