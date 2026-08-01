# .dotfiles

> "More signal, less noise."

## Docs

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

### Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew bundle --file Brewfile
# brew bundle --file Brewfile.personal  # @TODO: not yet created
# brew bundle --file Brewfile.work      # @TODO: not yet created
```

<details>
    <summary>Brew Cheat Sheet</summary>

```sh
brew install <package>         # Install a package
brew upgrade                   # Upgrade all packages
brew upgrade <package>         # Upgrade a specific package

brew uninstall <package>       # Uninstall a package
brew cleanup                   # Remove outdated versions

brew bundle dump               # Generate a Brewfile from current system
brew bundle install            # Install everything from Brewfile
brew bundle check --verbose    # Check what is missing from Brewfile
brew bundle cleanup            # Show what would be removed (not in Brewfile)
brew bundle cleanup --force    # Remove all not listed in Brewfile

brew tap                       # List tapped repositories
brew tap <user/repo>           # Add (tap) a third-party repository
brew untap <user/repo>         # Remove (untap) a tapped repository

brew doctor                    # Check system for potential issues
brew config                    # Show Homebrew system configuration
brew outdated                  # List outdated packages
brew list                      # List installed formulae
brew list --cask               # List installed casks (GUI apps)
brew missing                   # List formulae with missing dependencies

brew services list             # Show background services managed by Homebrew
brew services start <service>  # Start a background service
brew services stop <service>   # Stop a service
```
</details>

### Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install plugins
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/MichaelAquilina/zsh-you-should-use ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use

# Apply changes
source ~/.zshrc

# Default shell
chsh -s $(which zsh)
echo $SHELL
```

### Claude Code

`install.sh` deploys `~/.claude/CLAUDE.md`, `statusline.js`, and the skills. The statusline needs one
manual step, because `~/.claude/settings.json` is machine-specific and not tracked:

```json
{ "statusLine": { "type": "command", "command": "node /Users/<USER>/.claude/statusline.js" } }
```

---

## Dev Tools

```bash
# Node (LTS)
nvm install --lts
nvm alias default lts

# Bun
curl -fsSL https://bun.sh/install | bash

# Claude Code
curl -fsSL https://claude.ai/install.sh | bash

# Serena Agent (per-project, run init in repos where you want it)
# https://oraios.github.io/serena
curl -LsSf https://astral.sh/uv/install.sh | sh
uv tool install -p 3.13 serena-agent  # 3.13: serena's minimum supported version
serena init

## maintenance
uv tool upgrade serena-agent
uv tool uninstall serena-agent

# peonping
# https://www.peonping.com
brew install PeonPing/tap/peon-ping
peon-ping-setup
peon trainer on

# battery
curl -s https://raw.githubusercontent.com/actuallymentor/battery/main/setup.sh | bash

battery maintain 70-80
battery maintain stop
```

---

## Misc

<!-- TODO: move to docs/ -->
- Make file executable: `chmod +x FILENAME`
