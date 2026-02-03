return {
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",                        desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>",                desc = "Symbols (Trouble)" },
      { "<leader>xr", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions/references (Trouble)" },
      { "<leader>xl", "<cmd>Trouble loclist toggle<cr>",                            desc = "Location List (Trouble)" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<cr>",                             desc = "Quickfix List (Trouble)" },
    },
    opts = {}, -- for default options, refer to the configuration section for custom setup.
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        desc = "Format File (Conform)",
      },
    },
    opts = {
      format_on_save = false,
      -- format_on_save = {
      --   lsp_format = "fallback", -- fallback to LSP formatter if no formatter
      --   timeout_ms = 500,
      -- },

      formatters_by_ft = {
        javascript      = { "biome", "eslint_d", "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "biome", "eslint_d", "prettierd", "prettier", stop_after_first = true },
        typescript      = { "biome", "eslint_d", "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "biome", "eslint_d", "prettierd", "prettier", stop_after_first = true },

        json            = { "biome", "prettierd", "prettier", stop_after_first = true },
        jsonc           = { "biome", "prettierd", "prettier", stop_after_first = true },

        css             = { "biome", "prettierd", "prettier", stop_after_first = true },
        scss            = { "biome", "prettierd", "prettier", stop_after_first = true },
        html            = { "biome", "prettierd", "prettier", stop_after_first = true },

        markdown        = { "prettierd", "prettier", stop_after_first = true },

        ["_"]           = { "lsp" },
      },
    },
  },
  {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "alexandre-abrioux/blink-cmp-npm.nvim",
    },
    event = { "InsertEnter", "CmdlineEnter" },
    opts = {
      completion = {
        ghost_text = {
          enabled = false,
          show_without_menu = false,
        },
        list = {
          max_items = 30,
          selection = { preselect = false, auto_insert = false },
        },
        menu = {
          enabled = true,
          -- auto_show = false,
          max_height = 22,
          direction_priority = { 'n', 's' },
          -- direction_priority = { 'n' },
          -- scrollbar = false,
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 10,
        }
      },

      fuzzy = { implementation = "prefer_rust_with_warning" },

      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = {
        preset = "default",
        ["C-<space>"] = {},
        ["<C-p>"] = {},
        ["<C-n>"] = {},
        ["<C-e>"] = { "show", "hide" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
      },

      signature = {
        enabled = true,
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { "lsp", "snippets", "buffer", "path", "npm" },
        providers = {
          npm = { name = "npm", module = "blink-cmp-npm", async = true },
        },
      },

      cmdline = {
        completion = {
          ghost_text = {
            enabled = true
          },
          menu = { auto_show = true },
        },
        keymap = {
          preset = "cmdline",
          ["<CR>"] = { "accept_and_enter", "fallback" },
          ["C-<space>"] = {},
          ["<C-p>"] = {},
          ["<C-n>"] = {},
          ["<C-e>"] = { "show", "hide" },
          ["<C-k>"] = { "select_prev", "fallback" },
          ["<C-j>"] = { "select_next", "fallback" },
        },
      },
    },
    opts_extend = { "sources.default" }
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "saghen/blink.cmp",
      "b0o/schemastore.nvim",
    },
    cmd = { "Mason", "LspInfo" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lsp_config = require("lsp")
      local ensure_installed = vim.tbl_keys(lsp_config)

      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = ensure_installed,
      })

      for server, opts in pairs(lsp_config) do
        opts.capabilities = require("blink.cmp").get_lsp_capabilities(opts.capabilities)

        vim.lsp.config(server, opts)
      end
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    version = "v0.10.0",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = {
          "bash",
          "lua",
          -- "vim",
          -- "vimdoc",

          -- "markdown",
          "diff",
          "json",
          "yaml",

          "html",
          "css",
          "scss",

          "javascript",
          "typescript",
          "tsx",
        },
        incremental_selection = {
          enable = true,
        },
      })
    end
  },
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "javascriptreact", "typescriptreact", "xml" },
    event = "InsertEnter",
    opts = {},
  },
}
