# .dotfiles

## Dotfiles

> [!IMPORTANT]
> Make sure you have installed brew, zsh, wezterm, nvm, neovim

### Install Dotfiles

```bash
git clone https://github.com/apyrkh/.dotfiles ~/.dotfiles
./install.sh
```

## Brew

### Install Brew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```


## Zsh

### Install Zsh

```bash
brew install zsh
```

### Install Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# zsh zsh-autosuggestions
sudo git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# zsh-syntax-highlighting
sudo git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# zsh-you-should-use
sudo git clone --depth=1 https://github.com/MichaelAquilina/zsh-you-should-use $ZSH_CUSTOM/plugins/you-should-use

# eza - modern replacement for ls
brew install eza
# fortune - generating random quotes (used by the chucknorris plugin)
brew install fortune
# cowsay - a fun plugin to make your terminal output look like a talking cow
brew install cowsay

# reload .zshrc to apply changes
source ~/.zshrc

# make zsh your default shell
chsh -s $(which zsh)
```

## Wezterm

### Install Wezterm

```bash
brew install --cask wezterm
```


## Git

### Install Git

```bash
brew install git
```

### Add SSH-keys

```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
ssh-add ~/.ssh/id_rsa
```

### Setup Git User

```bash
cat <<EOF >> ~/.gitconfig_local
[user]
  name = <NAME>
  email = <EMAIL>
EOF
```


## NVM

### Install NVM

```bash
brew install nvm
```

### Install LTS Node

```bash
nvm install --lts
```


## Neovim

### Install Neovim

```bash
brew install neovim
```

### Install Neovim Dependencies

```bash
brew install font-jetbrains-mono-nerd-font   # For fonts
brew install luarocks                        # For Lua libraries
brew install ripgrep                         # For telescope (searching)
```

### Neovim Commands

- `:Lazy` - Open the Lazy.nvim plugin menu
- `:Mason` - Open the Mason.nvim plugin menu


## Other Tips

- `chmod +x FILENAME` - make file executable
