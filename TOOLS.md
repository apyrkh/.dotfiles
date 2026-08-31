# Tools

Package names live in the install scripts; this file is the human-readable
index of what each tier gives you. Anything marked *(macOS)* / *(Ubuntu)* is
installed differently per platform — everything else is identical on both.

## Base Level

`install.sh` — `scripts/install-mac.sh` or `scripts/install-ubuntu.sh`, then
`scripts/install-common.sh`.

font-jetbrains-mono-nerd-font

### === shell ===
zsh
oh-my-zsh
zsh-autosuggestions
zsh-syntax-highlighting
you-should-use

### === dev tools ===
cmake
go
fnm
uv
libpq
bun (curl -fsSL https://bun.sh/install | bash)

### === neovim (runtime deps) ===
neovim
tree-sitter-cli
luarocks
fzf
fd
ripgrep

### === ai === (installed by scripts/install-common.sh on both platforms)
claude-code (curl -fsSL https://claude.ai/install.sh | bash)
agy (curl -fsSL https://antigravity.google/cli/install.sh | bash)
copilot-cli (bun add --global @github/copilot)
codex (bun add --global @openai/codex)

### === cli ===
git
gh
lazygit
tree
eza
zoxide
fx
gnu-time (macOS: `gtime` / Ubuntu: apt `time`, `/usr/bin/time`)

---

## Work Level

`install-mac-work.sh` — macOS only.

wezterm@nightly

peon-ping
cowsay
fortune
battery (menu-bar app that also installs a CLI)

colima
docker

jetbrains-toolbox
google-chrome
opera
keepassxc
appcleaner
keycastr
logi-options+

---

## Home Level

`install-mac-home.sh` — macOS only.
google-drive
notion
chatgpt

mtr

### === media processing ===
ffmpeg
ghostscript
pngquant
jpegoptim
webp
libheif
upscayl
adobe-acrobat-reader
iina
obs

openmtp
balenaetcher

battle-net
steam

discord
telegram
whatsapp
zoom

## Manual Installation

blackhole-2ch
openjdk@21
maven
awscli
sops
