#!/usr/bin/env bash
set -euo pipefail

echo "==> [Linux/DevContainer] Installing Base CLI tools via apt-get & standalone installers..."

export DEBIAN_FRONTEND=noninteractive

# Standalone installers below drop binaries into these dirs; export them now
# so this script's own "already installed" checks work on rerun, and so `fd`
# resolves right after being aliased.
export PATH="$HOME/.bun/bin:$HOME/.local/bin:$HOME/.local/share/fnm:$PATH"

sudo apt-get update -y
sudo apt-get install -y \
    build-essential \
    curl \
    git \
    gh \
    zsh \
    ripgrep \
    fd-find \
    fzf \
    unzip \
    neovim \
    cmake \
    luarocks \
    tree \
    sqlite3 \
    postgresql-client \
    xclip

# Ubuntu's fd-find package installs the binary as "fdfind" (name clash with
# an existing package); alias it to "fd" since that's what fzf-lua/nvim expect.
mkdir -p "$HOME/.local/bin"
if ! command -v fd &>/dev/null; then
    ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd"
fi

# FNM (Fast Node Manager)
if ! command -v fnm &>/dev/null; then
    echo "==> Installing FNM..."
    curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell
fi

# Bun
if ! command -v bun &>/dev/null; then
    echo "==> Installing Bun..."
    curl -fsSL https://bun.sh/install | bash
fi

# UV (Python package installer)
if ! command -v uv &>/dev/null; then
    echo "==> Installing UV..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
fi

# AntiGravity CLI (agy)
if ! command -v agy &>/dev/null; then
    echo "==> Installing AntiGravity CLI (agy)..."
    curl -fsSL https://antigravity.google/cli/install.sh | bash
fi
