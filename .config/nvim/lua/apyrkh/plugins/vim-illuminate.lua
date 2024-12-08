return {
  "RRethy/vim-illuminate",
  event = "VeryLazy",
  config = function()
    require("illuminate").configure({
      providers = {
          'lsp',
          'treesitter',
          -- 'regex',
      },
      under_cursor = false,
    })
  end,
}
