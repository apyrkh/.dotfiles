-- Tabs
vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<CR>", { noremap = true, silent = true, desc = "Open New Tab" })
vim.keymap.set("n", "<leader>tq", "<cmd>tabclose<CR>", { noremap = true, silent = true, desc = "Close Tab" })
vim.keymap.set("n", "<leader>t[", "<cmd>tabprevious<CR>", { noremap = true, silent = true, desc = "Prev Tab" })
vim.keymap.set("n", "<leader>t]", "<cmd>tabnext<CR>", { noremap = true, silent = true, desc = "Next Tab" })

-- Windows
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true, desc = "Go Left Window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true, desc = "Go Down Window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true, desc = "Go Up Window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true, desc = "Go Right Window" })

-- Resize
vim.keymap.set("n", "<S-Up>", "<cmd>resize +2<CR>", { noremap = true, silent = true, desc = "Increase Height" })
vim.keymap.set("n", "<S-Down>", "<cmd>resize -2<CR>", { noremap = true, silent = true, desc = "Decrease Height" })
vim.keymap.set("n", "<S-Left>", "<cmd>vertical resize -2<CR>", { noremap = true, silent = true, desc = "Decrease Width" })
vim.keymap.set("n", "<S-Right>", "<cmd>vertical resize +2<CR>", { noremap = true, silent = true, desc = "Increase Width" })

 -- Scroll + center
vim.keymap.set("n", "<C-u>", "<C-u>zz", { silent = true, remap = true, desc = "Scroll Up Center" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { silent = true, remap = true, desc = "Scroll Down Center" })

 -- Search: keep centered
 -- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward].'zzzv'", { noremap = true, silent = true, expr = true, desc = "Next Search" })
vim.keymap.set("n", "N", "'nN'[v:searchforward].'zzzv'", { noremap = true, silent = true, expr = true, desc = "Prev Search" })
vim.keymap.set({ "x", "o" }, "n", "'Nn'[v:searchforward]", { noremap = true, silent = true, expr = true, desc = "Next Search" })
vim.keymap.set({ "x", "o" }, "N", "'nN'[v:searchforward]", { noremap = true, silent = true, expr = true, desc = "Prev Search" })
vim.keymap.set({ "n", "i" }, "<esc>", "<cmd>noh<cr><esc>", { noremap = true, silent = true, desc = "Clear Highlight" })

-- Edit (move lines / indent)
vim.keymap.set("v", "<S-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move Line Down" })
vim.keymap.set("v", "<S-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move Line Up" })
vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true, desc = "Shift Left" })
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true, desc = "Shift Right" })
