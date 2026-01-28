-- Automatically close and rename HTML/XML tags
-- #code #tags #auto-close
return {
  "windwp/nvim-ts-autotag",
  ft = { "html", "xml", "typescriptreact", "javascriptreact" },
  config = function()
    require("nvim-ts-autotag").setup()
  end
}
