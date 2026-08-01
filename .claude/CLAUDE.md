# Dotfiles

Personal macOS development environment (primary target). `README-RHEL9.md` holds supplemental bootstrap notes for a secondary Linux machine. Philosophy: minimalism, terminal-centric, purpose-driven.

## Deployment

`install.sh` symlinks the files listed in its `files=()` array from `~/.dotfiles/home/` into `~/`, backing up any existing target first. That array is the source of truth for what's managed — don't duplicate it here.

## Structure

- `home/` — deploy root; everything under it mirrors `~/` and is what `install.sh` symlinks. The repo root (this file, `docs/`, `install.sh`, `README.md`) is repo meta, never deployed.
- `home/.config/nvim/lua/` — Neovim config; plugin specs live in `plugins/` by category (see below)
- `home/.config/zsh/scripts/` — shell utility scripts
- `home/.claude/` — global Claude Code config (`CLAUDE.md`, `statusline.js`, `skills/`), tracked **per-entry**, not as a whole directory — the rest of `~/.claude/` (settings.json, keybindings.json, hooks/, vendor skills) is machine state or third-party installs and stays untracked
- `docs/storage.md` — storage layout notes
- `docs/tldr/` — one short usage-notes file per installed CLI tool, linked from README's Docs section. `docs/tldr/README.md` is the entry point: it holds any routing table across multiple tldr files (e.g. "which tool for which task"), so both a human and Claude can find the right file without opening every one.

## Key Conventions

- **No machine-specific secrets in repo.** Git identity lives in `~/.gitconfig.local` (not tracked). Machine-specific Zsh overrides go in `~/.zshrc.local` (not tracked).
- **Nvim plugins** are organized in `lua/plugins/` by category: `ai`, `code`, `editor`, `files`, `navigation`, `ui`, `vcs`, `workflow`.
- **Brewfile** covers base tools. Personal/work splits use `Brewfile.personal` / `Brewfile.work` (not in repo). Organized into `# === category ===` section comments (terminal, dev tools, containers, fun/misc, etc.) — add new packages under the matching section rather than at the end.
- **README.md structure:** `## Setup` = sequential/mandatory bootstrap steps, one `### <bare noun>` subsection per step with its own code block. `## Dev Tools` = flat, optional, order-independent tools in a single code block with `#`-comment separators.
- **Claude Code skills** (`home/.claude/skills/`) must be routers, not the sole holder of a command or decision table. Real content belongs in `docs/tldr/`; a skill only points there. If deleting the skill would lose information a human needs, it's not a router.

## Style

- Minimal — no fluff, no redundant config
- Prefer clarity over cleverness in shell scripts
- Lua for Neovim config; keep plugin specs self-contained
