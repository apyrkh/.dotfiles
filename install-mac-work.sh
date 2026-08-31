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

# docker-buildx is a CLI plugin, not auto-discovered by `docker` unless its
# Homebrew path is registered in ~/.docker/config.json — without this, every
# `docker build` silently falls back to the deprecated legacy (non-BuildKit)
# builder.
docker_config="$HOME/.docker/config.json"
buildx_dir="$(brew --prefix)/lib/docker/cli-plugins"
mkdir -p "$(dirname "$docker_config")"
[[ -f "$docker_config" ]] || echo '{}' > "$docker_config"
python3 -c "
import json
path = '$docker_config'
buildx_dir = '$buildx_dir'
with open(path) as f:
    cfg = json.load(f)
dirs = cfg.setdefault('cliPluginsExtraDirs', [])
if buildx_dir not in dirs:
    dirs.append(buildx_dir)
with open(path, 'w') as f:
    json.dump(cfg, f, indent='\t')
    f.write('\n')
"

echo "==> Work install complete."
