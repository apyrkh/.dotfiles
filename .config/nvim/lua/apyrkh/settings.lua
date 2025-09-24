-- Set leader key
vim.g.mapleader = " "

-- Diagnostics
vim.diagnostic.config({
  -- virtual_text = true,
  virtual_text = { current_line = true },
  -- virtual_lines = true,
  -- virtual_lines = { current_line = true },
  float = { border = "rounded" },
})

-- Highlight yanked text
-- vim.api.nvim_create_autocmd("TextYankPost", {
--   pattern = "*",
--   callback = function()
--     vim.highlight.on_yank({ higroup = "IncSearch", timeout = 500 })
--   end
-- })

-- Auto-reload files when modified externally
vim.opt.autoread = true

-- Line numbers
vim.opt.number = true         -- shows absolute line number
vim.opt.relativenumber = true -- show relative line numbers

-- Scrolling and tabs
vim.opt.scrolloff = 5     -- minimal number of screen lines to keep above and below the cursor
vim.opt.expandtab = true  -- expand tab to spaces
vim.opt.shiftwidth = 2    -- 2 spaces for indent width
vim.opt.tabstop = 2       -- 2 spaces for tabs
vim.opt.autoindent = true -- copy indent from current line when starting new one
vim.opt.smartindent = true
vim.opt.textwidth = 80
vim.opt.wrap = false -- disable line wrapping

-- UI settings
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.cursorline = true  -- highlight the current cursor line
vim.opt.signcolumn = "yes" -- show sign column so that text doesn't shift
vim.opt.list = true        -- sets how neovim will display certain whitespace in the editor
vim.opt.listchars = {
  eol = "↲",
  tab = "» ",
  space = ".",
  nbsp = "␣"
}
-- TODO: use this, remove everywhere else to avoid double borders
-- vim.opt.winborder = 'single' -- double, rounded, solid, shadow

-- Search settings
vim.opt.hlsearch = true
vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true  -- if you include mixed case in your search, assumes you want case-sensitive

-- Backspace and clipboard
vim.opt.backspace = "indent,eol,start"
vim.opt.clipboard:append("unnamedplus")
vim.opt.mouse = "a"

-- Window splitting
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Spelling
vim.opt.spell = true
vim.opt.spelllang = "en_us,en"

-- Swapfile
vim.opt.swapfile = false
