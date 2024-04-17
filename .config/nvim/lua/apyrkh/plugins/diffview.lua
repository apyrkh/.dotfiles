return {
  "sindrets/diffview.nvim",
  config = function ()
    require("diffview").setup({
      signs = {
        fold_closed = "",
        fold_open = "",
        done = "✓",
      },
    })
  end
}
