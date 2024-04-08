local opt = vim.opt

opt.number = true -- shows absolute line number
opt.relativenumber = true -- show relative line numbers

opt.scrolloff = 5 -- minimal number of screen lines to keep above and below the cursor.
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one
opt.wrap = false -- disable line wrapping

opt.termguicolors = true
opt.background = "dark"
opt.cursorline = true -- highlight the current cursor line
opt.signcolumn = "yes" -- show sign column so that text doesn't shift
opt.list = true -- sets how neovim will display certain whitespace in the editor
opt.listchars = {
  eol = "↲",
  tab = "» ",
  space = ".",
  nbsp = "␣"
}

opt.hlsearch = true
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position
opt.clipboard:append("unnamedplus") -- use system clipboard as default register
opt.mouse = "a" -- enable mouse, for resizing splits

-- tab splitting
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- spelling
opt.spell = true
opt.spelllang = 'en_us,en'

-- turn off swapfile
opt.swapfile = false
