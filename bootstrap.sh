#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$HOME/.dotfiles"
REPO_URL="https://github.com/apyrkh/dotfiles.git"

echo "==> Fetching dotfiles..."
if [ -d "$DOTFILES_DIR" ]; then
    git -C "$DOTFILES_DIR" pull
else
    git clone "$REPO_URL" "$DOTFILES_DIR"
fi

cd "$DOTFILES_DIR"

echo "==> Running base installer..."
./install.sh
