-- Easily comment code with support for language-aware commenting using Treesitter context
-- #code #commenting #code-editing
vim.g.skip_ts_context_commentstring_module = true -- Skip backwards compatibility routines

return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    local comment = require("Comment")
    local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

    comment.setup({
      pre_hook = ts_context_commentstring.create_pre_hook(),
    })
  end,
}
