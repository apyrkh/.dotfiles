# Read by every zsh (login, non-login, scripts) — VS Code terminals and docker
# exec need PATH too. `typeset -U` keeps $path from growing on nested shells.
#
# Skip the system rc files (/etc/zprofile, /etc/zshrc). /etc/zprofile runs
# `path_helper`, which rebuilds $PATH *after* this file and pushes
# /opt/homebrew/bin behind /usr/bin — so `python3` would resolve to the macOS
# 3.9 instead of Homebrew's. With the system files skipped, this file is the
# single source of truth for PATH in every shell type.
unsetopt GLOBAL_RCS

# /etc/zprofile also set a LANG fallback; keep one for non-interactive shells.
export LANG=${LANG:-en_US.UTF-8}

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

# path_helper (skipped via GLOBAL_RCS) normally seeds these from /etc/paths, and
# `brew shellenv` runs its own path_helper that can drop them when PATH starts
# empty. Append as a fallback so shells with no inherited PATH (env -i, minimal
# CI) still find core tools; `typeset -U` keeps any existing copy in place.
path+=(/usr/local/bin /usr/bin /bin /usr/sbin /sbin)

export BUN_INSTALL="$HOME/.bun"
path=("$BUN_INSTALL/bin" "$HOME/.local/bin" "$HOME/.local/share/fnm" $path)

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
