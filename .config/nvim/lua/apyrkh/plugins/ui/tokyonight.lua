-- A clean, dark Neovim theme written in Lua
-- #ui #theme
return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    require("tokyonight").setup({
      style = "moon",
      light_style = "day",
    })
    vim.cmd [[colorscheme tokyonight]]
  end,
}
