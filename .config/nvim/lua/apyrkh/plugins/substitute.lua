-- A Neovim plugin for fast, intuitive text substitution with yank integration
-- #text-substitution #productivity
return {
  "gbprod/substitute.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "gbprod/yanky.nvim",
  },
  config = function ()
    require("substitute").setup({
      on_substitute = require("yanky.integration").substitute(),
    })
  end
}
