return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    keys = {
      {
        "<leader>df",
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
          enabled = true,
          show_without_menu = false,
        },
        list = {
          max_items = 30,
        },
        menu = {
          auto_show = false,
          enabled = true,
          max_height = 22,
          scrollbar = false,
        },
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
        keymap = {
          preset = "cmdline",
          ["C-<space>"] = {},
          ["<C-p>"] = {},
          ["<C-n>"] = {},
          ["<C-e>"] = { "show", "hide" },
          ["<C-k>"] = { "select_prev", "fallback" },
          ["<C-j>"] = { "select_next", "fallback" },
        },
        completion = {
          ghost_text = {
            enabled = true
          },
          menu = { auto_show = true },
        },
      },
    },
    opts_extend = { "sources.default" }
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "mason-org/mason-lspconfig.nvim",
      "saghen/blink.cmp"
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local mlsp = require("mason-lspconfig")
      mlsp.setup({
        ensure_installed = {
          "bashls",
          "lua_ls",
          --"vimls",

          --"markdown_oxide",
          "jsonls",
          --"yamlls",

          "html",
          "cssls",
          "cssmodules_ls",
          "css_variables",
          "emmet_ls",

          "ts_ls",
          "biome",

          "graphql",
          -- "prismals",
        },
      })

      local servers = {
        "lua_ls",

        "ts_ls",
      }

      for _, server in ipairs(servers) do
        local opts = require("lsp.servers." .. server)

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
  }
}
