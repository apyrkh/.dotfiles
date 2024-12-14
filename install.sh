#!/bin/bash

dotfiles_dir="$HOME/.dotfiles"
files=(
  ".config/nvim"
  ".config/wezterm"
  ".gitconfig"
  ".vimrc"
  ".zshrc"
)

echo "=== Installing dotfiles ==="
echo ""

for file in "${files[@]}"; do
  echo "Creating symlink '$HOME/$file':"

  if [ -e "$HOME/$file" ]; then
    echo "... removing existing"
    rm -rf "$HOME/$file"
  fi

  echo "... creating new"
  ln -s "$dotfiles_dir/$file" "$HOME/$file"

  echo "Created!"
  echo ""
done

echo "=== Dotfiles installed successfully! ==="
