# === fonts ===
cask "font-jetbrains-mono-nerd-font"

# === terminal ===
#cask "warp"
# cask "wezterm"   # using nightly manually; uncomment when switching to stable
cask "wezterm@nightly"
# brew "zsh"       # macOS already ships with zsh

# === dev tools ===
brew "cmake"
brew "go"
brew "fnm"        # fast Node.js version manager (Rust-based replacement for nvm)

# === neovim (runtime deps) ===
brew "neovim"
brew "tree-sitter-cli"
brew "luarocks"
brew "fzf"
brew "fd"
brew "ripgrep"

brew "copilot-cli"    # GitHub Copilot CLI
cask "codex"          # OpenAI Codex CLI

# === cli ===
brew "git"
brew "gh"             # GitHub CLI
brew "lazygit"
brew "tree"
brew "eza"            # modern ls replacement
brew "zoxide"         # zi
brew "fx"             # json viewer and processor, https://fx.wtf
brew "gnu-time"
brew "mtr"            # my trace route

# === media processing ===
brew "ffmpeg"         # for video/audio processing
brew "ghostscript"    # for pdf processing
brew "pngquant"       # lossy png compression
brew "jpegoptim"      # jpeg compression
brew "webp"           # cwebp/dwebp; was a transitive dep, now explicit
brew "libheif"        # heic decoding (iphone photos)

# === containers ===
brew "colima"         # container runtime for macOS, alternative to docker desktop
brew "docker"

# === fun / misc ===
tap "peonping/tap"
brew "peonping/tap/peon-ping"
brew "cowsay"
brew "fortune"
cask "battle-net"
cask "steam"

# === apps ===
cask "jetbrains-toolbox"
cask "google-chrome"
cask "google-drive"
cask "opera"
cask "keepassxc"
cask "notion"
cask "chatgpt"

cask "openmtp"        # android-file-transfer
cask "balenaetcher"   # tool to flash OS images to SD cards & USB drives
cask "appcleaner"
cask "keycastr"       # keystroke visualiser
cask "logi-options+"

cask "discord"
cask "telegram"
cask "whatsapp"
cask "zoom"

cask "adobe-acrobat-reader"
cask "iina"
cask "obs"
cask "paintbrush"
cask "upscayl"
# cask "blackhole-2ch" # macOS virtual audio loopback driver

# === databases ===
# tap "mongodb/brew"
# brew "mongodb/brew/mongodb-community"
# cask "mongodb-compass"

brew "postgresql@16", restart_service: :changed
