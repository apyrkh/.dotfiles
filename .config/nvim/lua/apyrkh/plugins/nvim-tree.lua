-- A file explorer tree for neovim written in lua
local set_keymaps = function()
  local keymap = vim.keymap
  local api = require "nvim-tree.api"
  local select_opened_file = function()
    api.tree.open({ find_file = true })
  end

  keymap.set("n", "<leader>ee", api.tree.toggle, { desc = "Toggle file explorer" })
  keymap.set("n", "<leader>er", api.tree.reload, { desc = "Refresh file explorer" })
  keymap.set("n", "<leader>eo", select_opened_file, { desc = "Select opened file" })
end

return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  config = function()
    local nvimtree = require("nvim-tree")

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- configure nvim-tree
    nvimtree.setup({
      view = {
        width = 35,
        relativenumber = true,
      },
      -- change folder arrow icons
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "", -- arrow when folder is closed
              arrow_open = "", -- arrow when folder is open
            },
          },
        },
      },
      -- disable window_picker for
      -- explorer to work well with
      -- window splits
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      filters = {
        custom = { ".DS_Store" },
      },
      git = {
        ignore = false,
      },
    })

    set_keymaps()
  end,
}
