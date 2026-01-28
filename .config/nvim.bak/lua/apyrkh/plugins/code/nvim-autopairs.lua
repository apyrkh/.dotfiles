-- Automatically closes, pairs, and integrates with completion plugins to streamline coding in Neovim
-- #code #autocompletion #productivity
return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    local autopairs = require("nvim-autopairs")

    autopairs.setup({
      check_ts = true, -- Enable treesitter
      ts_config = {
        lua = { "string" }, -- Skip pairs in Lua string nodes
        javascript = { "template_string" }, -- Skip pairs in JavaScript template strings
      },
    })
  end,
}
