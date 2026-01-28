-- Provides a Git diff UI for Neovim, with features like file history and branch comparison
-- #vcs #git #diff #ui
return {
  "sindrets/diffview.nvim",
  config = function ()
    require("diffview").setup({
      enhanced_diff_hl = true, -- Highlight word-level changes in diffs
      signs = {
        fold_closed = "",
        fold_open = "",
        done = "✓",
      },
    })
  end
}
