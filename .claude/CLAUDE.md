# Dotfiles

Personal macOS and Ubuntu development environment. macOS is the primary local target; Ubuntu supports Dev Containers and headless remote environments. Philosophy: minimalism, terminal-centric, purpose-driven.

## Deployment

`install.sh` is the single bootstrap entrypoint. It detects macOS or Ubuntu, links the files listed in `scripts/link.sh` from `home/` into the target home, then installs the selected platform tools. The `files=()` array in `scripts/link.sh` is the source of truth for managed paths — don't duplicate it here.

## Structure

- `home/` — deploy root; everything under it mirrors `~/` and is what `install.sh` symlinks. The repo root (this file, `docs/`, `install.sh`, `README.md`) is repo meta, never deployed.
- `home/.config/nvim/lua/` — Neovim config; plugin specs live in `plugins/` by category (see below)
- `home/.config/zsh/scripts/` — shell utility scripts
- `home/.claude/` — global Claude Code config (`CLAUDE.md`, `statusline.js`, tracked `agents/`, tracked `skills/`), tracked **per-entry**, not as a whole directory — the rest of `~/.claude/` (settings.json, keybindings.json, hooks/, vendor agents/skills) is machine state or third-party installs and stays untracked
- `scripts/` — shared installer helpers, idempotent linking, and macOS/Ubuntu provisioning
- `.devcontainer/` and `tests/` — disposable Dev Container and bootstrap smoke tests; never test provisioning against the local home
- `docs/storage.md` — storage layout notes
- `docs/tldr/` — one short usage-notes file per installed CLI tool, linked from README's Docs section. `docs/tldr/README.md` is the entry point: it holds any routing table across multiple tldr files (e.g. "which tool for which task"), so both a human and Claude can find the right file without opening every one.

## Key Conventions

- **No machine-specific secrets in repo.** Git identity lives in `~/.gitconfig.local` (not tracked). Machine-specific Zsh overrides go in `~/.zshrc.local` (not tracked).
- **Nvim plugins** are organized in `lua/plugins/` by category: `ai`, `code`, `editor`, `files`, `navigation`, `ui`, `vcs`, `workflow`.
- **Neovim-only tooling** (LSP servers, `conform.nvim` formatters like `prettierd`/`eslint_d`/`pgformatter`) is installed by Mason from inside `home/.config/nvim/lua/plugins/code.lua`, not by `Brewfile`/`scripts/linux.sh` — it's cross-platform already and shouldn't be duplicated per-OS. `mason-tool-installer`'s own `VimEnter` auto-install races the plugin's own lazy-load, so `code.lua` calls `check_install()` itself right after `setup()`.
- **Profiles:** `Brewfile` is the default development/work manifest (macOS) — this is the "machine" tier: `scripts/linux.sh` (Ubuntu/Dev Container) tools plus local-machine extras (containers, database server, other-language toolchains). `Brewfile.home` holds optional home-only media, recreational, and personal desktop tools; install it with `./install.sh --home` or `-H`. The local `Brewfile.work` is untracked and must stay untouched. Keep manifests organized with `# === category ===` comments.
- **README.md structure:** `## Setup` = sequential/mandatory bootstrap steps, one `### <bare noun>` subsection per step with its own code block. `## Dev Tools` = flat, optional, order-independent tools in a single code block with `#`-comment separators.
- **Claude Code agents and skills** are tracked per entry under `home/.claude/agents/` and `home/.claude/skills/`; add each new entry to `install.sh`.
- **Claude Code skills** (`home/.claude/skills/`) must be routers, not the sole holder of a command or decision table. Real content belongs in `docs/tldr/`; a skill only points there. If deleting the skill would lose information a human needs, it's not a router.

## Style

- Minimal — no fluff, no redundant config
- Prefer clarity over cleverness in shell scripts
- Lua for Neovim config; keep plugin specs self-contained
