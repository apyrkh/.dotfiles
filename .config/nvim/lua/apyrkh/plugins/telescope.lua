local get_mappings = function()
  local actions = require("telescope.actions")

  return {
    i = {
      ["<C-k>"] = actions.move_selection_previous,
      ["<C-j>"] = actions.move_selection_next,
    }
  }
end

-- REQUIRES: brew install ripgrep
return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    -- lua functions for telescope
    "nvim-lua/plenary.nvim",

    -- improve telescope sorting performance
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

    -- dev icons for telescope
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local telescopeConfig = require("telescope.config")

    -- Clone the default Telescope configuration
    local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

    -- I want to search in hidden/dot files.
    table.insert(vimgrep_arguments, "--hidden")
    -- I don't want to search in the `.git` directory.
    table.insert(vimgrep_arguments, "--glob")
    table.insert(vimgrep_arguments, "!**/.git/*")

    telescope.setup({
      defaults = {
        mappings = get_mappings(),

        -- `hidden = true` is not supported in text grep commands.
        vimgrep_arguments = vimgrep_arguments,
      },
      pickers = {
        find_files = {
          -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
        spell_suggest = {
          theme = "cursor"
        }
      },
    })

    telescope.load_extension("fzf")
  end
}
