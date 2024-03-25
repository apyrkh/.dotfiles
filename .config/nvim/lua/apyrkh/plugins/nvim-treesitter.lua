local get_keymaps = function()
  return {
    init_selection = "<C-]>",
    node_incremental = "<C-]>",
    scope_incremental = "<C-]>",
    node_decremental = "<C-[>"
  }
end

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
        keymaps = get_keymaps(),
      }
    })
  end
}
