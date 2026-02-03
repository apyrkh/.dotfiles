return {
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
    opts = {
      -- TODO: use <leader>
      -- mappings = {
      --   start = 'ga',
      --   start_with_preview = 'gA',
      -- },
    },
  },
  {
    'nvim-mini/mini.comment',
    version = false,
    keys = {
      { "gc",  mode = { "n", "x" } },
      { "gcc", mode = { "n", "x" } }
    },
    opts = {
      -- TODO: use <leader>
      -- mappings = {
      --   comment = 'gc',
      --   comment_line = 'gcc',
      --   comment_visual = 'gc',
      --   textobject = 'gc',
      -- },
    }
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
  -- TODO: consider ultimate-autopair.nvim if mini.pais does not work well
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
  {
    "gbprod/yanky.nvim",
    keys = {
      { "P",          "<Plug>(YankyPutBefore)",                   desc = "Put Before",      mode = { "n", "x" } },
      { "p",          "<Plug>(YankyPutAfter)",                    desc = "Put After",       mode = { "n", "x" } },
      { "<leader>pp", function() vim.cmd("YankyRingHistory") end, desc = "Yank History" },
      { "<leader>p[", "<Plug>(YankyPreviousEntry)",               desc = "Prev Yanky Entry" },
      { "<leader>p]", "<Plug>(YankyNextEntry)",                   desc = "Next Yanky Entry" },
    },
    opts = {
      ring = {
        history_length = 50,
        storage = "memory",
        update_register_on_cycle = true,
      },
    },
  },
}
