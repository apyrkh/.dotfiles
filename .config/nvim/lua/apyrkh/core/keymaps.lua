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
keymap.set("n", "<S-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
keymap.set("n", "<S-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
keymap.set("v", "<S-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
keymap.set("v", "<S-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })
--keymap.set("i", "<S-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
--keymap.set("i", "<S-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })

-- Indent
keymap.set("v", "<", "<gv", { desc = "Decrease Indent" })
keymap.set("v", ">", ">gv", { desc = "Increase Indent" })

-- Improved search
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
keymap.set("n", "n", "'Nn'[v:searchforward].'zzzv'", { expr = true, desc = "Next Search Result" })
keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
keymap.set("n", "N", "'nN'[v:searchforward].'zzzv'", { expr = true, desc = "Prev Search Result" })
keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Clear Result Highlighting" })

-- Go Prev/Next
keymap.set("n", "[d", "<cmd>lua DiagnosticGoPrevAndCenterCursor()<CR>", { desc = "Pevious Diagnostic" })
keymap.set("n", "]d", "<cmd>lua DiagnosticAGoNextandCenterCursor()<CR>", { desc = "Next Diagnostic" })
keymap.set("n", "[g", "<cmd>lua require('gitsigns').nav_hunk('prev')<CR>", { desc = "Prev Hunk" })
keymap.set("n", "]g", "<cmd>lua require('gitsigns').nav_hunk('next')<CR>", { desc = "Next Hunk" })
keymap.set("n", "[h", "<cmd>lua HarpoonPrevFile()<CR>", { desc = "Prev Harpoon File" })
keymap.set("n", "]h", "<cmd>lua HarpoonNextFile()<CR>", { desc = "Next Harpoon File" })
keymap.set("n", "[q", vim.cmd.cprev, { desc = "Prev Quickfix" })
keymap.set("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

-- Diagnostic
keymap.set("n", "<leader>uD", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Show Buffer Diagnostics" })
keymap.set("n", "<leader>ud", vim.diagnostic.open_float, { desc = "Show Line Diagnostics" })

-- Gitsigns
keymap.set("n", "<leader>gb", "<cmd>lua require('gitsigns').blame_line()<CR>", { desc = "Blame Line" })
keymap.set("n", "<leader>gs", "<cmd>lua require('gitsigns').stage_hunk()<CR>", { desc = "Stage Hunk" })
keymap.set("n", "<leader>gS", "<cmd>lua require('gitsigns').undo_stage_hunk()<CR>", { desc = "Unstage Hunk" })
keymap.set("n", "<leader>gr", "<cmd>lua require('gitsigns').reset_hunk()<CR>", { desc = "Reset Hunk" })
keymap.set("n", "<leader>gp", "<cmd>lua require('gitsigns').preview_hunk()<CR>", { desc = "Preview Hunk" })
keymap.set("n", "<leader>gd", "<cmd>lua require('gitsigns').diffthis('~1')<CR>", { desc = "Diff Hunk" })

-- Harpoon
keymap.set("n", "<leader>ha", "<cmd>lua HarpoonFile()<CR>", { desc = "Harpoon File" })
keymap.set("n", "<leader>hh", "<cmd>lua HarpoonQuickMenu()<CR>", { desc = "Harpoon Quick Menu" })
keymap.set("n", "<leader>1", "<cmd>lua HarpoonOpenFile(1)<CR>", { desc = "Harpoon to File 1" })
keymap.set("n", "<leader>2", "<cmd>lua HarpoonOpenFile(2)<CR>", { desc = "Harpoon to File 2" })
keymap.set("n", "<leader>3", "<cmd>lua HarpoonOpenFile(3)<CR>", { desc = "Harpoon to File 3" })
keymap.set("n", "<leader>4", "<cmd>lua HarpoonOpenFile(4)<CR>", { desc = "Harpoon to File 4" })
keymap.set("n", "<leader>5", "<cmd>lua HarpoonOpenFile(5)<CR>", { desc = "Harpoon to File 5" })

-- Substitute plugin
keymap.set("n", "s", function () require('substitute').operator() end, { desc = "Substitute with motion" })
keymap.set("n", "ss", function() require('substitute').line() end, { desc = "Substitute line" })
keymap.set("n", "S", function() require('substitute').eol() end, { desc = "Substitute to end of line" })
keymap.set("x", "s", function() require('substitute').visual() end, { desc = "Substitute in visual mode" })


-- ===== UI stuff =====
keymap.set("n", "<leader>ut", "<cmd>lua ToggleBackground()<CR>", { desc = "Toggle Theme" })
keymap.set("n", "<leader>qq", "<cmd>CellularAutomaton make_it_rain<CR>", { desc = "Make it rain" })


-- ===== FUNCTIONS =====
function DiagnosticGoPrevAndCenterCursor()
  vim.diagnostic.goto_prev()
  vim.cmd('normal! zz')
end
function DiagnosticAGoNextandCenterCursor()
  vim.diagnostic.goto_next()
  vim.cmd('normal! zz')
end

function HarpoonFile()
  require('harpoon'):list():add()
end
function HarpoonQuickMenu()
  local harpoon = require('harpoon')
  harpoon.ui:toggle_quick_menu(harpoon:list())
end
function HarpoonPrevFile()
  require('harpoon'):list():prev()
end
function HarpoonNextFile()
  require('harpoon'):list():next()
end
function HarpoonOpenFile(i)
  require('harpoon'):list():select(i)
end

function ToggleBackground()
  local current_bg = vim.api.nvim_get_option("background")
  if current_bg == "light" then
    vim.api.nvim_set_option("background", "dark")
  else
    vim.api.nvim_set_option("background", "light")
  end
end
