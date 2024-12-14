-- Highlight occurrences of the word under cursor across the file
-- #code #highlight #productivity
return {
  "RRethy/vim-illuminate",
  event = "VeryLazy",
  config = function()
    require("illuminate").configure({
      providers = {
        "lsp",
        "treesitter",
        -- "regex",
      },
      under_cursor = false,
      large_file_cutoff = 1000,
    })
  end,
}
