local nvim_tree_api = require("nvim-tree.api")
local telescope_builtin = require("telescope.builtin")

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
-- keymap.set("n", "<S-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
-- keymap.set("n", "<S-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
-- keymap.set("i", "<S-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
-- keymap.set("i", "<S-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
keymap.set("v", "<S-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
keymap.set("v", "<S-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

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
keymap.set("n", "[g", "<cmd>lua require('gitsigns').nav_hunk('prev', { target = 'all' })<CR>", { desc = "Prev Hunk" })
keymap.set("n", "]g", "<cmd>lua require('gitsigns').nav_hunk('next', { target = 'all' })<CR>", { desc = "Next Hunk" })
keymap.set("n", "[h", "<cmd>lua HarpoonPrevFile()<CR>", { desc = "Prev Harpoon File" })
keymap.set("n", "]h", "<cmd>lua HarpoonNextFile()<CR>", { desc = "Next Harpoon File" })
keymap.set("n", "[p", "<Plug>(YankyPreviousEntry)")
keymap.set("n", "]p", "<Plug>(YankyNextEntry)")
keymap.set("n", "[q", vim.cmd.cprev, { desc = "Prev Quickfix" })
keymap.set("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })
keymap.set("n", "[[", "<cmd>lua require('illuminate').goto_prev_reference('wrapscan')<CR>", { desc = "Prev Reference" })
keymap.set("n", "]]", "<cmd>lua require('illuminate').goto_next_reference('wrapscan')<CR>", { desc = "Next Reference" })

-- Auto-session
keymap.set("n", "<leader>ww", "<cmd>SessionSave<CR>", { desc = "Save Session for CWD" })
keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore Session for CWD" })
keymap.set("n", "<leader>wo", "<cmd>Autosession search<CR>", { desc = "List Saved Sessions" })
keymap.set("n", "<leader>wd", "<cmd>Autosession delete<CR>", { desc = "Delete Saved Sessions" })

-- Nvim Tree
local function get_nvim_tree_cwd()
  local node = nvim_tree_api.tree.get_node_under_cursor()

  if not node then
    print("No node selected in nvim-tree")
    return nil
  end

  if node.type == "directory" then
    return node.absolute_path
  elseif node.type == "file" then
    return vim.fn.fnamemodify(node.absolute_path, ":h")
  else
    print("Selected node is not valid for search")
    return nil
  end
end

keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })
keymap.set("n", "<leader>eo", "<cmd>NvimTreeFindFile<CR>", { desc = "Select Opened File" })
keymap.set("n", "<leader>edd", "<cmd>Oil<CR>", { desc = "Open Parent Directory" })
keymap.set("n", "<leader>edf", "<cmd>Oil --float<CR>", { desc = "Open Parent Directory (floating)" })
keymap.set("n", "<leader>ef", function()
  local cwd = get_nvim_tree_cwd()
  if cwd then
    telescope_builtin.find_files({ cwd = cwd })
  end
end, { desc = "Search files in nvim-tree directory or project" })
keymap.set("n", "<leader>eg", function()
  local cwd = get_nvim_tree_cwd()
  if cwd then
    telescope_builtin.live_grep({ cwd = cwd })
  end
end, { desc = "Live grep in nvim-tree directory or project" })

-- Gitsigns
keymap.set("n", "<leader>gb", "<cmd>lua require('gitsigns').blame_line()<CR>", { desc = "Blame Line" })
keymap.set("n", "<leader>gB", "<cmd>BlameToggle<CR>", { desc = "Blame File" })
keymap.set("n", "<leader>gs", "<cmd>lua require('gitsigns').stage_hunk()<CR>", { desc = "Stage Hunk" })
keymap.set("n", "<leader>gS", "<cmd>lua require('gitsigns').undo_stage_hunk()<CR>", { desc = "Unstage Hunk" })
keymap.set("n", "<leader>gr", "<cmd>lua require('gitsigns').reset_hunk()<CR>", { desc = "Reset Hunk" })
keymap.set("n", "<leader>gp", "<cmd>lua require('gitsigns').preview_hunk()<CR>", { desc = "Preview Hunk" })
keymap.set("n", "<leader>gd", "<cmd>lua require('gitsigns').diffthis('~1')<CR>", { desc = "Diff Hunk" })
keymap.set("n", "<leader>gg", "<cmd>Neogit<CR>", { desc = "Open Neogit" })

-- Harpoon
keymap.set("n", "<leader>ha", "<cmd>lua HarpoonFile()<CR>", { desc = "Harpoon File" })
keymap.set("n", "<leader>hh", "<cmd>lua HarpoonQuickMenu()<CR>", { desc = "Harpoon Quick Menu" })
keymap.set("n", "<leader>1", "<cmd>lua HarpoonOpenFile(1)<CR>", { desc = "Harpoon to File 1" })
keymap.set("n", "<leader>2", "<cmd>lua HarpoonOpenFile(2)<CR>", { desc = "Harpoon to File 2" })
keymap.set("n", "<leader>3", "<cmd>lua HarpoonOpenFile(3)<CR>", { desc = "Harpoon to File 3" })
keymap.set("n", "<leader>4", "<cmd>lua HarpoonOpenFile(4)<CR>", { desc = "Harpoon to File 4" })
keymap.set("n", "<leader>5", "<cmd>lua HarpoonOpenFile(5)<CR>", { desc = "Harpoon to File 5" })
keymap.set("n", "<leader>6", "<cmd>lua HarpoonOpenFile(6)<CR>", { desc = "Harpoon to File 6" })
keymap.set("n", "<leader>7", "<cmd>lua HarpoonOpenFile(7)<CR>", { desc = "Harpoon to File 7" })
keymap.set("n", "<leader>8", "<cmd>lua HarpoonOpenFile(8)<CR>", { desc = "Harpoon to File 8" })
keymap.set("n", "<leader>9", "<cmd>lua HarpoonOpenFile(9)<CR>", { desc = "Harpoon to File 9" })
keymap.set("n", "<leader>0", "<cmd>lua HarpoonOpenFile(0)<CR>", { desc = "Harpoon to File 0" })

-- LSP
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf, noremap = true, silent = true }

    opts.desc = "Go to Definition (LSP)"
    keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
    -- keymap.set('n', 'gd', vim.lsp.buf.definition, opts)

    opts.desc = "Go to Type Definition (LSP)"
    keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
    -- keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)

    opts.desc = "Go to Implementation (LSP)"
    keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
    -- keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)

    opts.desc = "Go to References (LSP)"
    keymap.set("n", "gr", "<cmd>Telescope lsp_references show_line=false<CR>", opts)
    -- keymap.set('n', 'gr', vim.lsp.buf.references, opts)

    opts.desc = "Displays Signature Information"
    keymap.set('n', '<leader>dl', vim.lsp.buf.signature_help, opts)

    opts.desc = "Show available actions"
    keymap.set({ "n", "v" }, "<leader>da", vim.lsp.buf.code_action, opts)

    opts.desc = "Smart Rename"
    keymap.set('n', '<leader>dr', vim.lsp.buf.rename, opts)

    opts.desc = "Format Code"
    keymap.set('n', '<leader>df', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- Substitute
keymap.set("n", "s", function() require('substitute').operator() end, { desc = "Substitute with motion" })
keymap.set("n", "ss", function() require('substitute').line() end, { desc = "Substitute line" })
keymap.set("n", "S", function() require('substitute').eol() end, { desc = "Substitute to end of line" })
keymap.set("x", "s", function() require('substitute').visual() end, { desc = "Substitute in visual mode" })

-- Telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Search for Project Files" })
keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live Search for Grep Results" })
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<CR>", { desc = "Search String under Cursor" })
keymap.set("n", "<leader>fr", "<cmd>Telescope resume<CR>", { desc = "Open the Previous Picker" })
keymap.set("n", "<leader>fs", "<cmd>Telescope spell_suggest<CR>", { desc = "Lists Spelling Suggestions" })
keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Open todos in Telescope" })
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Lists Buffers" })
keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<CR>", { desc = "Lists Keymaps" })
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Lists Available Help Tags" })


-- Diagnostic
-- keymap.set("n", "<leader>dD", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Show Buffer Diagnostics" })
-- keymap.set("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Show Line Diagnostics" })
-- Trouble
keymap.set("n", "<leader>dD", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
keymap.set("n", "<leader>dd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
keymap.set("n", "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
keymap.set("n", "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "LSP Definitions / references / ... (Trouble)" })
keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })
keymap.set("n", "<leader>dqq", ":LspRestart<CR>", { desc = "Restart LSP" })

-- Yanky
keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)", { desc = "Put Before" })
keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)", { desc = "Put After" })
keymap.set("n", "<leader>p", "<cmd>YankyRingHistory<CR>", { desc = "Open Yank History" })


-- ===== UI stuff =====
keymap.set("n", "<leader>ut", "<cmd>lua ToggleBackground()<CR>", { desc = "Toggle Theme" })
keymap.set("n", "<leader>qq", "<cmd>CellularAutomaton make_it_rain<CR>", { desc = "Make it rain" })


-- ===== FUNCTIONS =====
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
  local current_bg = vim.api.nvim_get_option_value("background", {})
  if current_bg == "light" then
    vim.api.nvim_set_option_value("background", "dark", {})
  else
    vim.api.nvim_set_option_value("background", "light", {})
  end
end
