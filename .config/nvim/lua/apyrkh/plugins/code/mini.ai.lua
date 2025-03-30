-- Extend and create a/i textobjects
-- #code #text-editing #productivity
return {
  "echasnovski/mini.ai",
  version = false,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local mini = require("mini.ai")

    mini.setup({

    })
  end,
}
