-- Telescope for fuzzy file finding, search, and navigation
-- #navigation #search #telescope
return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- improve telescope sorting performance
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
          }
        },
        find_command = {
          "fd",
          ".",
          "--type", "f",
          "--follow",
          "--hidden",
          "--exclude", ".git",
        },
      },
      pickers = {
        buffers = {
          sort_mru = true,
          ignore_current_buffer = true,
          mappings = {
            i = {
              ["<C-d>"] = "delete_buffer",
            },
          },
        },
        extentions = {
          fzf = {},
        },
        spell_suggest = {
          theme = "cursor"
        },
      },
    })

    telescope.load_extension("fzf")
  end
}
