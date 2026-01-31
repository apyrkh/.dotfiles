# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Added by Toolbox App
path+=("$HOME/Library/Application Support/JetBrains/Toolbox/scripts")

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && source "/opt/homebrew/opt/nvm/nvm.sh"
