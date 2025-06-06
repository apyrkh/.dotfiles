# Set locale environment variables for consistent language settings
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Path to your oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Theme configuration, see https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="half-life" # current
# ZSH_THEME="robbyrussell" # default

# Plugin configuration
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

# User configuration
export EDITOR='nvim'
DISABLE_UNTRACKED_FILES_DIRTY="true"
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 7

# jsvu binaries
export PATH="${HOME}/.jsvu/bin:${PATH}"

# Aliases
alias ll='eza -l --group-directories-first --icons'
alias lla='ll -a'

# Custom time wrapper with formatted output
source ~/.config/zsh/scripts/timed.zsh
