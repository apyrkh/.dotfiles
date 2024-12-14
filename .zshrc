# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme configuration, see https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="half-life"
# ZSH_THEME="robbyrussell"

# Plugin configuration
plugins=(
  chucknorris
  dotenv # .env file when you cd into project root directory.
  gitfast # completion for git
  history # command line history
  nvm # autocompletion + sources nvm
  z
  zsh-autosuggestions
  zsh-syntax-highlighting
  you-should-use
)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# User configuration
export EDITOR='nvim'
DISABLE_UNTRACKED_FILES_DIRTY="true"
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 7

# Aliases
alias ll='eza -l --group-directories-first --icons'
alias lla='ll -a'
