local opt = vim.opt

opt.number = true -- shows absolute line number
opt.relativenumber = true -- show relative line numbers

opt.signcolumn = "yes" -- show sign column so that text doesn't shift
opt.expandtab = true -- expand tab to spaces
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.autoindent = true -- copy indent from current line when starting new one

-- sets how neovim will display certain whitespace in the editor
opt.list = true
opt.listchars = {
    eol = "↲",
    tab = "» ",
    space = ".",
    nbsp = "␣"
}

opt.wrap = false -- disable line wrapping
opt.cursorline = true -- highlight the current cursor line
opt.scrolloff = 10 -- minimal number of screen lines to keep above and below the cursor.

opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position
opt.clipboard = "unnamedplus" -- use system clipboard as default register
opt.mouse = "a" -- enable mouse, for resizing splits

opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

opt.spell = true
opt.spelllang = 'en_us,en'

opt.swapfile = false -- turn off swapfile
