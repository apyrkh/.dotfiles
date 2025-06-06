return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'saghen/blink.cmp',
    { "antosha417/nvim-lsp-file-operations", config = true },
    "b0o/schemastore.nvim",
  },

  -- example using `opts` for defining servers
  -- opts = {
  --   servers = {
  --     lua_ls = {}
  --   }
  -- },
  -- config = function(_, opts)
  --   local lspconfig = require('lspconfig')
  --   for server, config in pairs(opts.servers) do
  --     -- passing config.capabilities to blink.cmp merges with the capabilities in your
  --     -- `opts[server].capabilities, if you've defined it
  --     config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
  --     lspconfig[server].setup(config)
  --   end
  -- end

  -- example calling setup directly for each LSP
  config = function()
    local lspconfig = require('lspconfig')

    local original_capabilities = vim.lsp.protocol.make_client_capabilities()
    local capabilities = require('blink.cmp').get_lsp_capabilities(original_capabilities)

    vim.lsp.config('*', {
      capabilities = capabilities,
    })

    -- lspconfig['lua_ls'].setup({ capabilities = capabilities })
    -- Change the Diagnostic symbols in the sign column (gutter)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    lspconfig["bashls"].setup({})

    lspconfig["lua_ls"].setup({
      settings = { -- custom settings for lua
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            -- make language server aware of runtime files
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })

    lspconfig["biome"].setup({})

    lspconfig["jsonls"].setup({
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    })

    lspconfig["html"].setup({})

    lspconfig["cssls"].setup({})

    lspconfig["cssmodules_ls"].setup({
      init_options = {
        camelCase = "dashes",
      },
    })

    lspconfig["css_variables"].setup({})

    lspconfig["emmet_ls"].setup({
      filetypes = {
        "html",
        "typescriptreact",
        "javascriptreact",
        "css",
        --"less",
        --"sass",
        "scss",
      },
    })

    lspconfig["ts_ls"].setup({
      settings = {
        tsserver = {
          preferences = {
            quotePreference = "single",
          },
        },
      },
    })

    lspconfig["graphql"].setup({})
  end
}
