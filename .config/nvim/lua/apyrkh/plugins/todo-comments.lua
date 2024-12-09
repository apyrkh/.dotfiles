-- Highlight, list, and search todo comments across the codebase
-- #todo-comments #search #productivity
-- FIX:
-- TODO:
-- HACK:
-- WARN: 
-- PERF:
-- NOTE:
-- TEST:
return {
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    search = {
      command = "rg",
      args = {
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--hidden", -- added line
      },
      -- regex that will be used to match keywords.
      -- don't replace the (KEYWORDS) placeholder
      pattern = [[\b(KEYWORDS):]], -- ripgrep regex
    },
  }
}
