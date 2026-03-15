return {
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    cmd = "Copilot",
    keys = {
      {
        "<Tab>",
        function()
          local suggestion = require("copilot.suggestion")
          if suggestion.is_visible() then
            suggestion.accept()
            -- expr=true must return a string
            return ""
          end
          return vim.api.nvim_replace_termcodes("<Tab>", true, true, true)
        end,
        mode = "i",
        expr = true,
        silent = true,
        desc = "Copilot Smart Accept",
      },
      {
        "<leader>ct",
        function()
          local client = require("copilot.client")
          local enabled = not client.is_disabled()

          vim.cmd(enabled and "Copilot disable" or "Copilot enable")
          vim.notify("Copilot " .. (enabled and "disabled" or "enabled"))
        end,
        desc = "Toggle Copilot",
      },
      { "<leader>cs", "<cmd>Copilot status<cr>", desc = "Copilot Status" },
    },
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = false, -- Handled by custom LUA function
          accept_word = "<M-Right>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<S-Tab>",
        },
      },
      panel = { enabled = false },
    },
  },
  {
    "yetone/avante.nvim",
    version = false,
    build = "make",
    event = "VeryLazy",
    -- Note: copilot.lua is no longer a hard dependency here
    -- because it's already defined above
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      -- Optional
      "ibhagwan/fzf-lua",
      "folke/snacks.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      provider = "copilot",
      behaviour = {
        auto_suggestions = false, -- handled by copilot.lua
        auto_apply_diff_after_generation = true,
      },
      input = {
        provider = "snacks",
      },
    },
    keys = {
      { "<leader>aa", "<cmd>AvanteAsk<cr>",     desc = "Avante: Ask (Chat)" },
      { "<leader>ae", "<cmd>AvanteEdit<cr>",    desc = "Avante: Edit (Selection)", mode = { "n", "v" } },
      { "<leader>ar", "<cmd>AvanteRefresh<cr>", desc = "Avante: Refresh Context" },
    },
  },
}
