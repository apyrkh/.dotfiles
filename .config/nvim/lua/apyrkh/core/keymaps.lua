-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Go 1/2 page UP + center screen" })
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Go 1/2 page DOWN + center screen" })

-- moving line around
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line DOWN" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line UP" })

-- search
keymap.set("n", "N", "Nzzzv", { desc = "Go to PREV match + center screen + unfold" })
keymap.set("n", "n", "nzzzv", { desc = "Go to NEXT match + center screen + unfold" })
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- plugin: cellular-automaton.nvim
keymap.set("n", "<leader>qq", "<cmd>CellularAutomaton make_it_rain<CR>")

