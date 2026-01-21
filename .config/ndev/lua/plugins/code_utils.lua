vim.g.skip_ts_context_commentstring_module = true -- Skip backwards compatibility routines

return {
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    init = function()
      -- Avoid legacy setup
      vim.g.skip_ts_context_commentstring_module = true
    end,
    config = function()
      require("Comment").setup({
        pre_hook = require(
          "ts_context_commentstring.integrations.comment_nvim"
        ).create_pre_hook(),
      })
    end,
  },
}
