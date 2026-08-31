# Read by every zsh (login, non-login, scripts) — VS Code terminals and docker
# exec need PATH too. `typeset -U` keeps $path from growing on nested shells.
typeset -U path PATH

if [[ -z "$HOMEBREW_PREFIX" ]]; then
  if command -v brew >/dev/null 2>&1; then
    eval "$(brew shellenv)"
  elif [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
fi

path=("$HOME/.bun/bin" "$HOME/.local/bin" "$HOME/.local/share/fnm" $path)

# libpq (psql, pg_dump) is keg-only, so add it to PATH by hand. Reuse
# $HOMEBREW_PREFIX — `brew --prefix libpq` would fork ~50ms on every shell.
if [[ -d "$HOMEBREW_PREFIX/opt/libpq/bin" ]]; then
  path=("$HOMEBREW_PREFIX/opt/libpq/bin" $path)
fi

# JetBrains Toolbox shell scripts (goland, webstorm) — only exist when Toolbox's
# "Shell scripts" option is on, so guard on the directory.
toolbox_scripts="$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
if [[ -d "$toolbox_scripts" ]]; then
  path+=("$toolbox_scripts")
fi
unset toolbox_scripts
