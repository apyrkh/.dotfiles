#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

"$script_dir/install.sh"

if [[ "$(uname -s)" != "Darwin" ]]; then
    echo "==> Skipping work layer: macOS only."
    exit 0
fi

echo "==> [macOS/Work] Installing GUI apps & Docker..."

formulae=(
    peon-ping
    cowsay
    fortune
    colima
    docker
    docker-buildx
    docker-compose
)

casks=(
    "wezterm@nightly"
    battery
    jetbrains-toolbox
    google-chrome
    opera
    keepassxc
    appcleaner
    keycastr
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
