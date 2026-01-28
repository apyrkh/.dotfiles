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

    telescope.setup({
      defaults = {
        file_ignore_patterns = {
          "%.DS_Store",
          "%.git"
        }
      },
      pickers = {
        buffers = {
          sort_mru = true,
          ignore_current_buffer = true,
          mappings = {
            i = {
              ["<S-d>"] = "delete_buffer",
            },
          },
        },
        extentions = {
          fzf = {},
        },
        find_files = {
          find_command = { "fd", "--type", "f", "--follow", "--hidden" }
        },
        spell_suggest = {
          theme = "cursor"
        },
      },
    })

    telescope.load_extension("fzf")
  end
}
