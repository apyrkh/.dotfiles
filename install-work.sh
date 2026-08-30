#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

"$script_dir/install.sh"

echo "==> [macOS/Work] Installing GUI apps & Docker..."

formulae=(
    peon-ping
    cowsay
    fortune
    battery
    colima
    docker
)

casks=(
    "wezterm@nightly"
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
