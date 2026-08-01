# === LOCALE ===
export LANG=en_US.UTF-8

# === OH MY ZSH CORE ===
export ZSH="$HOME/.oh-my-zsh"

# https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="half-life" # current
# ZSH_THEME="robbyrussell" # default

# === PLUGINS ===
# Manually installed plugins in $ZSH_CUSTOM/plugins:
# - you-should-use
# - zsh-autosuggestions
# - zsh-syntax-highlighting
plugins=(
  chucknorris
  gitfast                   # completion for git
  history                   # command line history
  you-should-use
  zsh-autosuggestions
  zsh-syntax-highlighting
)

zstyle ":omz:update" mode auto
zstyle ":omz:update" frequency 7

# === LOAD OhMyZsh
source $ZSH/oh-my-zsh.sh

# === SHELL OPTIONS ===
setopt NO_BEEP
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY

# === USER CONFIGURATION ===
export EDITOR="nvim"
export DISABLE_UNTRACKED_FILES_DIRTY="true" # speed up prompt by ignoring untracked files in Git status

# === TOOLS INIT ===
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"

# === ALIASES ===
alias ll="eza -l --group-directories-first --icons"
alias lla="ll -a"
cpwd() { pwd | pbcopy; echo "Copied to clipboard"; }

alias v="nvim"
vv() {
  NVIM_APPNAME=ndev \
  nvim "$@"
}
# vv() {
#   VIMRUNTIME=~/@Projects/github.com/neovim/neovim/runtime \
#   NVIM_APPNAME=ndev \
#   ~/@Projects/github.com/neovim/neovim/build/bin/nvim "$@"
# }

# === CUSTOM SCRIPTS ===
path=("$HOME/.jsvu/bin" $path)
source ~/.config/zsh/scripts/timed.zsh  # time wrapper with formatted output (timed)

# === LOCAL OVERRIDES ===
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
