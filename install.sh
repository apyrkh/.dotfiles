#!/bin/bash

# Directory containing dotfiles
dotfiles_dir="$HOME/.dotfiles"

# Function to check if a file exists in the repo
function file_exists() {
  file="$1"

  if [ ! -f "$dotfiles_dir/$file" ]; then
    echo "File '$dotfiles_dir/$file' not found in the repository"
    return 1
  fi

  return 0
}

# Function to remove a symlink if it exists
function remove_symlink_if_exists() {
  file="$1"

  if [ -f "$HOME/$file" ]; then
    echo "Removing existing symlink '$HOME/$file'..."
    rm -rf "$HOME/$file"

    if [ -f "$HOME/$file" ]; then
      echo "Error removing symlink '$HOME/$file'"
      return 1
    fi
  fi

  return 0
}

# Function to create a symlink
function create_symlink() {
  file="$1"

  echo "Creating symlink '$HOME/$file'..."
  ln -s "$dotfiles_dir/$file" "$HOME/$file"

  if [ ! -f "$HOME/$file" ]; then
    echo "Error creating symlink '$HOME/$file'"
    return 1
  fi

  return 0
}

# List of files to create symlinks for
files=(
  ".gitconfig"
  ".zshrc"
)

# Main function
function main() {
  echo "Installing dotfiles..."

  for file in "${files[@]}"; do
    if file_exists "$file"; then
      remove_symlink_if_exists "$file"
      create_symlink "$file"
    fi
  done

  echo "... dotfiles installed successfully!"
}

# Call main function
main
