return {
  { "mason-org/mason.nvim", opts = {} },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
    },
    opts = {
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
    },
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "alexandre-abrioux/blink-cmp-npm.nvim",
    },
    version = "1.*",
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
      "saghen/blink.cmp"
    },
    config = function()
      local servers = {
        "lua_ls",

        "ts_ls",
      }

      for _, server in ipairs(servers) do
        local opts = require("lsp.servers." .. server)

        opts.capabilities = require('blink.cmp').get_lsp_capabilities(opts.capabilities)

        vim.lsp.config(server, opts)
      end
    end,
  },
}
