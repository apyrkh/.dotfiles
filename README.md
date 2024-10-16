# .dotfiles

- `git clone https://github.com/apyrkh/.dotfiles ~/.dotfiles`
- `./install.sh`

## brew

- `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

## git

- `brew install git`
- `brew install nvm`

Setup: `.gitconfig_local`
```shell
cat <<EOF >> ~/.gitconfig_local
[user]
  name = <NAME>
  email = <EMAIL>
EOF
```

## wezterm

- `brew install --cask wezterm`

## zsh

- `brew install eza` // a modern, maintained replacement for ls
- `brew install fortune` // for chucknorris plugin
- `brew install cowsay` // for chucknorris plugin
- `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
- `sudo git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions`
- `sudo git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting`
- `sudo git clone --depth=1 https://github.com/MichaelAquilina/zsh-you-should-use $ZSH_CUSTOM/plugins/you-should-use`
- `source ~/.zshrc`

## neovim

Neovim config is inspired by:
- LazyVim
  - https://github.com/LazyVim/LazyVim
- Josean Martinez
  - https://youtu.be/NL8D8EkphUw

- `brew install neovim`

Dependecies:
- `brew install font-jetbrains-mono-nerd-font`
- `brew install luarocks`
- `brew install ripgrep` (telescope)

Commands:
- `:Lazy` - lazy.nvim menu
- `:Mason` - mason.nvim menu

Plugins:
- https://dotfyle.com

## other tips

- `chmod +x FILENAME` - make file executable
