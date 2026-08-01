# Neovim

Heavily inspired by:
- [Josean Martinez](https://youtu.be/NL8D8EkphUw)
- [LazyVim keymaps](https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua)

Plugins:
- [Dotfyle](https://dotfyle.com)

## files.lua - Windows & file exploration
- [x] `stevearc/oil.nvim` - edit filesystem as buffer
- [x] `nvim-tree/nvim-tree.lua` - file explorer sidebar

## editor.lua - Text manipulation & editing
- [x] `nvim-mini/mini.ai` - extended text objects
- [x] `nvim-mini/mini.align` - align actions
- [x] `nvim-mini/mini.comment` - fast comments
- [x] `nvim-mini/mini.operators` - extended operators
- [x] `nvim-mini/mini.pairs` - automatic brackets
- [x] `nvim-mini/mini.surround` - surround actions
- [x] `gbprod/yanky.nvim` - clipboard history

## navigation.lua - Search & quick file switching
- [x] `ThePrimeagen/harpoon` - quick file bookmarks
- [x] `ibhagwan/fzf-lua` - fuzzy finder

## ai.lua - AI assistance
- [x] `github/copilot.vim` - inline completion
- [ ] `CopilotC-Nvim/CopilotChat.nvim` - Copilot chat interface
- [ ] `coder/claudecode.nvim` - Claude-powered code actions
- [ ] `yetone/avante.nvim` - AI-assisted coding workflows

## code.lua - LSP, completion, syntax
- [x] `folke/trouble.nvim` - diagnostics list
- [x] `stevearc/conform.nvim` - formatting bridge
- [x] `saghen/blink.cmp` - completion engine
- [x] `neovim/nvim-lspconfig` - LSP configuration
    - [x] `williamboman/mason.nvim` - installer for LSP/formatters/linters
    - [x] `williamboman/mason-lspconfig.nvim` - mason ↔ LSP bridge
- [x] `nvim-treesitter/nvim-treesitter` - syntax parsing & highlighting
- [x] `windwp/nvim-ts-autotag` - auto-close/rename HTML & JSX tags

## vcs.lua - Version control & Git
- [x] `lewis6991/gitsigns.nvim` - Git signs & hunk actions
- [x] `NeogitOrg/neogit` - Magit-style Git UI
    - [x] `sindrets/diffview.nvim` - diff & merge tool

## workflow.lua - Workflow & sessions
- [x] `rmagatti/auto-session` - session management

## ui.lua - UI & visuals
- [x] `folke/snacks.nvim` - high-performance core UI utilities and QoL tools
- [x] `folke/todo-comments.nvim` - highlight TODO / FIXME / NOTE
- [x] `folke/which-key.nvim` - keybinding popup
- [x] `norcalli/nvim-colorizer.lua` - color highlighter
- [x] `nvim-mini/mini.indentscope` - visualize and operate on indent scope
- [x] `nvim-lualine/lualine.nvim` - statusline
- [x] `catppuccin/nvim` - color scheme
- [x] `folke/tokyonight.nvim` - color scheme
- [x] `eandrju/cellular-automaton.nvim` - fun animations/effects
