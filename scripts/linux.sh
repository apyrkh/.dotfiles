#!/usr/bin/env bash
set -euo pipefail

dotfiles_dir="$1"
dotfiles_home="$2"
local_bin="$dotfiles_home/.local/bin"
nvim_min_version="0.11.0"

# shellcheck source=lib.sh
source "$dotfiles_dir/scripts/lib.sh"

install_apt_packages() {
  info "Installing Debian/Ubuntu packages"
  run_as_root env DEBIAN_FRONTEND=noninteractive apt-get update
  run_as_root env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    ca-certificates \
    build-essential \
    curl \
    fd-find \
    fzf \
    git \
    gh \
    ripgrep \
    tar \
    unzip \
    wl-clipboard \
    xclip \
    xz-utils \
    zoxide \
    zsh
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

  link_if_absent "$install_dir/bin/nvim" "$local_bin/nvim"
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

install_fnm() {
  if [[ -x "$dotfiles_home/.local/share/fnm/fnm" ]]; then
    info "fnm is already installed"
    return
  fi

  info "Installing fnm"
  HOME="$dotfiles_home" curl -fsSL https://fnm.vercel.app/install | HOME="$dotfiles_home" bash -s -- --skip-shell
  [[ -x "$dotfiles_home/.local/share/fnm/fnm" ]] || die "fnm installation did not create the expected binary"
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
install_fnm
install_oh_my_zsh
