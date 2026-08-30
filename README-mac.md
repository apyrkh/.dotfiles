# macOS setup

## Profiles

The default bootstrap installs the development/work profile:

```bash
git clone https://github.com/apyrkh/.dotfiles ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

It installs Homebrew when needed (prompting for your password itself if required) and reconciles `Brewfile`. This profile contains development, Neovim, Git, terminal, container, and database tools. It does not install personal media tools, games, or consumer desktop applications.

`Brewfile` installs Bun. The bootstrap then runs `bun add --global @devcontainers/cli`, which provides the `devcontainer` command.

Add the personal home profile only on a home machine:

```bash
./install.sh --home
# short form
./install.sh -H
```

`--home` runs `Brewfile.home` after the work profile. It includes the Nerd Font and WezTerm, media utilities, recreational tools, games, and personal desktop applications. The tracked manifests do not include the local, untracked `Brewfile.work`.

Both commands are idempotent. Homebrew reconciles already-installed formulae and casks, and the linker leaves valid symlinks unchanged.

## Defaults and shell

The bootstrap intentionally does not write macOS `defaults`. Add a tracked and documented setting to `scripts/mac.sh` only when it is explicitly wanted.

The installer deploys `.zshrc` but does not change your login shell. Change it manually if needed:

```bash
chsh -s "$(command -v zsh)"
```

Put machine-specific shell settings in `~/.zshrc.local`. The shared profile detects Homebrew from Apple Silicon and Intel locations. Clipboard commands use `pbcopy`.

## Validation

The GitHub Actions macOS job uses a temporary home and a stubbed Homebrew command. It verifies macOS dispatch, the work/home manifest selection, and repeat-safe links without changing a developer machine or installing optional personal applications.
