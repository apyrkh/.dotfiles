#!/bin/bash

dotfiles_dir="$HOME/.dotfiles"
files=(
  ".config/nvim"
  ".config/wezterm"
  ".gitconfig"
  ".zshrc"
)

echo "=== Installing dotfiles ==="

for file in "${files[@]}"; do
  echo "Creating symlink '$HOME/$file' ..."

  if [ -e "$HOME/$file" ]; then
    echo "    removing existing files"
    rm -rf "$HOME/$file"
  fi

  echo "    creating symlink"
  ln -s "$dotfiles_dir/$file" "$HOME/$file"

  echo "    done"
done

echo "=== Dotfiles installed successfully! ==="
