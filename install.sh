#!/bin/bash
set -e

# Colors
GREEN="\033[0;32m"
CYAN="\033[0;36m"
RED="\033[0;31m"
GRAY="\033[90m"
NC="\033[0m"

STATUS_UP_TO_DATE="✓ up-to-date"
STATUS_LINKED="✓ linked"
STATUS_MISSING="✖ missing source"

backup_dir="$HOME/.dotfiles_backup-$(date +%Y%m%d_%H%M%S)"
dotfiles_dir="$HOME/.dotfiles"
files=(
  ".profile"
  ".config/nvim"
  ".config/nvim.bak"
  ".config/wezterm"
  ".config/zsh"
  ".gitconfig"
  ".vimrc"
  ".zshrc"
)

printf "\n=== Installing dotfiles ===\n\n"

for file in "${files[@]}"; do
  src="$dotfiles_dir/$file"
  dst="$HOME/$file"

  display_src="${src/#$HOME/~}"
  display_dst="${dst/#$HOME/~}"

  # 1. Missing source
  if [ ! -e "$src" ]; then
    printf "${RED}%-35s → %-25s%-10s%s${NC}\n" "$display_src" "$display_dst" "" "$STATUS_MISSING"
    continue
  fi

  # 2. Up-to-date
  # if [ -L "$dst" ] && [ "$(readlink "$dst")" == "$dotfiles_dir/.gitconfig" ]; then # for debug purpose
  if [ -L "$dst" ] && [ "$(readlink "$dst")" == "$src" ]; then
    printf "%-35s → %-25s%-10s${CYAN}%s${NC}\n" "$display_src" "$display_dst" "" "$STATUS_UP_TO_DATE"
    continue
  fi

  # 3. Installation
  printf "%-35s → %-25s" "$display_src" "$display_dst"
  mkdir -p "$(dirname "$dst")"

  if [ -e "$dst" ] || [ -L "$dst" ]; then
    mkdir -p "$backup_dir"
    mv "$dst" "$backup_dir/"
    printf "${GRAY}%-10s${NC}" "(backup)"
  else
    printf "%-10s" ""
  fi

  ln -snf "$src" "$dst"
  printf "${GREEN}%s${NC}\n" "$STATUS_LINKED"
done

if [ -d "$backup_dir" ]; then
  printf "\n${GRAY}Backups saved to: %s${NC}\n" "${backup_dir/#$HOME/~}"
fi

printf "\n=== Completed ===\n\n"
