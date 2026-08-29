#!/usr/bin/env bash
set -euo pipefail

dotfiles_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
temporary_dir="$(mktemp -d)"
trap 'rm -rf "$temporary_dir"' EXIT
brew_log="$temporary_dir/brew.log"
bun_log="$temporary_dir/bun.log"

mkdir -p "$temporary_dir/bin" "$temporary_dir/home"
cat > "$temporary_dir/bin/brew" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

case "$1" in
  shellenv)
    exit 0
    ;;
  bundle)
    printf '%s\n' "$*" >> "$BREW_LOG"
    ;;
  *)
    printf 'Unexpected brew command: %s\n' "$*" >&2
    exit 1
    ;;
esac
EOF
chmod +x "$temporary_dir/bin/brew"

cat > "$temporary_dir/bin/bun" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

if [[ "$1" != "add" || "$2" != "--global" || "$3" != "@devcontainers/cli" ]]; then
  printf 'Unexpected bun command: %s\n' "$*" >&2
  exit 1
fi

mkdir -p "$BUN_INSTALL/bin"
touch "$BUN_INSTALL/bin/devcontainer"
chmod +x "$BUN_INSTALL/bin/devcontainer"
printf '%s\n' "$*" >> "$BUN_LOG"
EOF
chmod +x "$temporary_dir/bin/bun"

BREW_LOG="$brew_log" BUN_LOG="$bun_log" PATH="$temporary_dir/bin:$PATH" DOTFILES_HOME="$temporary_dir/home" \
  "$dotfiles_dir/install.sh"

grep -Fx "bundle --file $dotfiles_dir/Brewfile" "$brew_log"
grep -Fx "add --global @devcontainers/cli" "$bun_log"
if grep -Fq "Brewfile.home" "$brew_log"; then
  echo "Home profile ran without --home" >&2
  exit 1
fi

BREW_LOG="$brew_log" BUN_LOG="$bun_log" PATH="$temporary_dir/bin:$PATH" DOTFILES_HOME="$temporary_dir/home" \
  "$dotfiles_dir/install.sh" -H

grep -Fx "bundle --file $dotfiles_dir/Brewfile.home" "$brew_log"

BREW_LOG="$brew_log" BUN_LOG="$bun_log" PATH="$temporary_dir/bin:$PATH" DOTFILES_HOME="$temporary_dir/home" \
  "$dotfiles_dir/install.sh" --home

[[ "$(grep -Fxc "bundle --file $dotfiles_dir/Brewfile.home" "$brew_log")" -eq 2 ]]
[[ "$(grep -Fxc "add --global @devcontainers/cli" "$bun_log")" -eq 1 ]]
