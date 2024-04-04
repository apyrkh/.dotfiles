local get_mappings = function()
  local actions = require("telescope.actions")

  return {
    i = {
      ["<C-k>"] = actions.move_selection_previous,
      ["<C-j>"] = actions.move_selection_next,
    }
  }
end

local set_keymaps = function()
  local keymap = vim.keymap
  local builtin = require('telescope.builtin')

  local telescopeConfig = require("telescope.config")
  local vimgrep_arguments = telescopeConfig.values.vimgrep_arguments;

  -- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#falling-back-to-find_files-if-git_files-cant-find-a-git-directory
  local project_files = function()
    local ok = pcall(builtin.git_files, vimgrep_arguments);
    if not ok then
      builtin.find_files(vimgrep_arguments)
    end
  end

  keymap.set('n', '<leader>fd', project_files, { desc = 'Fuzzy search git files (or project files)' })
  keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Fuzzy search git files (or project files)' })
  keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Searches for the string' })
  keymap.set('n', '<leader>fr', builtin.resume, { desc = 'List results of the previous picker' })
  keymap.set('n', '<leader>fs', builtin.spell_suggest, { desc = 'Lists spelling suggestions' })
  keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Lists available help tags' })
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

    set_keymaps()
  end
}
