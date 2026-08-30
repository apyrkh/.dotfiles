#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

"$script_dir/install-work.sh"

echo "==> [macOS/Home] Installing personal media & gaming apps..."

formulae=(
    ffmpeg
    ghostscript
    pngquant
    jpegoptim
    webp
    libheif
    mtr
)

casks=(
    google-drive
    notion
    chatgpt
    adobe-acrobat-reader
    iina
    obs
    upscayl
    openmtp
    balenaetcher
    battle-net
    steam
    discord
    telegram
    whatsapp
    zoom
)

brew install "${formulae[@]}"
brew install --cask "${casks[@]}"

echo "==> Home install complete."
