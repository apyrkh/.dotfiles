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
    echo "==> Linux detected"
    "$script_dir/scripts/install-ubuntu.sh"
    ;;
  *)
    echo "Error: unsupported OS: $os" >&2
    exit 1
    ;;
esac

echo "==> Linking dotfiles..."
"$script_dir/scripts/symlinks.sh"

echo "==> Base install complete."
