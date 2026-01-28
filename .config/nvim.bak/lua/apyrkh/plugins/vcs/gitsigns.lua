-- Shows git changes in the sign column and provides Git-related utilities
-- $vcs #git #diff
return {
  "lewis6991/gitsigns.nvim",
  event = "VeryLazy",
  opts = {
    current_line_blame = true, -- Inline blame for the current line
    current_line_blame_opts = {
      delay = 1000, -- Delay before showing blame
      virt_text_pos = "eol", -- Place blame text at the end of the line
    },
  },
}
