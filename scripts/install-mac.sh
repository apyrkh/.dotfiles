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
    zsh               # macOS ships zsh 5.9; brew's is newer and gets security fixes
)

# === dev tools ===
formulae+=(
    cmake
    go
    fnm               # fast Node.js version manager (Rust-based replacement for nvm)
    uv                # Python package/tool installer
    libpq             # psql, pg_dump — keg-only, .zshenv puts it on PATH
)

# === neovim (runtime deps) ===
formulae+=(
    neovim
    tree-sitter-cli   # nvim-treesitter's main branch needs it to compile parsers
    luarocks
    fzf
    fd
    ripgrep
)

# === cli ===
formulae+=(
    git
    gh                # GitHub CLI
    lazygit
    tree
    eza               # modern ls replacement
    zoxide            # zi
    fx                # json viewer and processor, https://fx.wtf
    gnu-time          # gtime; the shell's own `time` has no formatting options
)

# === fonts ===
casks=(
    font-jetbrains-mono-nerd-font
)

# Deliberately not installed:
#   sqlite3   — macOS ships /usr/bin/sqlite3; brew's is keg-only anyway
#   bun       — scripts/install-common.sh uses bun's own installer, as on Ubuntu
#   claude    — that cask is the Claude desktop app, not the Claude Code CLI
#   warp      — tried, not kept

brew install "${formulae[@]}"
brew install --cask "${casks[@]}"
