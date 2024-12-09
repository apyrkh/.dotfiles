-- Automatically closes, pairs, and integrates with completion plugins to streamline coding in Neovim
-- #code #autocompletion #productivity
return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/nvim-cmp",
  },
  config = function()
    local autopairs = require("nvim-autopairs")

    autopairs.setup({
      check_ts = true, -- Enable treesitter
      ts_config = {
        lua = { "string" }, -- Skip pairs in Lua string nodes
        javascript = { "template_string" }, -- Skip pairs in JavaScript template strings
      },
    })

    -- Integrate with nvim-cmp: make autopairs and completion work together
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}
