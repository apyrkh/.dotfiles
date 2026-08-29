#!/usr/bin/env bash
set -euo pipefail

dotfiles_dir="$1"
home_dir="$HOME"
shopt -s nullglob

assert_link() {
  local source_path="$1"
  local target_path="$2"

  [[ -L "$target_path" ]] && [[ "$source_path" -ef "$target_path" ]] ||
    { printf 'Expected link %s -> %s\n' "$target_path" "$source_path" >&2; exit 1; }
}

assert_command() {
  command -v "$1" >/dev/null 2>&1 ||
    { printf 'Expected command not found: %s\n' "$1" >&2; exit 1; }
}

mkdir -p "$home_dir"
printf 'existing vim configuration\n' > "$home_dir/.vimrc"

DOTFILES_HOME="$home_dir" "$dotfiles_dir/install.sh"

export PATH="$home_dir/.local/bin:$PATH"

for command in curl fd fdfind fzf gcc gh git make nvim rg unzip zsh; do
  assert_command "$command"
done

[[ -x "$home_dir/.local/bin/eza" ]]
[[ -x "$home_dir/.local/share/fnm/fnm" ]]
[[ -d "$home_dir/.oh-my-zsh" ]]
[[ -d "$home_dir/.oh-my-zsh/custom/plugins/zsh-autosuggestions/.git" ]]
[[ -d "$home_dir/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/.git" ]]
[[ -d "$home_dir/.oh-my-zsh/custom/plugins/you-should-use/.git" ]]

assert_link "$dotfiles_dir/home/.config/nvim" "$home_dir/.config/nvim"
assert_link "$dotfiles_dir/home/.zshrc" "$home_dir/.zshrc"
assert_link "$dotfiles_dir/home/.vimrc" "$home_dir/.vimrc"

backups=("$home_dir"/.dotfiles_backup-*)
[[ "${#backups[@]}" -eq 1 ]]
[[ -f "${backups[0]}/.vimrc" ]]
[[ "$(cat "${backups[0]}/.vimrc")" == "existing vim configuration" ]]

DOTFILES_HOME="$home_dir" "$dotfiles_dir/install.sh"

backups=("$home_dir"/.dotfiles_backup-*)
[[ "${#backups[@]}" -eq 1 ]]

zsh -lic 'exit'

export XDG_DATA_HOME="$home_dir/.local/share/test-nvim"
export XDG_STATE_HOME="$home_dir/.local/state/test-nvim"
nvim --headless "+Lazy! sync" "+qa"
SSH_TTY=/tmp/dotfiles-ssh nvim --headless "+qa"
