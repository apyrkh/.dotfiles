return {
  bashls = {},
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        workspace = {
          library = { vim.env.VIMRUNTIME },
          checkThirdParty = false
        },
      },
    },
  },
  jsonls = {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  },
  html = {},
  cssls = {},
  cssmodules_ls = {
    init_options = {
      camelCase = "dashes",
    },
  },
  css_variables = {},
  emmet_ls = {
    filetypes = {
      "html",
      "typescriptreact",
      "javascriptreact",
      "css",
      --"less",
      --"sass",
      "scss",
    },
  },
  ts_ls = {
    settings = {
      javascript = { preferences = { quotePreference = "single" } },
      typescript = { preferences = { quotePreference = "single" } },
    },
  },
  biome = {
    cmd = { "npx", "biome", "lsp-proxy" }, -- use Biome from the project
  },
  graphql = {},
}
