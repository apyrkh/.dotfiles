# Debian/Ubuntu Linux setup

Only Debian and Ubuntu are supported. This path is for Dev Containers and headless remote environments as well as regular Linux hosts.

```bash
git clone https://github.com/apyrkh/.dotfiles ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

The installer needs root or passwordless `sudo`. It sets `DEBIAN_FRONTEND=noninteractive` and installs the required terminal tools without prompts: `ripgrep`, `fd-find`, `fzf`, `git`, `curl`, `build-essential`, `tree-sitter-cli`, `unzip`, `zsh`, clipboard providers, and the other tools used by the shared Zsh setup. It installs a current upstream Neovim release because the configuration requires newer APIs than distro Neovim packages may provide.

It creates `~/.local/bin/fd` for Debian/Ubuntu's `fdfind` command and adds the local bin directory to Zsh's path. It also installs Bun with its official installer, then installs both `tree-sitter-cli` and `@devcontainers/cli` globally with Bun. The resulting `tree-sitter` and `devcontainer` commands are in `~/.bun/bin`. It also installs Oh My Zsh, its configured plugins, `fnm`, and `eza`. It does not run `chsh`; change the login shell manually if required:

```bash
chsh -s "$(command -v zsh)"
```

`./install.sh --home` is macOS-only and fails clearly on Linux. Run `./install.sh --skip-packages` when container image provisioning already supplied packages.

## Clipboard behavior

Neovim uses the native clipboard provider when `xclip` or `wl-copy` is available. Over SSH, it falls back to OSC 52 when supported by the terminal. Fully headless sessions without a clipboard provider start normally without forced clipboard integration. The Zsh `cpwd` helper similarly selects `pbcopy`, `wl-copy`, or `xclip` and reports a clear error if none is available.

## Dev Container

Open this repository with the included `.devcontainer/devcontainer.json`. The post-create command runs the same bootstrap as the `dev` user, so the configuration is linked in that container user’s home.

Start or rebuild it with:

```bash
devcontainer up --workspace-folder .
```

The Dev Container CLI has no `down` command. To stop a running Dev Container, first find it and then stop its ID with Docker:

```bash
docker ps --format 'table {{.ID}}\t{{.Names}}\t{{.Label "devcontainer.local_folder"}}'
docker stop <container-id>
```

## Isolated validation

The Docker smoke test uses a disposable Debian or Ubuntu image and runs the installer twice:

```bash
docker build --build-arg BASE_IMAGE=debian:bookworm -f tests/docker/Dockerfile .
docker build --build-arg BASE_IMAGE=ubuntu:24.04 -f tests/docker/Dockerfile .
```

It verifies required commands, links, the backup behavior, repeatability, and headless Neovim plugin synchronization. GitHub Actions runs the same two-image matrix. Do not run these provisioning tests against a local host home.
