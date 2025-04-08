" Set leader key (commonly used in mappings)
let mapleader = " "

" Auto-reload files when modified externally
" https://unix.stackexchange.com/a/383044
set autoread

" Highlight yanked text
" @TODO: add highlight settings

" Line numbers
set number               " shows absolute line number
set relativenumber       " show relative line numbers

" Scrolling and tabs
set scrolloff=5          " minimal number of screen lines to keep above and below the cursor
set tabstop=2            " 2 spaces for tabs (prettier default)
set shiftwidth=2         " 2 spaces for indent width
set expandtab            " expand tab to spaces
set autoindent           " copy indent from current line when starting new one
set nowrap               " disable line wrapping

" UI settings
set termguicolors        " Enable true colors
set background=dark      " Set dark background
set cursorline           " highlight the current cursor line
set signcolumn=yes       " show sign column so that text doesn't shift
set list                 " sets how Vim will display certain whitespace in the editor
set listchars=eol:↲,tab:»\ ,space:.,nbsp:␣
set winborder=single     " double, rounded, solid, shadow

colorscheme desert

" Search settings
set hlsearch             " highlight search results
set ignorecase           " ignore case when searching
set smartcase            " if you include mixed case in your search, assumes you want case-sensitive

" Backspace and clipboard
set backspace=indent,eol,start  " allow backspace on indent, end of line or insert mode start position
" set clipboard=unnamedplus      " use system clipboard as default register
set mouse=a              " enable mouse, for resizing splits

" Window splitting
set splitright           " split vertical window to the right
set splitbelow           " split horizontal window to the bottom

" Spelling
set spell
set spelllang=en_us,en

" Swapfile
set noswapfile           " turn off swapfile

" Enable syntax highlighting
syntax enable
