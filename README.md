# .dotfiles

> "More signal, less noise."

Cross-platform personal development environment for macOS and Debian/Ubuntu.

## Setup

### Dotfiles

```bash
git clone https://github.com/apyrkh/.dotfiles ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

The default command installs the development/work profile and links the tracked configuration into your home directory. It is safe to run again: valid links and installed tools are kept, while conflicting files are backed up once in `~/.dotfiles_backup-<timestamp>`.

On a personal macOS computer, add the optional home profile:

```bash
./install.sh --home
# or
./install.sh -H
```

This installs the work profile plus personal media tools, games, and desktop apps from `Brewfile.home`. It is not supported on Linux.

To update only configuration links:

```bash
./install.sh --skip-packages
```

For isolated testing, set `DOTFILES_HOME` to a disposable target directory. `DOTFILES_DIR` can point to a repository checkout outside `~/.dotfiles`.

The installer provides the Dev Container CLI through Bun on both platforms.

### Git

Git identity remains local and untracked:

```bash
cat <<EOF >> ~/.gitconfig.local
[user]
  name = <NAME>
  email = <EMAIL>
EOF
```

## Platform guides

- [macOS](README-mac.md)
- [Debian/Ubuntu Linux](README-linux.md)
- [Storage layout](docs/storage.md)
- [tldr notes](docs/tldr/)

## Dev tools

```bash
claude  # /login on first run
copilot  # /login on first run
codex login
gh auth login

# Node (LTS)
fnm install --lts
fnm default lts-latest

# Bun
curl -fsSL https://bun.sh/install | bash

# Claude Code
curl -fsSL https://claude.ai/install.sh | bash
```
