# .dotfiles

> "More signal, less noise."

Cross-platform personal development environment for macOS and Ubuntu.

## Docs

- [macOS setup](README-mac.md)
- [Ubuntu Linux setup](README-linux.md)
- [Storage layout](docs/storage.md)
- [tldr notes](docs/tldr/) — quick usage examples for installed CLI tools/packages

---

## Setup

### Dotfiles

> [!IMPORTANT]
> Make sure you have installed `git`.

```bash
git clone https://github.com/apyrkh/.dotfiles ~/.dotfiles

cd ~/.dotfiles
cat install.sh  # Review the script before running

./install.sh
```

The installer detects macOS or Ubuntu and installs the matching profile — see the platform guide above for what each one installs. Re-running is safe: valid links and installed tools are kept, while conflicting files are backed up once in `~/.dotfiles_backup-<timestamp>`.

```bash
./install.sh --home       # macOS only: add the personal home profile (Brewfile.home)
./install.sh --skip-packages  # only update configuration links
```

```bash
# isolated testing: install into a throwaway home instead of $HOME
DOTFILES_HOME=/tmp/dotfiles-test ./install.sh
```

### Git

```bash
ssh-keygen -t ed25519 -C "your_email@example.com" -f ~/.ssh/id_ed25519_personal
ssh-add ~/.ssh/id_ed25519_personal

# legacy RSA key (if needed)
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
ssh-add ~/.ssh/id_rsa
```

```bash
cat <<EOF >> ~/.gitconfig.local
[user]
  name = <NAME>
  email = <EMAIL>
EOF
```

### Claude Code

`install.sh` deploys `~/.claude/CLAUDE.md`, `statusline.js`, tracked agents, and tracked skills.

The statusline needs one manual step, because `~/.claude/settings.json` is machine-specific and not tracked:

```json
{ "statusLine": { "type": "command", "command": "node /Users/<USER>/.claude/statusline.js" } }
```

MCP servers (`~/.claude.json`) aren't tracked either — add manually:

```bash
claude mcp add --transport http --scope user context7 https://mcp.context7.com/mcp
```

---

## Dev Tools

```bash
claude  # /login on first run
copilot  # /login on first run
codex login
gh auth login

# Node (LTS) — already installed by install.sh on Linux; on macOS run manually
fnm install --lts
fnm default lts-latest

# Serena Agent — install.sh installs it on Linux; on macOS run manually
# https://oraios.github.io/serena
uv tool install -p 3.13 serena-agent  # 3.13: serena's minimum supported version

# per-project, run init in each repo where you want it
serena init

## maintenance
uv tool upgrade serena-agent
uv tool uninstall serena-agent

# peonping (macOS only)
# https://www.peonping.com
brew install PeonPing/tap/peon-ping
peon-ping-setup
peon trainer on

# battery (macOS only)
curl -s https://raw.githubusercontent.com/actuallymentor/battery/main/setup.sh | bash

battery maintain 70-80
battery maintain stop
```

---

## Misc

<!-- TODO: move to docs/ -->
- Make file executable: `chmod +x FILENAME`
