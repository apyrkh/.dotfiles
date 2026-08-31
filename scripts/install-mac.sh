#!/usr/bin/env bash
set -euo pipefail

echo "==> [macOS] Installing Base CLI tools & runtimes via Homebrew..."

if ! command -v brew &>/dev/null; then
    echo "==> Installing Homebrew..."
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"
fi

# === shell ===
formulae=(
    zsh
)

# === dev tools ===
formulae+=(
    cmake
    go
    fnm
    bun
    uv
    libpq
    sqlite3
)

# === neovim (runtime deps) ===
formulae+=(
    neovim
    tree-sitter-cli
    luarocks
    fzf
    fd
    ripgrep
)

# === cli ===
formulae+=(
    git
    gh
    lazygit
    tree
    eza
    zoxide
    fx
    gnu-time
)

casks=(
    font-jetbrains-mono-nerd-font
)

# === ai === (cask-only, no formula exists for these)
casks+=(
    claude
    copilot-cli
    codex
)

brew install "${formulae[@]}"
brew install --cask "${casks[@]}"
