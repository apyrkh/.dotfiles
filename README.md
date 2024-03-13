# .dotfiles

- `git clone https://github.com/apyrkh/.dotfiles ~/.dotfiles`
- `./install.sh`

## brew

- `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

## git

- `brew install git`

Setup: `.gitconfig_local`
```shell
cat <<EOF >> ~/.gitconfig_local
[user]
  name = <NAME>
  email = <EMAIL>
EOF
```

## oh my zsh

- `brew install eza` // a modern, maintained replacement for ls
- `brew install fortune` // for chucknorris plugin
- `brew install cowsay` // for chucknorris plugin
- `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
- `sudo git --depth=1 clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions`
- `sudo git --depth=1 clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting`
- `sudo git --depth=1 clone https://github.com/MichaelAquilina/zsh-you-should-use $ZSH_CUSTOM/plugins/you-should-use`
- `source ~/.zshrc`

- `brew tap homebrew/cask-fonts`
- `brew install font-jetbrains-mono-nerd-font`
- settings > profiles > text > font

## nvm

- `brew install nvm`
