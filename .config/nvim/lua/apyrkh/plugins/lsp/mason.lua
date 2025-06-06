-- Manages LSP installations for Neovim through Mason and Mason-Lspconfig
-- #lsp #installer
return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "bashls",
        "lua_ls",

        "biome",

        --"markdown_oxide",
        "jsonls",
        --"vimls",
        --"yamlls",

        "html",
        "cssls",
        "cssmodules_ls",
        "css_variables",
        "emmet_ls",

        "ts_ls",

        "graphql",
        -- "prismals",
      },
    })
  end,
}
