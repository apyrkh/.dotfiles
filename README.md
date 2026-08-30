# .dotfiles

> "More signal, less noise."

Cross-platform personal development environment for macOS and Ubuntu/DevContainers,
built as a flat, 3-tier installation pipeline: **root entrypoints -> `scripts/` ->
symlinks**. No frameworks, no Brewfile, no hidden abstractions — every script is a
plain, readable `bash` file you can open and read top to bottom.

## Architecture

```text
.
├── install.sh          # Tier 1: base CLI layer (any machine)
├── install-work.sh     # Tier 2: install.sh + macOS work GUI apps & Docker
├── install-home.sh     # Tier 3: install-work.sh + personal media/gaming apps
├── scripts/
│   ├── install-mac.sh    # brew install: CLI tools & runtimes
│   ├── install-linux.sh  # apt-get + curl installers (DevContainers/Ubuntu)
│   └── symlinks.sh       # symlinks zsh, neovim, wezterm, git config into $HOME
└── home/                # tracked dotfiles/config that get symlinked
```

### Entrypoints

| Script | What it does |
| --- | --- |
| `./install.sh` | Detects the OS (`darwin` vs `linux-gnu`), runs `scripts/install-mac.sh` or `scripts/install-linux.sh`, then `scripts/symlinks.sh`. Use this on any machine, including DevContainers/CI. |
| `./install-work.sh` | Runs `./install.sh`, then installs macOS work GUI apps (JetBrains Toolbox, Chrome, KeePassXC, etc.) and Docker/Colima via `brew install`. macOS only. |
| `./install-home.sh` | Runs `./install-work.sh`, then installs personal media/gaming apps (Steam, Discord, iINA, ffmpeg, etc.) via `brew install`. macOS only. |

Each tier is a strict superset of the previous one — pick the one matching the
machine you're setting up.

```bash
git clone https://github.com/apyrkh/.dotfiles ~/.dotfiles
cd ~/.dotfiles
cat install.sh  # review before running

./install.sh          # any machine: CLI tools + symlinks
./install-work.sh      # macOS work laptop
./install-home.sh      # macOS personal machine
```

All scripts use `set -euo pipefail` and are safe to re-run: `brew install` and
`apt-get install` are idempotent, and `scripts/symlinks.sh` backs up any
conflicting file once to `~/.dotfiles_backup-<timestamp>` before linking.

## What gets installed

- **`scripts/install-mac.sh`** — Homebrew formulae/casks for shell (zsh, Oh My
  Zsh + plugins), dev tools (cmake, go, fnm, bun, uv, libpq, sqlite3), Neovim
  runtime deps (neovim, tree-sitter-cli, luarocks, fzf, fd, ripgrep), AI CLIs
  (claude, copilot-cli, codex, agy), and general CLI tools (git, gh, lazygit,
  tree, eza, zoxide, fx).
- **`scripts/install-linux.sh`** — non-interactive `apt-get` install of the
  base toolchain (build-essential, git, gh, zsh, ripgrep, fd-find, fzf, neovim,
  cmake, luarocks, tree, sqlite3, postgresql-client, xclip), followed by
  `curl`-based installers for `fnm`, `bun`, `uv`, and `agy`. Intended for
  DevContainers and headless Ubuntu hosts.
- **`scripts/symlinks.sh`** — symlinks tracked config from `home/` into
  `$HOME`: `.zshrc`/`.zshenv`/`.zprofile`/`.config/zsh` (shell),
  `.config/nvim`/`.vimrc` (Neovim, including its LSP/clipboard setup),
  `.config/wezterm`, `.gitconfig`, and the tracked Claude Code assets.

See `TOOLS.md` for the full, categorized package list this repo installs.

## Git

```bash
ssh-keygen -t ed25519 -C "your_email@example.com" -f ~/.ssh/id_ed25519_personal
ssh-add ~/.ssh/id_ed25519_personal

cat <<EOF >> ~/.gitconfig.local
[user]
  name = <NAME>
  email = <EMAIL>
EOF
```

## Claude Code

`scripts/symlinks.sh` deploys `~/.claude/CLAUDE.md`, `statusline.js`, and
tracked skills. Two things stay machine-specific and untracked — add them
manually:

```json
// ~/.claude/settings.json
{ "statusLine": { "type": "command", "command": "node /Users/<USER>/.claude/statusline.js" } }
```

```bash
# ~/.claude.json (MCP servers)
claude mcp add --transport http --scope user context7 https://mcp.context7.com/mcp
```

## Dev Container

Open the repo with `.devcontainer/devcontainer.json`; its `postCreateCommand`
runs `install.sh`, which resolves to `scripts/install-linux.sh` +
`scripts/symlinks.sh` inside the container.

```bash
devcontainer up --workspace-folder .
```

## Corporate Work Setup (Manual Checklist)

The base pipeline intentionally does **not** touch corporate-managed
software, VPN/MDM enrollment, or anything requiring a signed EULA or license
key. Handle these manually on a work laptop, in this order:

1. **Enroll the device** in corporate MDM per your onboarding email (installs
   compliance/EDR agents outside this repo's control).
2. **VPN client** — install and configure per your project's IT instructions
   (typically Cisco AnyConnect or GlobalProtect).
3. **Corporate SSH/Git identity** — generate a separate key and add it to your
   corporate Git host:
   ```bash
   ssh-keygen -t ed25519 -C "your.name@epam.com" -f ~/.ssh/id_ed25519_work
   ssh-add ~/.ssh/id_ed25519_work
   ```
   Scope it with a `~/.ssh/config` `Host` block and a matching
   `~/.gitconfig.local` `[user]` override (see the Git section above) so work
   commits never use your personal identity.
4. **Run the base pipeline** for local tooling:
   ```bash
   ./install.sh           # CLI tools + symlinks
   ./install-work.sh      # + GUI apps + Docker/Colima
   ```
5. **JetBrains Toolbox** (installed by `install-work.sh`) — sign in with your
   corporate JetBrains license/SSO.
6. **Docker/Colima** — start the runtime once and confirm `docker info` works
   before pulling any project images:
   ```bash
   colima start
   docker info
   ```
7. **Corporate npm/Maven/PyPI registries** — configure `.npmrc`, `settings.xml`,
   or `pip.conf` with your project's private registry credentials (not
   tracked by this repo; keep them in `~/.npmrc.local`-style files or a
   password manager).
8. **1Password/KeePassXC** — install and unlock your corporate vault before
   pulling any secrets referenced by project tooling.
9. **Slack/Teams and email profiles** — install and sign in per corporate IT
   instructions; not part of this repo's scope.

None of the above is scripted on purpose: corporate environments vary by
project/client, change frequently, and often require interactive SSO/2FA that
doesn't belong in an unattended installer.
