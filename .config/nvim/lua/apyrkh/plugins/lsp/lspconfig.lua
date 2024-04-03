return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local keymap = vim.keymap -- for conciseness

    local opts = { noremap = true, silent = true }
    local on_attach = function(_, bufnr)
      opts.buffer = bufnr

      opts.desc = "[g]o to [d]efinition (LSP)"
      keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

      opts.desc = "[g]o to [t]ype definition (LSP)"
      keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

      opts.desc = "[g]o to [i]mplementation (LSP)"
      keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

      opts.desc = "[g]o to [r]eferencies (LSP)"
      keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

      opts.desc = "Show documentation for what is under cursor"
      keymap.set("n", "<leader>dk", vim.lsp.buf.hover, opts)

      opts.desc = "Show available actions"
      keymap.set({ "n", "v" }, "<leader>da", vim.lsp.buf.code_action, opts)

      opts.desc = "Smart Rename"
      keymap.set("n", "<leader>dr", vim.lsp.buf.rename, opts) -- smart rename

      opts.desc = "Restart LSP"
      keymap.set("n", "<leader>dqq", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
    end

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Change the Diagnostic symbols in the sign column (gutter)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
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

    --lspconfig["jsonls"].setup({
    --  capabilities = capabilities,
    --  on_attach = on_attach,
    --  settings = {
    --    json = {
    --      schemas = require('schemastore').json.schemas(),
    --    },
    --  },
    --})

    lspconfig["html"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["cssls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["cssmodules_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      init_options = {
        camelCase = "dashes",
      },
    })

    lspconfig["emmet_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
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

    lspconfig["biome"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["tsserver"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end,
}
