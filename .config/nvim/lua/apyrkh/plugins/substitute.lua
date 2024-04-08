return {
  "gbprod/substitute.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependenceies = {
    "gbprod/yanky.nvim",
  },
  config = function ()
    require("substitute").setup({
      on_substitute = require("yanky.integration").substitute(),
    })
  end
}
