return {
  "echasnovski/mini.ai",
  version = "*",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local mini = require('mini.ai')

    mini.setup({

    })
  end,
}
