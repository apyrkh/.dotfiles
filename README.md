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
│   ├── install-common.sh      # platform-independent: oh-my-zsh, claude, agy
│   └── symlinks.sh            # symlinks zsh, neovim, wezterm, git config into $HOME
└── home/                      # tracked dotfiles/config that get symlinked
```

| Script | Does |
| --- | --- |
| `./install.sh` | Detects OS (macOS / Ubuntu), runs `scripts/install-mac.sh` or `scripts/install-ubuntu.sh`, then `scripts/install-common.sh` and `scripts/symlinks.sh`. Any machine, incl. DevContainers/CI. |
| `./install-mac-work.sh` | `install.sh` + macOS work GUI apps & Docker/Colima. macOS only. |
| `./install-mac-home.sh` | `install-mac-work.sh` + personal media/gaming apps. macOS only. |

Each tier is a strict superset of the previous one — and `source`s the tier below it.

## Quick start

```bash
git clone https://github.com/apyrkh/.dotfiles ~/.dotfiles && cd ~/.dotfiles

./install.sh           # any machine: CLI tools + symlinks
./install-mac-work.sh  # macOS work laptop
./install-mac-home.sh  # macOS personal machine
```

All scripts use `set -euo pipefail` and are safe to re-run. `symlinks.sh`
backs up any conflicting file once to `~/.dotfiles_backup-<timestamp>`, and
removes symlinks for paths this repo no longer manages.

Linux support is scoped to Ubuntu — `install.sh` refuses to run on other
distributions rather than failing halfway through an `apt-get` call.

## First run

Everything below needs a human — logins, or a one-time setup command the
installer can't do for you.

```bash
claude          # /login on first run
copilot         # /login on first run
codex login
gh auth login

peon-ping-setup           # https://www.peonping.com
peon trainer on

battery maintain 70-80    # keep the charge in a band
battery maintain stop
```

In JetBrains Toolbox, enable **Shell scripts** to get `goland` / `webstorm` on
`PATH` — `.zshenv` picks the directory up automatically once it exists.

## Git

```bash
ssh-keygen -t ed25519 -C "your_email@example.com" -f ~/.ssh/id_ed25519_personal
ssh-add ~/.ssh/id_ed25519_personal

# legacy RSA key (if needed)
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
ssh-add ~/.ssh/id_rsa
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

## Homebrew

<details>
    <summary>Brew Cheat Sheet</summary>

```sh
brew install <package>         # Install a package
brew upgrade                   # Upgrade all packages
brew upgrade <package>         # Upgrade a specific package

brew uninstall <package>       # Uninstall a package
brew cleanup                   # Remove outdated versions

brew tap                       # List tapped repositories
brew tap <user/repo>           # Add (tap) a third-party repository
brew untap <user/repo>         # Remove (untap) a tapped repository

brew doctor                    # Check system for potential issues
brew config                    # Show Homebrew system configuration
brew outdated                  # List outdated packages
brew list                      # List installed formulae
brew list --cask               # List installed casks (GUI apps)
brew leaves --installed-on-request  # Top-level packages you asked for
brew missing                   # List formulae with missing dependencies
brew uses --installed <pkg>    # What depends on a package

brew services list             # Show background services managed by Homebrew
brew services start <service>  # Start a background service
brew services stop <service>   # Stop a service
```
</details>

## Dev Container

```bash
devcontainer up                             # build & start (uses cwd)
devcontainer up --remove-existing-container  # force a clean create
devcontainer exec zsh                       # shell into the running container
devcontainer build --no-cache               # rebuild image after editing the Dockerfile

docker ps --filter "label=devcontainer.local_folder"  # find the container
docker rm -f <container-id>                            # stop & remove it
```

## Docs

- [Storage layout](docs/storage.md)
- [tldr notes](docs/tldr/) — quick usage examples for installed CLI tools

## Misc

- Make file executable: `chmod +x FILENAME`
