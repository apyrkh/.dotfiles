return {
  "stevearc/conform.nvim",
  opts = {
    format_on_save = false,
    -- format_on_save = {
    --   timeout_ms = 500,
    --   lsp_fallback = true, -- fallback to LSP formatter if no formatter
    -- },

    formatters_by_ft = {
      javascript      = { "biome", "eslint_d", "prettier" },
      javascriptreact = { "biome", "eslint_d", "prettier" },
      typescript      = { "biome", "eslint_d", "prettier" },
      typescriptreact = { "biome", "eslint_d", "prettier" },

      json            = { "biome", "prettier" },
      jsonc           = { "biome", "prettier" },

      css             = { "biome", "prettier" },
      scss            = { "biome", "prettier" },
      html            = { "biome", "prettier" },

      markdown        = { "prettier" },
    },
  },
}
