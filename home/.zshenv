if command -v brew >/dev/null 2>&1; then
  eval "$(brew shellenv)"
elif [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Read by every shell (login, interactive, and scripts), unlike .zprofile which
# only runs for login shells — non-login shells (VS Code terminals, docker exec,
# CI) need these tools on PATH too.
path=("$HOME/.bun/bin" "$HOME/.local/bin" "$HOME/.local/share/fnm" $path)

# libpq (psql, pg_dump, ...) is keg-only in Homebrew — never symlinked into
# the main prefix because it conflicts with the full postgresql formula.
if command -v brew >/dev/null 2>&1; then
  path=("$(brew --prefix libpq 2>/dev/null)/bin" $path)
fi
