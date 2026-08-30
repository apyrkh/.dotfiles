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

echo "==> Work install complete."
