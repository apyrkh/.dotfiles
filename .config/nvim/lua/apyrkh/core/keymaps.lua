-- Heavily inspired by LazyVim
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

vim.g.mapleader = " "

local keymap = vim.keymap

-- Resize window using <Shift> arrow keys
keymap.set("n", "<S-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
keymap.set("n", "<S-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
keymap.set("n", "<S-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
keymap.set("n", "<S-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move to window using the <ctrl> hjkl keys
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Switch buffers
keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })

-- Move half page with and center screen
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Go 1/2 Page Up", remap = true })
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Go 1/2 Page Down", remap = true })

-- Move lines
keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- Indent
keymap.set("v", "<", "<gv", { desc = "Decrease Indent" })
keymap.set("v", ">", ">gv", { desc = "Increase Indent" })

-- Substitute plugin
keymap.set("n", "s", function () require('substitute').operator() end, { desc = "Substitute with motion" })
keymap.set("n", "ss", function() require('substitute').line() end, { desc = "Substitute line" })
keymap.set("n", "S", function() require('substitute').eol() end, { desc = "Substitute to end of line" })
keymap.set("x", "s", function() require('substitute').visual() end, { desc = "Substitute in visual mode" })

-- Improved search
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
keymap.set("n", "n", "'Nn'[v:searchforward].'zzzv'", { expr = true, desc = "Next Search Result" })
keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
keymap.set("n", "N", "'nN'[v:searchforward].'zzzv'", { expr = true, desc = "Prev Search Result" })
keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
-- Clear search with <esc>
keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- Diagnostic
keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Pevious Diagnostic" })
keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
keymap.set("n", "<leader>uD", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Show Buffer Diagnostics" })
keymap.set("n", "<leader>ud", vim.diagnostic.open_float, { desc = "Show Line Diagnostics" })

-- Quickfix
keymap.set("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
keymap.set("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

-- Show all the items at a given buffer position.
keymap.set("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })

-- FUN
-- plugin: cellular-automaton.nvim
keymap.set("n", "<leader>qq", "<cmd>CellularAutomaton make_it_rain<CR>", { desc = "Make it rain" })

