#!/usr/bin/env bash
set -euo pipefail

dotfiles_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
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

"$dotfiles_dir/install.sh"

# Standalone installers (bun/uv/fnm/agy) put binaries outside a fresh shell's
# default PATH; a real login shell picks this up via .zshenv, but this smoke
# test runs in plain bash, so export it explicitly before checking commands.
export PATH="$home_dir/.bun/bin:$home_dir/.local/bin:$home_dir/.local/share/fnm:$PATH"

for command in bash bun curl eza fd fdfind fzf gcc gh git go lazygit nvim rg tree-sitter uv zoxide zsh; do
  assert_command "$command"
done

[[ -x "$home_dir/.local/share/fnm/fnm" ]] || command -v fnm >/dev/null 2>&1
[[ -d "$home_dir/.oh-my-zsh" ]]
[[ -d "$home_dir/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]]
[[ -d "$home_dir/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]]
[[ -d "$home_dir/.oh-my-zsh/custom/plugins/you-should-use" ]]

assert_link "$dotfiles_dir/home/.config/nvim" "$home_dir/.config/nvim"
assert_link "$dotfiles_dir/home/.zshenv" "$home_dir/.zshenv"
assert_link "$dotfiles_dir/home/.zshrc" "$home_dir/.zshrc"
assert_link "$dotfiles_dir/home/.vimrc" "$home_dir/.vimrc"
assert_link "$dotfiles_dir/home/.gitconfig" "$home_dir/.gitconfig"

backups=("$home_dir"/.dotfiles_backup-*)
[[ "${#backups[@]}" -eq 1 ]]
[[ -f "${backups[0]}/.vimrc" ]]
[[ "$(cat "${backups[0]}/.vimrc")" == "existing vim configuration" ]]

# Rerunning is safe: no duplicate backups, links stay put.
"$dotfiles_dir/install.sh"
backups=("$home_dir"/.dotfiles_backup-*)
[[ "${#backups[@]}" -eq 1 ]]

echo "linux-smoke: OK"
