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
      filetypes = {
        ["*"] = true,
        gitcommit = true,
        NeogitCommitMessage = true,
      },
      should_attach = function(buf_id)
        local bt = vim.bo[buf_id].buftype
        local ft = vim.bo[buf_id].filetype

        -- allow git commit buffers (Neogit)
        if ft == "gitcommit" then
          return true
        end

        if not vim.bo[buf_id].buflisted then
          vim.notify("not attaching, buffer is not 'buflisted'", vim.log.levels.DEBUG)
          return false
        end

        if bt ~= "" then
          vim.notify("not attaching, buffer 'buftype' is " .. bt, vim.log.levels.DEBUG)
          return false
        end

        return true
      end,
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
      providers = {
        -- https://docs.github.com/ru/copilot/concepts/billing/copilot-requests
        copilot = {
          model = "gpt-4.1", -- Primary for daily coding & refactoring
          -- model = "gpt-5.1-codex-mini", -- Toggle for Planning/Architecture (Smart & Slow)
          -- model = "gpt-4o",             -- Better for analysis & docs
          -- model = "gpt-5-mini",         -- Advanced reasoning & architecture
          extra_request_body = {
            max_tokens = 4096,
          },
        },
        -- @TODO: add open router support with free models
      },
      behaviour = {
        auto_suggestions = false, -- handled by copilot.lua
        -- auto_apply_diff_after_generation = true,
      },
      -- input = {
      --   --- @type avante.InputProvider
      --   provider = "snacks",
      --   provider_opts = {
      --     -- Additional snacks.input options
      --     title = "Avante Input",
      --     icon = " ",
      --   },
      -- },
      -- selector = {
      --   --- @type avante.SelectorProvider
      --   provider = "snacks",
      --   provider_opts = {},
      -- },
    },
    keys = {
      { "<leader>aa", "<cmd>AvanteAsk<cr>",     desc = "Avante: Ask (Chat)" },
      { "<leader>ae", "<cmd>AvanteEdit<cr>",    desc = "Avante: Edit (Selection)", mode = { "n", "v" } },
      { "<leader>ar", "<cmd>AvanteRefresh<cr>", desc = "Avante: Refresh Context" },
    },
  },
}
