#!/usr/bin/env bash
set -euo pipefail

echo "==> [macOS] Installing Base CLI tools & runtimes via Homebrew..."

if ! command -v brew &>/dev/null; then
    echo "==> Installing Homebrew..."
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"
fi

# === fonts ===
brew install --cask font-jetbrains-mono-nerd-font

# === shell ===
brew install zsh                # macOS ships zsh 5.9; brew's is newer

# === dev tools ===
brew install cmake
brew install go
brew install fnm                # fast Node.js version manager (Rust-based replacement for nvm)
brew install uv                 # Python package/tool installer
brew install libpq              # psql, pg_dump — keg-only, .zshenv puts it on PATH

# === neovim (runtime deps) ===
brew install neovim
brew install tree-sitter-cli    # nvim-treesitter's main branch needs it to compile parsers
brew install luarocks
brew install fzf
brew install fd
brew install ripgrep

# === cli ===
brew install git
brew install gh                 # GitHub CLI
brew install lazygit
brew install tree
brew install eza                # modern ls replacement
brew install zoxide             # zi
brew install fx                 # json viewer and processor, https://fx.wtf
brew install gnu-time           # gtime; the shell's own `time` has no formatting options

# Deliberately not installed:
#   sqlite3   — macOS ships /usr/bin/sqlite3; brew's is keg-only anyway
#   bun       — scripts/install-common.sh uses bun's own installer, as on Ubuntu
#   claude    — that cask is the Claude desktop app, not the Claude Code CLI
#   warp      — tried, not kept
