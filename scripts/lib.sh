#!/usr/bin/env bash

die() {
  printf 'Error: %s\n' "$*" >&2
  exit 1
}

info() {
  printf '==> %s\n' "$*"
}

require_command() {
  command -v "$1" >/dev/null 2>&1 || die "required command not found: $1"
}

run_as_root() {
  if [[ "${EUID:-$(id -u)}" -eq 0 ]]; then
    "$@"
    return
  fi

  require_command sudo
  sudo -n true || die "passwordless sudo is required for unattended package installation"
  sudo -n "$@"
}

ensure_git_checkout() {
  local repository="$1"
  local destination="$2"

  if [[ -d "$destination/.git" ]]; then
    return
  fi

  if [[ -e "$destination" ]]; then
    die "cannot install into existing non-git path: $destination"
  fi

  info "Cloning $repository"
  git clone --depth=1 "$repository" "$destination"
}

link_if_absent() {
  local source_path="$1"
  local target_path="$2"

  if [[ -L "$target_path" ]] && [[ "$source_path" -ef "$target_path" ]]; then
    return
  fi

  if [[ -e "$target_path" || -L "$target_path" ]]; then
    die "refusing to replace existing path: $target_path"
  fi

  mkdir -p "$(dirname "$target_path")"
  ln -s "$source_path" "$target_path"
}

find_bun() {
  local dotfiles_home="$1"
  local candidate

  for candidate in "$(command -v bun || true)" "$dotfiles_home/.bun/bin/bun"; do
    if [[ -n "$candidate" && -x "$candidate" ]]; then
      printf '%s\n' "$candidate"
      return
    fi
  done

  return 1
}

install_bun_global_package() {
  local dotfiles_home="$1"
  local package_name="$2"
  local command_name="$3"
  local display_name="$4"
  local bun_bin
  local command_path="$dotfiles_home/.bun/bin/$command_name"

  if [[ -x "$command_path" ]]; then
    info "$display_name is already installed"
    return
  fi

  bun_bin="$(find_bun "$dotfiles_home")" || die "Bun is required to install $display_name"
  info "Installing $display_name with Bun"
  BUN_INSTALL="$dotfiles_home/.bun" "$bun_bin" add --global "$package_name"
  [[ -x "$command_path" ]] || die "Bun did not install $display_name"
}

install_devcontainer_cli() {
  install_bun_global_package "$1" @devcontainers/cli devcontainer "Dev Container CLI"
}
