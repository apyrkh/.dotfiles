-- Fast and feature-rich surround actions
-- #code #text-editing #productivity
return {
  "echasnovski/mini.surround",
  version = false,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local mini = require('mini.surround')

    mini.setup({

    })
  end,
}
