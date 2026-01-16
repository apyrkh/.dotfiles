# === LOCALE ===
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# === OH MY ZSH CORE ===
export ZSH="$HOME/.oh-my-zsh"

# Themes https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="half-life" # current
# ZSH_THEME="robbyrussell" # default

# === PLUGINS ===
# Manually installed plugins in $ZSH_CUSTOM/plugins:
# - zsh-autosuggestions
# - zsh-syntax-highlighting
# - you-should-use
plugins=(
  chucknorris
  dotenv                 # .env file when you cd into project root directory
  gitfast                # completion for git
  history                # command line history
  nvm                    # autocompletion + sources nvm
  z
  zsh-autosuggestions
  zsh-syntax-highlighting
  you-should-use
)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh
zstyle ":omz:update" mode auto
zstyle ":omz:update" frequency 7

# === USER CONFIGURATION ===
export EDITOR="nvim"
DISABLE_UNTRACKED_FILES_DIRTY="true" # speed up prompt by ignoring untracked files in Git status

# === ALIASES ===
alias ll="eza -l --group-directories-first --icons"
alias lla="ll -a"

alias v="nvim"
alias vv="NVIM_APPNAME=ndev nvim"
# alias vv="VIMRUNTIME=~/@Projects/github.com/neovim/neovim/runtime NVIM_APPNAME=ndev ~/@Projects/github.com/neovim/neovim/build/bin/nvim"

# === CUSTOM SCRIPTS ===
export PATH="${HOME}/.jsvu/bin:${PATH}" # jsvu binaries
source ~/.config/zsh/scripts/timed.zsh  # time wrapper with formatted output (timed)

# === LOCAL OVERRIDES ===
if [ -f "$HOME/.zshrc.local" ]; then
    source "$HOME/.zshrc.local"
fi
