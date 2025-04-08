-- Configuration for LSP servers using nvim-lspconfig
-- #lsp #lspconfig
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-telescope/telescope.nvim",
    { "antosha417/nvim-lsp-file-operations", config = true },
    "b0o/schemastore.nvim",
  },
  config = function()
    local lspconfig = require("lspconfig")

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

    lspconfig["prismals"].setup({})

    -- vim.api.nvim_create_autocmd("LspAttach", {
    --   callback = function(args)
    --     vim.api.nvim_create_autocmd("BufWritePre", {
    --       buffer = args.buf,
    --       callback = function()
    --         vim.lsp.buf.format({
    --           bufnr = args.buf,
    --           filter = function(client) return client.name == "biome" end,
    --         })
    --       end
    --     })
    --   end
    -- })

    -- vim.api.nvim_create_autocmd("LspAttach", {
    --   callback = function(args)
    --     -- Unset 'omnifunc'
    --     vim.bo[args.buf].omnifunc = nil
    --
    --     local client = vim.lsp.get_client_by_id(args.data.client_id)
    --     if not client then return end
    --
    --     if client:supports_method("textDocument/formatting") then
    --       vim.api.nvim_create_autocmd("BufWritePre", {
    --         buffer = args.buf,
    --         callback = function()
    --           vim.lsp.buf.format({
    --             id = client.id,
    --             bufnr = args.buf,
    --           })
    --         end
    --       })
    --     end
    --   end,
    -- })
  end,
}
