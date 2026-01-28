-- Displays git blame information directly in the editor for quick insights
-- #vcs #git #blame
return {
  "FabijanZulj/blame.nvim",
  config = function()
    require("blame").setup({
      date_format = "%Y.%m.%d %H:%M",
      relative_date_if_recent = false,
    })
  end
}
