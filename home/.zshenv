# Read by every zsh (login, interactive, and scripts), unlike .zprofile which
# only runs for login shells — non-login shells (VS Code terminals, docker
# exec, CI) need these tools on PATH too. Because it runs in nested shells as
# well, keep $path unique so repeated sourcing can't grow it.
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

# libpq (psql, pg_dump, ...) is keg-only in Homebrew — never symlinked into
# the main prefix because it conflicts with the full postgresql formula.
# Use $HOMEBREW_PREFIX from shellenv above: `brew --prefix libpq` would fork a
# ~50ms subprocess on every single shell start, scripts included.
if [[ -d "$HOMEBREW_PREFIX/opt/libpq/bin" ]]; then
  path=("$HOMEBREW_PREFIX/opt/libpq/bin" $path)
fi
