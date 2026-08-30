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
zshrc_checksum="$(sha256sum "$dotfiles_dir/home/.zshrc" | cut -d ' ' -f 1)"

DOTFILES_HOME="$home_dir" "$dotfiles_dir/install.sh"

export PATH="$home_dir/.bun/bin:$home_dir/.local/bin:$PATH"

for command in bun codex copilot curl devcontainer fd fdfind fzf gcc gh git \
  lazygit make node nvim rg tree-sitter unzip zsh; do
  assert_command "$command"
done

node --version
tree-sitter --version
[[ -x "$home_dir/.local/bin/eza" ]]
[[ -x "$home_dir/.local/bin/fx" ]]
[[ -x "$home_dir/.local/share/fnm/fnm" ]]
[[ -d "$home_dir/.oh-my-zsh" ]]
[[ -d "$home_dir/.oh-my-zsh/custom/plugins/zsh-autosuggestions/.git" ]]
[[ -d "$home_dir/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/.git" ]]
[[ -d "$home_dir/.oh-my-zsh/custom/plugins/you-should-use/.git" ]]
locale -a | grep -qi '^en_US.utf8$'

assert_link "$dotfiles_dir/home/.config/nvim" "$home_dir/.config/nvim"
assert_link "$dotfiles_dir/home/.zshenv" "$home_dir/.zshenv"
assert_link "$dotfiles_dir/home/.zshrc" "$home_dir/.zshrc"
assert_link "$dotfiles_dir/home/.vimrc" "$home_dir/.vimrc"

backups=("$home_dir"/.dotfiles_backup-*)
[[ "${#backups[@]}" -eq 1 ]]
[[ -f "${backups[0]}/.vimrc" ]]
[[ "$(cat "${backups[0]}/.vimrc")" == "existing vim configuration" ]]
[[ "$(sha256sum "$dotfiles_dir/home/.zshrc" | cut -d ' ' -f 1)" == "$zshrc_checksum" ]]

DOTFILES_HOME="$home_dir" "$dotfiles_dir/install.sh"

backups=("$home_dir"/.dotfiles_backup-*)
[[ "${#backups[@]}" -eq 1 ]]
[[ "$(sha256sum "$dotfiles_dir/home/.zshrc" | cut -d ' ' -f 1)" == "$zshrc_checksum" ]]

# A rerun after Neovim already has a newer /opt install must not fail (link_managed
# repoints the version-suffixed dir instead of refusing like link_if_absent does).
DOTFILES_HOME="$home_dir" "$dotfiles_dir/install.sh"

# Tools installed by the linker's PATH additions must resolve outside a login
# shell too (e.g. VS Code terminals, `docker exec`, CI) — not just `zsh -l`.
# Strip the PATH this script already exported so the check actually exercises
# .zshenv instead of just inheriting a working PATH from the parent shell.
env -i HOME="$home_dir" TERM=xterm zsh -c 'command -v nvim' >/dev/null
env -i HOME="$home_dir" TERM=xterm zsh -c 'command -v eza' >/dev/null
zsh -lic 'exit'

export XDG_DATA_HOME="$home_dir/.local/share/test-nvim"
export XDG_STATE_HOME="$home_dir/.local/state/test-nvim"

nvim --headless "+Lazy! sync" "+qa"

# The nvim-treesitter plugin spec triggers its own parser install on startup
# (lazy = false) as part of "+Lazy! sync", but that install runs asynchronously
# and Lazy prints its errors without a nonzero exit code — this is what
# silently broke Treesitter before. Poll for the parsers actually landing
# instead of trusting the exit code, and don't kick off a second concurrent
# install (racing the plugin's own would itself error).
ts_check_file="$home_dir/.treesitter-check"
nvim --headless -c "lua
  local wanted = { 'bash', 'lua', 'typescript', 'markdown' }
  local ok = vim.wait(120000, function()
    local installed = require('nvim-treesitter.config').get_installed('parsers')
    for _, lang in ipairs(wanted) do
      if not vim.tbl_contains(installed, lang) then
        return false
      end
    end
    return true
  end, 200)
  local file = io.open('$ts_check_file', 'w')
  file:write(ok and 'ok' or 'timeout')
  file:close()
" -c "qa" 2>&1

[[ "$(cat "$ts_check_file")" == "ok" ]] ||
  { printf 'Treesitter parser install did not finish in time\n' >&2; exit 1; }

for parser in bash lua typescript markdown; do
  [[ -f "$XDG_DATA_HOME/nvim/site/parser/$parser.so" ]] ||
    { printf 'Expected compiled Treesitter parser: %s\n' "$parser" >&2; exit 1; }
done

SSH_TTY=/tmp/dotfiles-ssh nvim --headless "+qa"
