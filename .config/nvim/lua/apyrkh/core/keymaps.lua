-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Go 1/2 page UP + center screen" })
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Go 1/2 page DOWN + center screen" })

keymap.set("n", "N", "Nzzzv", { desc = "Go to PREV match + center screen + unfold" })
keymap.set("n", "n", "nzzzv", { desc = "Go to NEXT match + center screen + unfold" })
