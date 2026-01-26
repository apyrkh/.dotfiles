return {
  -- {
  --   "numToStr/Comment.nvim",
  --   dependencies = {
  --     { "JoosepAlviste/nvim-ts-context-commentstring", opts = { enable_autocmd = false } },
  --   },
  --   keys = {
  --     { "gc",  mode = { "n", "x" }, desc = "Comment toggle linewise" },
  --     { "gcc", mode = { "n", "x" }, desc = "Comment toggle linewise" },
  --     { "gb",  mode = { "n", "x" }, desc = "Comment toggle blockwise" },
  --     { "gbb", mode = { "n", "x" }, desc = "Comment toggle blockwise" },
  --   },
  --   init = function()
  --     -- Avoid legacy setup
  --     vim.g.skip_ts_context_commentstring_module = true
  --   end,
  --   config = function()
  --     require("Comment").setup({
  --       pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
  --     })
  --   end,
  -- },
  {
    "nvim-mini/mini.ai",
    version = false,
    event = { "BufReadPre", "BufNewFile" },
    opts = { n_lines = 200 },
  },
  {
    "nvim-mini/mini.align",
    version = false,
    keys = {
      { "ga", mode = { "n", "x" } },
      { "gA", mode = { "n", "x" } }
      -- "ga" - start
      -- "gA" - start with preview
      --    "s" - split, e.g. "s_<CR>"
      --        special "=", ",", "|", "<Space>"
      --    "j" - justify, e.g. "_jr"
      --    "m" - merge, e.g. "_m--<CR>"
      --    "f" - filter
      --    "i" - ignore
      --    "p" - pair
      --    "t" - trim
    },
    opts = {},
  },
  {
    "nvim-mini/mini.operators",
    version = false,
    keys = {
      { "g=", mode = { "n", "x" } },
      { "gx", mode = { "n", "x" } },
      { "gm", mode = { "n", "x" } },
      { "gr", mode = { "n", "x" } },
      { "gs", mode = { "n", "x" } },
      -- "g=" - evaluate text and replace with result, e.g. "g=iw"
      -- "gx" - exchange text, e.g. "gxiw"
      -- "gm" - multiply text, e.g. "gmiw"
      -- "gr" - replace with register, e.g. "griw"
      -- "gs" - sort text
    },
    opts = {},
  },
  {
    "nvim-mini/mini.pairs",
    version = false,
    event = "InsertEnter",
    opts = {},
  },
  {
    "nvim-mini/mini.surround",
    version = false,
    keys = {
      { "sa", mode = { "n", "x" } },
      { "sd", mode = { "n", "x" } },
      { "sr", mode = { "n", "x" } },
      { "sf", mode = { "n", "x" } },
      { "sh", mode = { "n", "x" } },
      -- "sa" - "add", e.g. "saiw"
      -- "sd" - "delete", e.g. "sd"
      -- "sr" - "replace", e.g. "sr"
      -- "sf" - "find"
      -- "sh" - "highlight"
    },
    opts = {},
  },
}
