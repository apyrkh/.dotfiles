#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

"$script_dir/install.sh"

if [[ "$(uname -s)" != "Darwin" ]]; then
    echo "==> Skipping work layer: macOS only."
    exit 0
fi

echo "==> [macOS/Work] Installing GUI apps & Docker..."

# === containers ===
formulae=(
    colima            # container runtime for macOS, alternative to docker desktop
    docker
    docker-buildx     # `docker build` (BuildKit) — see the cli-plugins links below
    docker-compose    # `docker compose`
)

# === fun / misc ===
formulae+=(
    peon-ping         # https://www.peonping.com — run `peon-ping-setup` once
    cowsay
    fortune
)

# === terminal ===
casks=(
    "wezterm@nightly" # using nightly deliberately; switch to "wezterm" for stable
)

# === apps ===
casks+=(
    battery           # menu-bar app + CLI: `battery maintain 70-80`
    jetbrains-toolbox # enable "Shell scripts" in it to get goland/webstorm on PATH
    google-chrome
    opera
    keepassxc
    appcleaner
    keycastr          # keystroke visualiser
    "logi-options+"
)

brew tap peonping/tap
brew install "${formulae[@]}"
brew install --cask "${casks[@]}"

# docker-buildx/docker-compose are CLI plugins: `docker` only finds them under
# ~/.docker/cli-plugins, not in Homebrew's prefix. Without these links every
# `docker build` silently falls back to the deprecated legacy (non-BuildKit)
# builder and `docker compose` is missing entirely.
mkdir -p "$HOME/.docker/cli-plugins"
for plugin in docker-buildx docker-compose; do
    ln -sfn "$(brew --prefix)/lib/docker/cli-plugins/$plugin" "$HOME/.docker/cli-plugins/$plugin"
done

echo "==> Work install complete."
