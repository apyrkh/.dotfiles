#!/usr/bin/env bash
set -euo pipefail

dotfiles_dir="$1"
dotfiles_home="$2"
install_home_profile="$3"

# shellcheck source=lib.sh
source "$dotfiles_dir/scripts/lib.sh"

find_brew() {
  local candidate

  for candidate in "$(command -v brew || true)" /opt/homebrew/bin/brew /usr/local/bin/brew; do
    if [[ -n "$candidate" && -x "$candidate" ]]; then
      printf '%s\n' "$candidate"
      return
    fi
  done

  return 1
}

brew_bin="$(find_brew || true)"
if [[ -z "$brew_bin" ]]; then
  info "Installing Homebrew"
  # Homebrew's own installer prompts for sudo itself when it needs elevation
  # (e.g. creating /opt/homebrew); don't require passwordless sudo up front.
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew_bin="$(find_brew)" || die "Homebrew installation completed but brew was not found"
fi

eval "$("$brew_bin" shellenv)"

info "Installing macOS work profile"
"$brew_bin" bundle --file "$dotfiles_dir/Brewfile"
install_devcontainer_cli "$dotfiles_home"

if [[ "$install_home_profile" -eq 1 ]]; then
  info "Installing macOS home profile"
  "$brew_bin" bundle --file "$dotfiles_dir/Brewfile.home"
fi

# Add deliberate defaults here only when they are explicitly tracked and documented.
apply_macos_defaults() {
  :
}

apply_macos_defaults
