-- Provides syntax highlighting, indentation, and incremental selection with Treesitter
-- #code #syntax #highlight
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects"
  },
  config = function()
    local treesitter = require("nvim-treesitter.configs")

    treesitter.setup({
      highlight = {
        enable = true
      },
      indent = {
        enable = true
      },
      ensure_installed = {
        "bash",
        "lua",

        "markdown",
        "diff",
        "json",
        "vim",
        "vimdoc",
        "yaml",

        "html",
        "css",
        "scss",

        "javascript",
        "typescript",
        "tsx"
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-]>",
          node_incremental = "<C-]>",
          scope_incremental = false,
          node_decremental = "<BS>",
        },
      }
    })
  end
}
