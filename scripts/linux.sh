#!/usr/bin/env bash
set -euo pipefail

dotfiles_dir="$1"
dotfiles_home="$2"
local_bin="$dotfiles_home/.local/bin"
# nvim-treesitter (main branch) requires the latest stable/nightly Neovim; keep in step with it.
nvim_min_version="0.12.0"

# shellcheck source=lib.sh
source "$dotfiles_dir/scripts/lib.sh"

install_apt_packages() {
  info "Installing Ubuntu packages"
  run_as_root env DEBIAN_FRONTEND=noninteractive apt-get update
  run_as_root env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    ca-certificates \
    build-essential \
    cmake \
    curl \
    fd-find \
    fzf \
    git \
    gh \
    golang-go \
    locales \
    luarocks \
    mtr-tiny \
    ripgrep \
    tar \
    time \
    tree \
    unzip \
    wl-clipboard \
    xclip \
    xz-utils \
    zoxide \
    zsh

  # Neovim config assumes en_US.UTF-8, matching macOS/Homebrew's default.
  if ! locale -a 2>/dev/null | grep -qi '^en_US.utf8$'; then
    run_as_root sed -i 's/^# *\(en_US.UTF-8 UTF-8\)/\1/' /etc/locale.gen
    run_as_root locale-gen en_US.UTF-8
  fi
}

version_at_least() {
  local actual="$1"
  local minimum="$2"

  dpkg --compare-versions "$actual" ge "$minimum"
}

install_neovim() {
  local architecture asset temporary_dir extracted_dir installed_version install_dir nvim_bin

  nvim_bin="$local_bin/nvim"
  if [[ ! -x "$nvim_bin" ]]; then
    nvim_bin="$(command -v nvim || true)"
  fi

  if [[ -n "$nvim_bin" ]]; then
    installed_version="$("$nvim_bin" --version | sed -n '1s/^NVIM v//p')"
    if [[ -n "$installed_version" ]] && version_at_least "$installed_version" "$nvim_min_version"; then
      info "Neovim $installed_version is already installed"
      return
    fi
  fi

  case "$(uname -m)" in
    x86_64)
      architecture="x86_64"
      ;;
    aarch64|arm64)
      architecture="arm64"
      ;;
    *)
      die "unsupported Neovim architecture: $(uname -m)"
      ;;
  esac

  temporary_dir="$(mktemp -d)"
  trap 'rm -rf "$temporary_dir"' RETURN
  asset="nvim-linux-$architecture.tar.gz"

  info "Downloading current Neovim release for $architecture"
  curl -fsSL "https://github.com/neovim/neovim/releases/latest/download/$asset" -o "$temporary_dir/$asset"
  tar -xzf "$temporary_dir/$asset" -C "$temporary_dir"
  extracted_dir="$temporary_dir/nvim-linux-$architecture"
  [[ -x "$extracted_dir/bin/nvim" ]] || die "Neovim archive did not contain nvim"

  installed_version="$("$extracted_dir/bin/nvim" --version | sed -n '1s/^NVIM v//p')"
  [[ -n "$installed_version" ]] || die "could not determine downloaded Neovim version"
  version_at_least "$installed_version" "$nvim_min_version" ||
    die "downloaded Neovim $installed_version is older than required $nvim_min_version"

  install_dir="/opt/nvim-$installed_version-$architecture"
  if [[ ! -d "$install_dir" ]]; then
    run_as_root mv "$extracted_dir" "$install_dir"
  fi

  link_managed "$install_dir/bin/nvim" "$local_bin/nvim"
  info "Installed Neovim $installed_version"
}

install_eza() {
  local architecture asset temporary_dir

  if [[ -x "$local_bin/eza" ]] || command -v eza >/dev/null 2>&1; then
    info "eza is already installed"
    return
  fi

  case "$(uname -m)" in
    x86_64)
      architecture="x86_64-unknown-linux-gnu"
      ;;
    aarch64|arm64)
      architecture="aarch64-unknown-linux-gnu"
      ;;
    *)
      die "unsupported eza architecture: $(uname -m)"
      ;;
  esac

  temporary_dir="$(mktemp -d)"
  trap 'rm -rf "$temporary_dir"' RETURN
  asset="eza_$architecture.tar.gz"

  info "Downloading current eza release for $architecture"
  curl -fsSL "https://github.com/eza-community/eza/releases/latest/download/$asset" -o "$temporary_dir/$asset"
  tar -xzf "$temporary_dir/$asset" -C "$temporary_dir"
  [[ -x "$temporary_dir/eza" ]] || die "eza archive did not contain eza"

  mkdir -p "$local_bin"
  mv "$temporary_dir/eza" "$local_bin/eza"
  info "Installed eza"
}

latest_github_tag() {
  local repository="$1"

  curl -fsSL "https://api.github.com/repos/$repository/releases/latest" |
    sed -n 's/.*"tag_name": *"\([^"]*\)".*/\1/p'
}

install_lazygit() {
  local architecture asset temporary_dir tag version

  if [[ -x "$local_bin/lazygit" ]] || command -v lazygit >/dev/null 2>&1; then
    info "lazygit is already installed"
    return
  fi

  case "$(uname -m)" in
    x86_64)
      architecture="x86_64"
      ;;
    aarch64|arm64)
      architecture="arm64"
      ;;
    *)
      die "unsupported lazygit architecture: $(uname -m)"
      ;;
  esac

  tag="$(latest_github_tag jesseduffield/lazygit)"
  [[ -n "$tag" ]] || die "could not determine latest lazygit release"
  version="${tag#v}"

  temporary_dir="$(mktemp -d)"
  trap 'rm -rf "$temporary_dir"' RETURN
  asset="lazygit_${version}_linux_$architecture.tar.gz"

  info "Downloading current lazygit release for $architecture"
  curl -fsSL "https://github.com/jesseduffield/lazygit/releases/download/$tag/$asset" -o "$temporary_dir/$asset"
  tar -xzf "$temporary_dir/$asset" -C "$temporary_dir" lazygit
  [[ -x "$temporary_dir/lazygit" ]] || die "lazygit archive did not contain the binary"

  mkdir -p "$local_bin"
  mv "$temporary_dir/lazygit" "$local_bin/lazygit"
  info "Installed lazygit"
}

install_fx() {
  local architecture asset temporary_dir

  if [[ -x "$local_bin/fx" ]] || command -v fx >/dev/null 2>&1; then
    info "fx is already installed"
    return
  fi

  case "$(uname -m)" in
    x86_64)
      architecture="amd64"
      ;;
    aarch64|arm64)
      architecture="arm64"
      ;;
    *)
      die "unsupported fx architecture: $(uname -m)"
      ;;
  esac

  temporary_dir="$(mktemp -d)"
  trap 'rm -rf "$temporary_dir"' RETURN
  asset="fx_linux_$architecture"

  info "Downloading current fx release for $architecture"
  curl -fsSL "https://github.com/antonmedv/fx/releases/latest/download/$asset" -o "$temporary_dir/$asset"

  mkdir -p "$local_bin"
  mv "$temporary_dir/$asset" "$local_bin/fx"
  chmod +x "$local_bin/fx"
  info "Installed fx"
}

install_bun() {
  if find_bun "$dotfiles_home" >/dev/null; then
    info "Bun is already installed"
    return
  fi

  info "Installing Bun"
  curl -fsSL https://bun.sh/install | HOME="$dotfiles_home" SHELL=/bin/sh BUN_INSTALL="$dotfiles_home/.bun" bash
  [[ -x "$dotfiles_home/.bun/bin/bun" ]] || die "Bun installation did not create the expected binary"
}

install_tree_sitter_cli() {
  local architecture asset temporary_dir tree_sitter_bin

  tree_sitter_bin="$local_bin/tree-sitter"
  if [[ -x "$tree_sitter_bin" ]] && "$tree_sitter_bin" --version >/dev/null 2>&1; then
    info "Tree-sitter CLI is already installed"
    return
  fi

  case "$(uname -m)" in
    x86_64)
      architecture="x64"
      ;;
    aarch64|arm64)
      architecture="arm64"
      ;;
    *)
      die "unsupported Tree-sitter architecture: $(uname -m)"
      ;;
  esac

  temporary_dir="$(mktemp -d)"
  trap 'rm -rf "$temporary_dir"' RETURN
  asset="tree-sitter-linux-$architecture.gz"

  info "Downloading current Tree-sitter CLI for $architecture"
  curl -fsSL "https://github.com/tree-sitter/tree-sitter/releases/latest/download/$asset" -o "$temporary_dir/$asset"
  mkdir -p "$local_bin"
  gzip -dc "$temporary_dir/$asset" > "$temporary_dir/tree-sitter"
  chmod 755 "$temporary_dir/tree-sitter"
  "$temporary_dir/tree-sitter" --version >/dev/null ||
    die "downloaded Tree-sitter CLI could not run"
  mv "$temporary_dir/tree-sitter" "$tree_sitter_bin"
  info "Installed Tree-sitter CLI"
}

install_fnm() {
  if [[ -x "$dotfiles_home/.local/share/fnm/fnm" ]]; then
    info "fnm is already installed"
    return
  fi

  info "Installing fnm"
  HOME="$dotfiles_home" curl -fsSL https://fnm.vercel.app/install | HOME="$dotfiles_home" bash -s -- --skip-shell
  [[ -x "$dotfiles_home/.local/share/fnm/fnm" ]] || die "fnm installation did not create the expected binary"
}

install_node_lts() {
  local fnm_dir="$dotfiles_home/.local/share/fnm"
  local fnm_bin="$fnm_dir/fnm"
  local node_wrapper="$local_bin/node"
  local temporary_file

  if ! FNM_DIR="$fnm_dir" "$fnm_bin" exec --using=default node --version >/dev/null 2>&1; then
    info "Installing Node.js LTS with fnm"
    FNM_DIR="$fnm_dir" "$fnm_bin" install --lts --progress never
    FNM_DIR="$fnm_dir" "$fnm_bin" default lts-latest
  else
    info "Node.js LTS is already installed"
  fi

  mkdir -p "$local_bin"
  temporary_file="$(mktemp)"
  cat > "$temporary_file" <<'EOF'
#!/usr/bin/env bash
exec "$HOME/.local/share/fnm/fnm" exec --fnm-dir "$HOME/.local/share/fnm" --using=default node "$@"
EOF
  chmod 755 "$temporary_file"

  if [[ ! -f "$node_wrapper" ]] || ! cmp -s "$temporary_file" "$node_wrapper"; then
    mv "$temporary_file" "$node_wrapper"
  else
    rm "$temporary_file"
  fi

  "$node_wrapper" --version >/dev/null || die "Node.js LTS is not available through $node_wrapper"
}

install_oh_my_zsh() {
  local zsh_dir="$dotfiles_home/.oh-my-zsh"

  if [[ ! -d "$zsh_dir" ]]; then
    info "Installing Oh My Zsh"
    HOME="$dotfiles_home" RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi

  [[ -d "$zsh_dir" ]] || die "Oh My Zsh installation did not create the expected directory"
  ensure_git_checkout https://github.com/zsh-users/zsh-autosuggestions "$zsh_dir/custom/plugins/zsh-autosuggestions"
  ensure_git_checkout https://github.com/zsh-users/zsh-syntax-highlighting "$zsh_dir/custom/plugins/zsh-syntax-highlighting"
  ensure_git_checkout https://github.com/MichaelAquilina/zsh-you-should-use "$zsh_dir/custom/plugins/you-should-use"
}

install_apt_packages
link_if_absent "$(command -v fdfind)" "$local_bin/fd"
install_neovim
install_eza
install_lazygit
install_fx
install_bun
install_fnm
install_node_lts
install_tree_sitter_cli
install_devcontainer_cli "$dotfiles_home"
install_bun_global_package "$dotfiles_home" @github/copilot copilot "GitHub Copilot CLI"
install_bun_global_package "$dotfiles_home" @openai/codex codex "OpenAI Codex CLI"
install_oh_my_zsh
