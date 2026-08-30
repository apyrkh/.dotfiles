# .dotfiles

> "More signal, less noise."

Cross-platform personal dev environment for macOS and Ubuntu/DevContainers.
Flat, 3-tier pipeline: **root entrypoints -> `scripts/` -> symlinks**. No
frameworks, no Brewfile — every script is plain `bash` you can read top to
bottom.

## Architecture

```text
.
├── install.sh                 # Tier 1: base CLI layer (any machine)
├── install-mac-work.sh        # Tier 2: install.sh + macOS work GUI apps & Docker
├── install-mac-home.sh        # Tier 3: install-mac-work.sh + personal media/gaming apps
├── scripts/
│   ├── install-mac.sh         # brew install: CLI tools & runtimes
│   ├── install-ubuntu.sh      # apt-get + curl installers (DevContainers/Ubuntu)
│   └── symlinks.sh            # symlinks zsh, neovim, wezterm, git config into $HOME
└── home/                      # tracked dotfiles/config that get symlinked
```

| Script | Does |
| --- | --- |
| `./install.sh` | Detects OS (`Darwin`/`Linux`), runs `scripts/install-mac.sh` or `scripts/install-ubuntu.sh`, then `scripts/symlinks.sh`. Any machine, incl. DevContainers/CI. |
| `./install-mac-work.sh` | `install.sh` + macOS work GUI apps & Docker/Colima. macOS only. |
| `./install-mac-home.sh` | `install-mac-work.sh` + personal media/gaming apps. macOS only. |

Each tier is a strict superset of the previous one. See **`TOOLS.md`** for the
full package list per tier.

## Quick start

```bash
git clone https://github.com/apyrkh/.dotfiles ~/.dotfiles && cd ~/.dotfiles

./install.sh           # any machine: CLI tools + symlinks
./install-mac-work.sh  # macOS work laptop
./install-mac-home.sh  # macOS personal machine
```

All scripts use `set -euo pipefail` and are safe to re-run. `symlinks.sh`
backs up any conflicting file once to `~/.dotfiles_backup-<timestamp>`.

## Git

```bash
ssh-keygen -t ed25519 -C "your_email@example.com" -f ~/.ssh/id_ed25519_personal
ssh-add ~/.ssh/id_ed25519_personal
```

```gitconfig
# ~/.gitconfig.local (untracked)
[user]
  name = <NAME>
  email = <EMAIL>
```

## Claude Code

`symlinks.sh` deploys `~/.claude/CLAUDE.md`, `statusline.js`, and tracked
skills. Two things stay machine-specific and untracked:

```json
// ~/.claude/settings.json
{ "statusLine": { "type": "command", "command": "node /Users/<USER>/.claude/statusline.js" } }
```

```bash
# ~/.claude.json (MCP servers)
claude mcp add --transport http --scope user context7 https://mcp.context7.com/mcp
```

## Dev Container

```bash
devcontainer up --workspace-folder .
```

`postCreateCommand` runs `install.sh` -> `scripts/install-ubuntu.sh` +
`scripts/symlinks.sh` inside the container.
