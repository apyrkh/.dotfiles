-- Set leader key (commonly used in mappings)
vim.g.mapleader = " "

-- Auto-reload files when modified externally
-- https://unix.stackexchange.com/a/383044
vim.opt.autoread = true

-- Highlight yanked text
-- vim.api.nvim_create_autocmd("TextYankPost", {
--   pattern = "*",
--   callback = function()
--     vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 500 })
--   end
-- })

-- Line numbers
vim.opt.number = true -- shows absolute line number
vim.opt.relativenumber = true -- show relative line numbers

-- Scrolling and tabs
vim.opt.scrolloff = 5 -- minimal number of screen lines to keep above and below the cursor
vim.opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
vim.opt.shiftwidth = 2 -- 2 spaces for indent width
vim.opt.expandtab = true -- expand tab to spaces
vim.opt.autoindent = true -- copy indent from current line when starting new one
vim.opt.wrap = false -- disable line wrapping

-- UI settings
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.cursorline = true -- highlight the current cursor line
vim.opt.signcolumn = "yes" -- show sign column so that text doesn't shift
vim.opt.list = true -- sets how neovim will display certain whitespace in the editor
vim.opt.listchars = {
  eol = "↲",
  tab = "» ",
  space = ".",
  nbsp = "␣"
}

-- Search settings
vim.opt.hlsearch = true
vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- Backspace and clipboard
vim.opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position
vim.opt.clipboard:append("unnamedplus") -- use system clipboard as default register
vim.opt.mouse = "a" -- enable mouse, for resizing splits

-- Window splitting
vim.opt.splitright = true -- split vertical window to the right
vim.opt.splitbelow = true -- split horizontal window to the bottom

-- Spelling
vim.opt.spell = true
vim.opt.spelllang = 'en_us,en'

-- Swapfile
vim.opt.swapfile = false