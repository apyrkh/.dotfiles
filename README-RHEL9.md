## wezterm

- `flatpak install flathub org.wezfurlong.wezterm`

> flatpak run org.wezfurlong.wezterm

## zsh

- `sudo dnf install zsh -y`
- `chsh -s $(which zsh)`

- `sudo dnf install eza -y`
- `sudo dnf install fortune-mod -y`
- `sudo dnf install cowsay -y`
- `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
- `sudo git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions`
- `sudo git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting`
- `sudo git clone --depth=1 https://github.com/MichaelAquilina/zsh-you-should-use $ZSH_CUSTOM/plugins/you-should-use`
- `source ~/.zshrc`
