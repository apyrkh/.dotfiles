#!/usr/bin/env bash
set -euo pipefail

# Platform-independent installers: they ship binaries into $HOME, so keeping
# them here avoids duplicating ~25 lines across the two platform scripts.
echo "==> [Common] Installing shell framework & user-local CLIs..."

export PATH="$HOME/.bun/bin:$HOME/.local/bin:$HOME/.local/share/fnm:$PATH"

# Bun — own installer on both platforms. Must come first: the AI CLIs below
# are bun-installed npm packages.
if ! command -v bun &>/dev/null; then
    echo "==> Installing Bun..."
    curl -fsSL https://bun.sh/install | bash
fi

# Node.js LTS — fnm ships no runtime, but Neovim's Mason tooling needs node/npm
# out of the box. .zshrc's `fnm env --use-on-cd` picks up this default.
if ! fnm exec --using=default node --version &>/dev/null; then
    echo "==> Installing Node.js LTS..."
    fnm install --lts --progress never
    fnm default lts-latest
fi

# AI CLIs — Claude Code and agy ship installers; Copilot and Codex are npm
# packages. (macOS `claude` cask is the desktop app, not this.)
if ! command -v claude &>/dev/null; then
    echo "==> Installing Claude Code..."
    curl -fsSL https://claude.ai/install.sh | bash
fi

if ! command -v agy &>/dev/null; then
    echo "==> Installing AntiGravity CLI (agy)..."
    curl -fsSL https://antigravity.google/cli/install.sh | bash
fi

if ! command -v copilot &>/dev/null; then
    echo "==> Installing GitHub Copilot CLI..."
    bun add --global @github/copilot
fi

if ! command -v codex &>/dev/null; then
    echo "==> Installing Codex CLI..."
    bun add --global @openai/codex
fi

# Oh My Zsh + plugins (.zshrc expects these to exist)
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    echo "==> Installing Oh My Zsh..."
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

plugins_dir="$HOME/.oh-my-zsh/custom/plugins"
[[ -d "$plugins_dir/zsh-autosuggestions" ]]     || git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "$plugins_dir/zsh-autosuggestions"
[[ -d "$plugins_dir/zsh-syntax-highlighting" ]] || git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting "$plugins_dir/zsh-syntax-highlighting"
[[ -d "$plugins_dir/you-should-use" ]]          || git clone --depth=1 https://github.com/MichaelAquilina/zsh-you-should-use "$plugins_dir/you-should-use"
