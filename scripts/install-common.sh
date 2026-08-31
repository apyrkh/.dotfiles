#!/usr/bin/env bash
set -euo pipefail

# Installers that are identical on every platform: they ship their own
# binaries into $HOME, so keeping them here avoids duplicating the same
# ~25 lines in install-mac.sh and install-ubuntu.sh (and drifting apart).
echo "==> [Common] Installing shell framework & user-local CLIs..."

export PATH="$HOME/.local/bin:$PATH"

# Oh My Zsh + plugins (.zshrc expects these to exist)
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    echo "==> Installing Oh My Zsh..."
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

plugins_dir="$HOME/.oh-my-zsh/custom/plugins"
# Plain (not associative) array: the default /bin/bash on macOS is 3.2,
# which has no `declare -A` support.
zsh_plugins=(
    "zsh-autosuggestions|https://github.com/zsh-users/zsh-autosuggestions"
    "zsh-syntax-highlighting|https://github.com/zsh-users/zsh-syntax-highlighting"
    "you-should-use|https://github.com/MichaelAquilina/zsh-you-should-use"
)
for entry in "${zsh_plugins[@]}"; do
    plugin="${entry%%|*}"
    repo="${entry#*|}"
    [[ -d "$plugins_dir/$plugin" ]] || git clone --depth=1 "$repo" "$plugins_dir/$plugin"
done

# Claude Code CLI — the macOS `claude` cask is the desktop app, a different
# product; the CLI ships its own installer into ~/.local/bin on both platforms.
if ! command -v claude &>/dev/null; then
    echo "==> Installing Claude Code..."
    curl -fsSL https://claude.ai/install.sh | bash
fi

# AntiGravity CLI (agy)
if ! command -v agy &>/dev/null; then
    echo "==> Installing AntiGravity CLI (agy)..."
    curl -fsSL https://antigravity.google/cli/install.sh | bash
fi
