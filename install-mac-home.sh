#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

"$script_dir/install-mac-work.sh"

if [[ "$(uname -s)" != "Darwin" ]]; then
    echo "==> Skipping home layer: macOS only."
    exit 0
fi

echo "==> [macOS/Home] Installing personal media & gaming apps..."

# === media processing ===
formulae=(
    ffmpeg            # video/audio processing
    ghostscript       # pdf processing
    pngquant          # lossy png compression
    jpegoptim         # jpeg compression
    webp              # cwebp/dwebp; was a transitive dep, now explicit
    libheif           # heic decoding (iphone photos)
)

# === cli ===
formulae+=(
    mtr               # my trace route
)

# === apps ===
casks=(
    google-drive
    notion
    chatgpt
    adobe-acrobat-reader
    iina
    obs
    upscayl
    openmtp           # android-file-transfer
    balenaetcher      # flash OS images to SD cards & USB drives
)

# === fun / misc ===
casks+=(
    battle-net
    steam
    discord
    telegram
    whatsapp
    zoom
)

# Deliberately not installed:
#   blackhole-2ch      — macOS virtual audio loopback driver, install by hand
#   mongodb-community  — was tapped from mongodb/brew; not used any more
#   mongodb-compass    — same
#   paintbrush         — removed 2026-08-31

brew install "${formulae[@]}"
brew install --cask "${casks[@]}"

echo "==> Home install complete."
