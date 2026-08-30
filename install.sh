#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

echo "==> Detecting operating system..."

case "${OSTYPE:-}" in
  darwin*)
    echo "==> macOS detected"
    "$script_dir/scripts/install-mac.sh"
    ;;
  linux-gnu*)
    echo "==> Linux detected"
    "$script_dir/scripts/install-linux.sh"
    ;;
  *)
    echo "Error: unsupported OS: ${OSTYPE:-unknown}" >&2
    exit 1
    ;;
esac

echo "==> Linking dotfiles..."
"$script_dir/scripts/symlinks.sh"

echo "==> Base install complete."
