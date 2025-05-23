local gitsigns = require("gitsigns")
local harpoon = require("harpoon")
local illuminate = require("illuminate")
local nvim_tree_api = require("nvim-tree.api")
local substitute = require("substitute")
local telescope_builtin = require("telescope.builtin")
local telescope_multigrep = require("apyrkh.keymaps.multigrep")
local wk = require("which-key")

-- Tab Management
wk.add({
  mode = "n",
  { "<leader>t",  group = "Tab" },
  { "<leader>tn", "<cmd>tabnew<CR>",      desc = "Open New Tab" },
  { "<leader>tq", "<cmd>tabclose<CR>",    desc = "Close Tab" },
  { "<leader>t[", "<cmd>tabprevious<CR>", desc = "Go to Prev Tab" },
  { "<leader>t]", "<cmd>tabnext<CR>",     desc = "Go to Next Tab" },
})

-- Window Management
wk.add({
  mode = "n",
  { "<C-h>",     "<C-w>h",                      desc = "Go to Left Window" },
  { "<C-j>",     "<C-w>j",                      desc = "Go to Lower Window" },
  { "<C-k>",     "<C-w>k",                      desc = "Go to Upper Window" },
  { "<C-l>",     "<C-w>l",                      desc = "Go to Right Window" },
  { "<S-Down>",  "<cmd>resize -2<cr>",          desc = "Decrease Window Height" },
  { "<S-Up>",    "<cmd>resize +2<cr>",          desc = "Increase Window Height" },
  { "<S-Left>",  "<cmd>vertical resize -2<cr>", desc = "Decrease Window Width" },
  { "<S-Right>", "<cmd>vertical resize +2<cr>", desc = "Increase Window Width" },
})

-- Scrolling
wk.add({
  mode = "n",
  { "<C-u>", "<C-u>zz", desc = "Scroll Up and Center",   remap = true },
  { "<C-d>", "<C-d>zz", desc = "Scroll Down and Center", remap = true },
})

-- Navigation
wk.add({
  mode = "n",
  { "[",  group = "Go Prev" },
  { "]",  group = "Go Next" },
  { "[g", function() gitsigns.nav_hunk("prev", { target = "all" }) end, desc = "Prev Hunk" },
  { "]g", function() gitsigns.nav_hunk("next", { target = "all" }) end, desc = "Next Hunk" },
  { "[h", function() harpoon:list():prev() end,                         desc = "Prev Harpoon File" },
  { "]h", function() harpoon:list():next() end,                         desc = "Next Harpoon File" },
  { "[p", "<Plug>(YankyPreviousEntry)",                                 desc = "Prev Yanky Entry" },
  { "]p", "<Plug>(YankyNextEntry)",                                     desc = "Next Yanky Entry" },
})

-- Line Movement and Indentation
wk.add({
  mode = "v",
  { "<S-j>", ":m '>+1<cr>gv=gv", desc = "Move Line Down" },
  { "<S-k>", ":m '<-2<cr>gv=gv", desc = "Move Line Up" },
  { "<",     "<gv",              desc = "Shift Left" },
  { ">",     ">gv",              desc = "Shift Right" },
})

-- Search Enhancements
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
wk.add({
  {
    mode = "n",
    { "n", "'Nn'[v:searchforward].'zzzv'", desc = "Next Search Result", expr = true },
    { "N", "'nN'[v:searchforward].'zzzv'", desc = "Prev Search Result", expr = true },
  },
  {
    mode = { "x", "o" },
    { "n", "'Nn'[v:searchforward]", desc = "Next Search Result", expr = true },
    { "N", "'nN'[v:searchforward]", desc = "Prev Search Result", expr = true },
  },
  {
    mode = { "i", "n" },
    { "<esc>", "<cmd>noh<cr><esc>", desc = "Clear Result Highlighting" },
  },
})

-- File Explorer (Nvim-Tree)
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

wk.add({
  mode = "n",
  { "<leader>e",   group = "File Explorer" },
  { "<leader>ee",  "<cmd>NvimTreeToggle<CR>",   desc = "Toggle File Explorer" },
  { "<leader>eo",  "<cmd>NvimTreeFindFile<CR>", desc = "Open File" },
  { "<leader>edd", "<cmd>Oil<CR>",              desc = "Open Parent Dir" },
  { "<leader>edf", "<cmd>Oil --float<CR>",      desc = "Open Parent Dir (floating)" },
  {
    "<leader>ef",
    function()
      local cwd = get_nvim_tree_cwd()
      if cwd then
        telescope_builtin.find_files({ cwd = cwd })
      end
    end,
    desc = "Search Files in Current Dir"
  },
  {
    "<leader>eg",
    function()
      local cwd = get_nvim_tree_cwd()
      if cwd then
        telescope_builtin.live_grep({ cwd = cwd })
      end
    end,
    desc = "Search Text in Current Dir"
  },
})

-- Gitsigns
wk.add({
  mode = "n",
  { "<leader>g",  group = "Git" },
  { "<leader>gb", function() vim.cmd("BlameToggle virtual") end, desc = "Blame File (Virtual)" },
  { "<leader>gB", function() vim.cmd("BlameToggle") end,         desc = "Blame File (Window)" },
  { "<leader>gs", function() gitsigns.stage_hunk() end,          desc = "Stage Hunk" },
  { "<leader>gu", function() gitsigns.undo_stage_hunk() end,     desc = "Unstage Hunk" },
  { "<leader>gx", function() gitsigns.reset_hunk() end,          desc = "Reset Hunk" },
  { "<leader>gp", function() gitsigns.preview_hunk() end,        desc = "Preview Hunk" },
  { "<leader>gd", function() gitsigns.diffthis("~1") end,        desc = "Diff Hunk" },
  { "<leader>gg", function() vim.cmd("Neogit") end,              desc = "Open Neogit" },
})

-- Harpoon
function HarpoonFile() harpoon:list():add() end

function HarpoonQuickMenu() harpoon.ui:toggle_quick_menu(harpoon:list()) end

function HarpoonOpenFile(i) harpoon:list():select(i) end

wk.add({
  mode = "n",
  { "<leader>h",  group = "Harpoon" },
  { "<leader>ha", function() HarpoonFile() end,      desc = "Harpoon File" },
  { "<leader>hh", function() HarpoonQuickMenu() end, desc = "Harpoon Quick Menu" },
  { "<leader>1",  function() HarpoonOpenFile(1) end, desc = "Harpoon to File 1" },
  { "<leader>2",  function() HarpoonOpenFile(2) end, desc = "Harpoon to File 2" },
  { "<leader>3",  function() HarpoonOpenFile(3) end, desc = "Harpoon to File 3" },
  { "<leader>4",  function() HarpoonOpenFile(4) end, desc = "Harpoon to File 4" },
  { "<leader>5",  function() HarpoonOpenFile(5) end, desc = "Harpoon to File 5" },
  { "<leader>6",  function() HarpoonOpenFile(6) end, desc = "Harpoon to File 6" },
  { "<leader>7",  function() HarpoonOpenFile(7) end, desc = "Harpoon to File 7" },
  { "<leader>8",  function() HarpoonOpenFile(8) end, desc = "Harpoon to File 8" },
  { "<leader>9",  function() HarpoonOpenFile(9) end, desc = "Harpoon to File 9" },
  { "<leader>0",  function() HarpoonOpenFile(0) end, desc = "Harpoon to File 0" },
})

-- LSP
local opts = { noremap = true, silent = true }
wk.add({
  mode = "n",
  { "<leader>d",   desc = "LSP" },
  { "<leader>df",  function() vim.lsp.buf.format { async = true } end,        opts, desc = "Format Code" },
  { "<leader>dd",  "<cmd>Telescope lsp_definitions<CR>",                      opts, desc = "Go to Definition (LSP)" },
  { "<leader>dt",  "<cmd>Telescope lsp_type_definitions<CR>",                 opts, desc = "Go to Type Definition (LSP)" },
  { "<leader>d[",  function() illuminate.goto_prev_reference("wrapscan") end, opts, desc = "Prev Reference" },
  { "<leader>d]",  function() illuminate.goto_next_reference("wrapscan") end, opts, desc = "Next Reference" },
  { "<leader>dqq", ":LspRestart<CR>",                                         opts, desc = "Restart LSP" },
})

-- Substitute/Surround
-- Surround
-- "sa", desc = "add"
-- "sd", desc = "delete"
-- "sr", desc = "replace"
-- "sf", desc = "find"
-- "sh", desc = "highlight"
wk.add({
  {
    mode = "n",
    { "s",  function() substitute.operator() end, desc = "Substitute with Motion" },
    { "ss", function() substitute.line() end,     desc = "Substitute Line" },
    { "S",  function() substitute.eol() end,      desc = "Substitute to EOL" },
  },
  {
    mode = "x",
    { "s", function() substitute.visual() end, desc = "Substitute in Visual Mode" },
  },
})

-- Yanky
wk.add({
  {
    mode = "n",
    { "<leader>p", function() vim.cmd("YankyRingHistory") end, desc = "Search Yank History" },
  },
  {
    mode = { "n", "x" },
    { "P", "<Plug>(YankyPutBefore)", desc = "Put Before" },
    { "p", "<Plug>(YankyPutAfter)",  desc = "Put After" },
  },
})

-- Telescope
wk.add({
  {
    mode = "n",
    { "<leader>f",  group = "Search (Telescope)" },
    { "<leader>ff", "<cmd>Telescope find_files<CR>",    desc = "Search Files" },
    { "<leader>fg", telescope_multigrep,                desc = "Search Text" },
    { "<leader>fc", "<cmd>Telescope grep_string<CR>",   desc = "Search Text Under Cursor" },
    { "<leader>fr", "<cmd>Telescope resume<CR>",        desc = "Resume Search" },
    { "<leader>fs", "<cmd>Telescope spell_suggest<CR>", desc = "Search Spelling Suggestions" },
    { "<leader>fb", "<cmd>Telescope buffers<CR>",       desc = "Search Buffers" },
    { "<leader>fk", "<cmd>Telescope keymaps<CR>",       desc = "Search Keymaps" },
    { "<leader>fh", "<cmd>Telescope help_tags<CR>",     desc = "Search Help Tags" },
    { "<leader>ft", "<cmd>TodoTelescope<CR>",           desc = "Search TODOs" },
  },
  {
    mode = "v",
    { "<leader>fg", "yf<ESC>:Telescope live_grep default_text=<c-r>0<CR>", opts, desc = "Search Text" },
  }
})

-- Diagnostic
wk.add({
  mode = "n",
  { "<leader>x",  group = "Trouble" },
  { "<leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "Toggle File Diagnostics (Trouble)" },
  { "<leader>xX", "<cmd>Trouble diagnostics toggle<cr>",                        desc = "Toggle All Diagnostics (Trouble)" },
  { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>",                desc = "Toggle Document Symbols (Trouble)" },
  { "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "Toggle References (Trouble)" },
  { "<leader>xL", "<cmd>Trouble loclist toggle<cr>",                            desc = "Toggle Location List (Trouble)" },
  { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",                             desc = "Toggle Quickfix List (Trouble)" },
})

-- Auto-Session
wk.add({
  mode = "n",
  { "<leader>w",  group = "Sessions" },
  { "<leader>ww", "<cmd>SessionSave<CR>",          desc = "Save Session" },
  { "<leader>wr", "<cmd>SessionRestore<CR>",       desc = "Restore Session" },
  { "<leader>wo", "<cmd>Autosession search<CR>",   desc = "List Saved Sessions" },
  { "<leader>wd", "<cmd>Autosession delete<CR>",   desc = "Delete Saved Sessions" },
  { "<leader>wD", "<cmd>SessionPurgeOrphaned<CR>", desc = "Purge All Orphaned Session" },
})

-- UI stuff
function ToggleBackground()
  local current_bg = vim.api.nvim_get_option_value("background", {})
  vim.api.nvim_set_option_value("background", current_bg == "light" and "dark" or "light", {})
end

wk.add({
  mode = "n",
  { "<leader>u",  group = "UI Settings" },
  { "<leader>ut", ToggleBackground,                                         desc = "Toggle Theme" },
  { "<leader>uq", function() vim.cmd("CellularAutomaton make_it_rain") end, desc = "Make It Rain" },
})
