-- Adds customizable indentation guides to Neovim for better code readability
-- #code #indentation #readability
return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPre", "BufNewFile" },
  main = "ibl",
  opts = {
    indent = { char = "┊" },
    scope = { enabled = true }, -- Highlight current context
    exclude = { -- Disable in certain file types
      filetypes = { "help", "terminal", "dashboard" },
    },
  },
}
