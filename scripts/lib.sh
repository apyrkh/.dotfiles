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
