local get_keymaps = function()
  return {
    init_selection = "<C-w>",
    node_incremental = "<C-w>",
    scope_incremental = "<C-w>",
    node_decremental = "<C-S-w>"
  }
end

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
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
