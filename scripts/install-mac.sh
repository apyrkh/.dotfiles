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

# === ai ===
formulae+=(
    claude
    copilot-cli
    codex
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

brew install "${formulae[@]}"
brew install --cask "${casks[@]}"

# Oh My Zsh + plugins
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

# AntiGravity CLI (agy)
if ! command -v agy &>/dev/null; then
    echo "==> Installing AntiGravity CLI (agy)..."
    curl -fsSL https://antigravity.google/cli/install.sh | bash
fi
