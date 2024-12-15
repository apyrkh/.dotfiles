# RHEL 9

## Zsh

### Install Zsh

```bash
sudo dnf install zsh -y
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
sudo dnf install eza -y
# fortune - generating random quotes (used by the chucknorris plugin)
sudo dnf install fortune-mod -y
# cowsay - a fun plugin to make your terminal output look like a talking cow
sudo dnf install cowsay -y

# reload .zshrc to apply changes
source ~/.zshrc

# make zsh your default shell
chsh -s $(which zsh)
```

## Wezterm

### Install Wezterm

```bash
flatpak install flathub org.wezfurlong.wezterm
```

Run: `flatpak run org.wezfurlong.wezterm`
