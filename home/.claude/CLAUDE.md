# Global instructions

## Response style

Write prose in concise, laconic B2-level English — simple sentences, common vocabulary, no idioms or
phrasal verbs. Optimized for an Eastern European non-native reader.
Does not apply to code, comments, or commit messages.

## Environment

macOS. zsh + Oh My Zsh, Neovim, WezTerm. Dotfiles live in `~/.dotfiles` (managed by `install.sh`).

## Available CLI tools

Prefer these over slower defaults when present: `rg` (grep), `fd` (find), `fzf`, `eza` (ls), `zoxide`,
`tree`, `fx` (JSON), `lazygit`, `gnu-time`, `mtr`, `ffmpeg`, `gs` (ghostscript/PDF), `colima`/`docker`.

## Task recipes

Before a media or PDF compression/conversion task, check `~/.dotfiles/docs/tldr/` for a ready-made
command (e.g. `ffmpeg.md`, `ghostscript.md`) instead of deriving one from scratch.

For the home directory's `@`-prefixed layout, see `~/.dotfiles/docs/storage.md`.
