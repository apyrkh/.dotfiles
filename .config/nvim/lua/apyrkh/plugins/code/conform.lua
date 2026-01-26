return {
  "stevearc/conform.nvim",
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
    },
  },
}
