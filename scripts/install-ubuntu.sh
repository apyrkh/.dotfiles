#!/usr/bin/env bash
set -euo pipefail

echo "==> [Linux/DevContainer] Installing Base CLI tools via apt-get & standalone installers..."

# `sudo` resets the environment by default, so exporting DEBIAN_FRONTEND alone
# doesn't reach the root apt-get process — `sudo env VAR=val cmd` is required
# to actually suppress debconf prompts like tzdata's "Geographic area". With
# noninteractive and no debconf preseed, tzdata's own default answer is
# Etc/UTC — the standard choice for containers/CI regardless of where you are.
export DEBIAN_FRONTEND=noninteractive

# Standalone installers below drop binaries into these dirs; export them now
# so this script's own "already installed" checks work on rerun, and so `fd`
# resolves right after being aliased.
export PATH="$HOME/.bun/bin:$HOME/.local/bin:$HOME/.local/share/fnm:$PATH"

sudo env DEBIAN_FRONTEND=noninteractive apt-get update -y
sudo env DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential \
    curl \
    git \
    gh \
    golang-go \
    zsh \
    ripgrep \
    fd-find \
    fzf \
    unzip \
    cmake \
    luarocks \
    tree \
    sqlite3 \
    postgresql-client \
    zoxide \
    xclip

# Ubuntu's fd-find package installs the binary as "fdfind" (name clash with
# an existing package); alias it to "fd" since that's what fzf-lua/nvim expect.
mkdir -p "$HOME/.local/bin"
if ! command -v fd &>/dev/null; then
    ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd"
fi

# Neovim — Ubuntu's apt package is far behind upstream (0.9.x on 24.04 vs.
# 0.10+ upstream); install the latest release directly instead, like eza/
# lazygit/tree-sitter-cli below. The tarball must stay intact (nvim finds its
# runtime/ dir relative to the real binary path), so unpack it into
# ~/.local/share and only symlink the executable into ~/.local/bin.
if ! command -v nvim &>/dev/null; then
    echo "==> Installing Neovim..."
    arch="$(uname -m)"; [[ "$arch" == "aarch64" ]] && arch="arm64" || arch="x86_64"
    mkdir -p "$HOME/.local/share"
    rm -rf "$HOME/.local/share/nvim-linux-${arch}"
    curl -fsSL "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-${arch}.tar.gz" \
        | tar -xz -C "$HOME/.local/share"
    ln -sf "$HOME/.local/share/nvim-linux-${arch}/bin/nvim" "$HOME/.local/bin/nvim"
fi

# FNM (Fast Node Manager)
if ! command -v fnm &>/dev/null; then
    echo "==> Installing FNM..."
    curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell
fi

# Node.js LTS — fnm alone doesn't ship a runtime, but Neovim tooling (Mason
# LSP servers/formatters) needs a working node/npm out of the box. .zshrc's
# `fnm env --use-on-cd` picks up this default automatically in new shells.
if ! fnm exec --using=default node --version &>/dev/null; then
    echo "==> Installing Node.js LTS..."
    fnm install --lts --progress never
    fnm default lts-latest
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

# eza (modern ls) — not in Ubuntu's default repos; install from upstream release
if ! command -v eza &>/dev/null; then
    echo "==> Installing eza..."
    arch="$(uname -m)"; [[ "$arch" == "aarch64" ]] && arch="aarch64" || arch="x86_64"
    curl -fsSL "https://github.com/eza-community/eza/releases/latest/download/eza_${arch}-unknown-linux-gnu.tar.gz" \
        | tar -xz -C "$HOME/.local/bin" ./eza
fi

# lazygit — not in Ubuntu's default repos; install from upstream release
if ! command -v lazygit &>/dev/null; then
    echo "==> Installing lazygit..."
    arch="$(uname -m)"; [[ "$arch" == "aarch64" ]] && arch="arm64" || arch="x86_64"
    lazygit_version="$(curl -fsSL "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | sed -n 's/.*"tag_name": *"v\([^"]*\)".*/\1/p')"
    curl -fsSL "https://github.com/jesseduffield/lazygit/releases/download/v${lazygit_version}/lazygit_${lazygit_version}_linux_${arch}.tar.gz" \
        | tar -xz -C "$HOME/.local/bin" lazygit
fi

# tree-sitter-cli — not in Ubuntu's default repos; install from upstream release
if ! command -v tree-sitter &>/dev/null; then
    echo "==> Installing tree-sitter-cli..."
    arch="$(uname -m)"; [[ "$arch" == "aarch64" ]] && arch="arm64" || arch="x64"
    curl -fsSL "https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-linux-${arch}.gz" \
        | gunzip > "$HOME/.local/bin/tree-sitter"
    chmod +x "$HOME/.local/bin/tree-sitter"
fi

# AntiGravity CLI (agy)
if ! command -v agy &>/dev/null; then
    echo "==> Installing AntiGravity CLI (agy)..."
    curl -fsSL https://antigravity.google/cli/install.sh | bash
fi

# Oh My Zsh + plugins (.zshrc expects these to exist)
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    echo "==> Installing Oh My Zsh..."
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

plugins_dir="$HOME/.oh-my-zsh/custom/plugins"
# Plain (not associative) array for portability across shells/bash versions.
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
