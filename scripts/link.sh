#!/usr/bin/env bash
set -euo pipefail

dotfiles_dir="$1"
dotfiles_home="$2"
source_home="$dotfiles_dir/home"
backup_dir=""

# shellcheck source=lib.sh
source "$dotfiles_dir/scripts/lib.sh"

files=(
  ".claude/CLAUDE.md"
  ".claude/skills/bun-performance"
  ".claude/skills/compress-media"
  ".claude/statusline.js"
  ".config/nvim"
  ".config/wezterm"
  ".config/zsh"
  ".gitconfig"
  ".vimrc"
  ".zshrc"
  ".zprofile"
)

create_backup_dir() {
  if [[ -z "$backup_dir" ]]; then
    backup_dir="$dotfiles_home/.dotfiles_backup-$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$backup_dir"
  fi
}

info "Linking managed configuration"

for file in "${files[@]}"; do
  source_path="$source_home/$file"
  target_path="$dotfiles_home/$file"

  [[ -e "$source_path" ]] || die "managed source is missing: $source_path"

  if [[ -L "$target_path" ]] && [[ "$source_path" -ef "$target_path" ]]; then
    info "Up to date: ~/$file"
    continue
  fi

  mkdir -p "$(dirname "$target_path")"

  if [[ -e "$target_path" || -L "$target_path" ]]; then
    create_backup_dir
    mkdir -p "$backup_dir/$(dirname "$file")"
    mv "$target_path" "$backup_dir/$file"
    info "Backed up: ~/$file"
  fi

  ln -s "$source_path" "$target_path"
  info "Linked: ~/$file"
done

if [[ -n "$backup_dir" ]]; then
  info "Backups saved to: $backup_dir"
fi
