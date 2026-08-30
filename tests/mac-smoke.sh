#!/usr/bin/env bash
set -euo pipefail

dotfiles_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"

echo "== Syntax-checking all entrypoints =="
bash -n "$dotfiles_dir/install.sh" "$dotfiles_dir/install-work.sh" "$dotfiles_dir/install-home.sh" \
  "$dotfiles_dir"/scripts/*.sh

temporary_dir="$(mktemp -d)"
trap 'rm -rf "$temporary_dir"' EXIT
brew_log="$temporary_dir/brew.log"

mkdir -p "$temporary_dir/bin" "$temporary_dir/home"
cat > "$temporary_dir/bin/brew" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
printf '%s\n' "$*" >> "$BREW_LOG"
case "$1" in
  tap|install) ;;
  *) printf 'Unexpected brew command: %s\n' "$*" >&2; exit 1 ;;
esac
EOF
chmod +x "$temporary_dir/bin/brew"

# Pre-seed state so install-mac.sh's already-installed checks short-circuit
# instead of making real network calls (oh-my-zsh, its plugins, agy).
mkdir -p "$temporary_dir/home/.oh-my-zsh/custom/plugins/zsh-autosuggestions" \
  "$temporary_dir/home/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" \
  "$temporary_dir/home/.oh-my-zsh/custom/plugins/you-should-use"
printf '#!/usr/bin/env bash\nexit 0\n' > "$temporary_dir/bin/agy"
chmod +x "$temporary_dir/bin/agy"

echo "== Verifying install.sh dispatches to install-mac.sh and symlinks.sh =="
HOME="$temporary_dir/home" BREW_LOG="$brew_log" PATH="$temporary_dir/bin:$PATH" OSTYPE="darwin23" \
  "$dotfiles_dir/install.sh"

grep -Fq "install --cask font-jetbrains-mono-nerd-font" "$brew_log"
[[ -L "$temporary_dir/home/.config/nvim" ]]
[[ -L "$temporary_dir/home/.zshrc" ]]
[[ -L "$temporary_dir/home/.gitconfig" ]]

echo "mac-smoke: OK"
