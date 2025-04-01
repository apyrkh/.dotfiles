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

- `brew bundle` - installs packages from Brewfile

Useful commands:

- `brew bundle check --verbose` - checks dependencies
- `brew bundle dump` - generates Brewfile


## Zsh & Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install plugins
sudo git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
sudo git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
sudo git clone --depth=1 https://github.com/MichaelAquilina/zsh-you-should-use $ZSH_CUSTOM/plugins/you-should-use

# Apply changes
source ~/.zshrc

# Set Zsh as the default shell
chsh -s $(which zsh)
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
