#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
dotfiles_dir="${DOTFILES_DIR:-$script_dir}"
dotfiles_home="${DOTFILES_HOME:-$HOME}"
install_packages=1
install_home_profile=0

usage() {
  cat <<'EOF'
Usage: ./install.sh [options]

Install the default development/work environment for macOS or Debian/Ubuntu.

Options:
  -H, --home       Install the optional macOS home profile.
      --skip-packages
                   Only create configuration symlinks.
  -h, --help       Show this help message.

Environment:
  DOTFILES_DIR     Dotfiles repository directory (defaults to this script's directory).
  DOTFILES_HOME    Target home directory (defaults to $HOME).
EOF
}

while (($#)); do
  case "$1" in
    -H|--home)
      install_home_profile=1
      ;;
    --skip-packages)
      install_packages=0
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      printf 'Error: unknown option: %s\n' "$1" >&2
      usage >&2
      exit 2
      ;;
  esac
  shift
done

if [[ ! -d "$dotfiles_dir/home" ]]; then
  printf 'Error: dotfiles home directory not found: %s/home\n' "$dotfiles_dir" >&2
  exit 1
fi

mkdir -p "$dotfiles_home"

# shellcheck source=scripts/lib.sh
source "$dotfiles_dir/scripts/lib.sh"

case "${OSTYPE:-}" in
  darwin*)
    platform="mac"
    ;;
  linux*)
    # shellcheck disable=SC1091
    source /etc/os-release
    case "${ID:-}" in
      debian|ubuntu)
        platform="linux"
        ;;
      *)
        die "unsupported Linux distribution: ${ID:-unknown}; only Debian and Ubuntu are supported"
        ;;
    esac
    ;;
  *)
    die "unsupported operating system: ${OSTYPE:-unknown}"
    ;;
esac

if ((install_home_profile)) && [[ "$platform" != "mac" ]]; then
  die "--home is only supported on macOS"
fi

info "Installing dotfiles for $platform"

"$dotfiles_dir/scripts/link.sh" "$dotfiles_dir" "$dotfiles_home"

if ((install_packages)); then
  case "$platform" in
    mac)
      "$dotfiles_dir/scripts/mac.sh" "$dotfiles_dir" "$dotfiles_home" "$install_home_profile"
      ;;
    linux)
      "$dotfiles_dir/scripts/linux.sh" "$dotfiles_dir" "$dotfiles_home"
      ;;
  esac
else
  info "Skipping package installation"
fi

info "Completed"
