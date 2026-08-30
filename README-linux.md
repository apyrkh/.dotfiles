# Ubuntu Linux setup

Only Ubuntu 24.04+ is supported (matching the base image used by `.devcontainer`). This path is for Dev Containers and headless remote environments as well as regular Ubuntu hosts.

```bash
git clone https://github.com/apyrkh/.dotfiles ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

This installs the essential tools for JavaScript/TypeScript and AI-assisted development — everything needed inside a Dev Container. It does not install machine-only extras (containers-in-container, database servers, build toolchains for other languages) that the [macOS machine profile](README-mac.md) carries — those don't belong inside a container that is itself the dev environment.

The installer needs root or passwordless `sudo`. It sets `DEBIAN_FRONTEND=noninteractive` and installs the required terminal tools without prompts: `ripgrep`, `fd-find`, `fzf`, `git`, `gh`, `curl`, `build-essential`, `luarocks`, `tree`, `unzip`, `zsh`, the `en_US.UTF-8` locale, and clipboard providers. It installs a current upstream Neovim release because the configuration requires newer APIs than distro Neovim packages may provide.

It creates `~/.local/bin/fd` for Ubuntu's `fdfind` command and adds `~/.local/bin` to Zsh's path via `.zshenv` (read by every shell, not just login ones). It installs `fnm`, uses it to install the Node.js LTS release, and provides a stable `~/.local/bin/node` launcher for headless tools such as Neovim and Mason (LSP installer). It downloads the upstream Tree-sitter CLI, `eza`, `lazygit`, and `fx` straight from their GitHub releases to `~/.local/bin`, since none of those are available (or current enough) via apt on Ubuntu. Bun is installed with its official installer, then runs `bun add --global` for `@devcontainers/cli`, `@github/copilot`, and `@openai/codex` — giving you `devcontainer`, `copilot`, and `codex` in `~/.bun/bin`. It installs `uv`, then the [Serena Agent](https://oraios.github.io/serena) with it (`serena` in `~/.local/bin`) — run `serena init` per project where you want it. It also installs Oh My Zsh and its configured plugins. It does not run `chsh`; change the login shell manually if required:

```bash
chsh -s "$(command -v zsh)"
```

`./install.sh --home` is macOS-only and fails clearly on Linux. Run `./install.sh --skip-packages` when container image provisioning already supplied packages. Rerunning the installer is safe: it does not require `colima`, `docker`, or `postgresql@16` — those macOS-only Brewfile entries have no Linux equivalent here.

## Clipboard behavior

Neovim uses the native clipboard provider when `xclip` or `wl-copy` is available. Over SSH, it falls back to OSC 52 when supported by the terminal. Fully headless sessions without a clipboard provider start normally without forced clipboard integration. The Zsh `cpwd` helper similarly selects `pbcopy`, `wl-copy`, or `xclip` and reports a clear error if none is available.

## Dev Container

Open this repository with the included `.devcontainer/devcontainer.json`. The image renames the base image's existing uid 1000 user (`vscode`) to `dev` rather than creating a new user at a different uid, so the bind-mounted workspace keeps consistent ownership. The post-create command runs the same bootstrap as the `dev` user, so the configuration is linked in that container user's home.

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

The Docker smoke test uses a disposable Ubuntu 24.04 image and runs the installer three times (fresh install, no-op rerun, rerun after a Neovim install is already in place):

```bash
docker build -f tests/docker/Dockerfile .
```

It verifies required commands, links, the backup behavior, repeatability, and that Neovim actually compiles and loads Treesitter parsers headlessly — not just that `Lazy! sync` exits zero, since that command reports build failures without a nonzero exit code. GitHub Actions runs the same build. Do not run these provisioning tests against a local host home.
