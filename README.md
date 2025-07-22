# .dotfiles

## Overview

This repository contains my personal dotfiles for setting up a development environment.

## Clone and Install

> [!IMPORTANT]
> Make sure you have installed `git`.

```bash
git clone https://github.com/apyrkh/.dotfiles ~/.dotfiles

cd ~/.dotfiles
cat install.sh  # Review the script before running

./install.sh
```

## Install Brew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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
brew services start <package>  # Start a service (e.g. postgresql)
brew services stop <package>   # Stop a service
```
</details>

## Zsh & Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install plugins
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/MichaelAquilina/zsh-you-should-use ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use

# Apply changes
source ~/.zshrc

# Set Zsh as the default shell
chsh -s $(which zsh)
echo $SHELL
```

## Git Setup

### Add SSH keys

```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
ssh-add ~/.ssh/id_rsa
```

### Configure Git User

```bash
cat <<EOF >> ~/.gitconfig_local
[user]
  name = <NAME>
  email = <EMAIL>
EOF
```

## Install Node (LTS)

```bash
nvm install --lts
nvm alias default lts
```

## Tips

### Neovim Shortcuts

- `:Lazy` - Open the Lazy.nvim plugin menu
- `:Mason` - Open the Mason.nvim plugin menu

### Misc

- `chmod +x FILENAME` - make file executable
