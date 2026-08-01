return {
  bashls = {},
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        workspace = {
          -- only core runtime
          -- library = { vim.env.VIMRUNTIME },

          -- full runtime path (includes plugins & after/), better typing
          library = vim.api.nvim_get_runtime_file("", true),
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
      javascript = { preferences = { quotePreference = "double" } },
      typescript = { preferences = { quotePreference = "double" } },
    },
  },
  biome = {
    -- use Biome from the project
    -- cmd = { "npx", "biome", "lsp-proxy" },
    cmd = { vim.fn.getcwd() .. "/node_modules/.bin/biome", "lsp-proxy" },
  },
  graphql = {},
}
