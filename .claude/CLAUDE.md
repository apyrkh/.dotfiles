# Dotfiles

Personal macOS development environment (primary target). `README-RHEL9.md` holds supplemental bootstrap notes for a secondary Linux machine. Philosophy: minimalism, terminal-centric, purpose-driven.

## Deployment

`install.sh` symlinks the files listed in its `files=()` array from `~/.dotfiles/` into `~/`, backing up any existing target first. That array is the source of truth for what's managed — don't duplicate it here.

## Structure

- `.config/nvim/lua/` — Neovim config; plugin specs live in `plugins/` by category (see below)
- `.config/zsh/scripts/` — shell utility scripts
- `docs/storage.md` — storage layout notes
- `docs/tldr/` — one short usage-notes file per installed CLI tool, linked from README's Docs section

## Key Conventions

- **No machine-specific secrets in repo.** Git identity lives in `~/.gitconfig.local` (not tracked). Machine-specific Zsh overrides go in `~/.zshrc.local` (not tracked).
- **Nvim plugins** are organized in `lua/plugins/` by category: `ai`, `code`, `editor`, `files`, `navigation`, `ui`, `vcs`, `workflow`.
- **Brewfile** covers base tools. Personal/work splits use `Brewfile.personal` / `Brewfile.work` (not in repo). Organized into `# === category ===` section comments (terminal, dev tools, containers, fun/misc, etc.) — add new packages under the matching section rather than at the end.
- **`docs/tldr/`** holds one short usage-notes file per installed CLI tool, linked from README's Docs section.
- **README.md structure:** `## Setup` = sequential/mandatory bootstrap steps, one `### <bare noun>` subsection per step with its own code block. `## Dev Tools` = flat, optional, order-independent tools in a single code block with `#`-comment separators.

## Style

- Minimal — no fluff, no redundant config
- Prefer clarity over cleverness in shell scripts
- Lua for Neovim config; keep plugin specs self-contained
