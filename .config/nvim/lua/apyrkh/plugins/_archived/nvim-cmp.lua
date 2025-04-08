-- Autocompletion plugin for Neovim with flexible configuration, snippet integration, and LSP support
-- #code #autocompletion #snippets
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",   -- source for text in buffer
    "hrsh7th/cmp-path",     -- source for file system paths
    "hrsh7th/cmp-cmdline",  -- source for vim's cmdline
    "hrsh7th/nvim-cmp",
    "onsails/lspkind.nvim", -- vscode-like pictograms for neovim lsp completion items

    -- luasnip users
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp",
    },
    "saadparwaiz1/cmp_luasnip",     -- source for luasnip
    "rafamadriz/friendly-snippets", -- useful snippets
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    -- loads snippets from installed plugins (e.g. friendly-snippets)
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },

      sources = cmp.config.sources(
        {
          { name = "nvim_lsp", max_item_count = 10 },
          { name = "luasnip",  max_item_count = 10 },
          { name = "buffer",   max_item_count = 10 }, -- text within current buffer
          { name = "path",     max_item_count = 10 }, -- file system paths
        }
      ),

      formatting = {
        format = lspkind.cmp_format({
          maxwidth = 50,
          ellipsis_char = "...",
        }),
      },

      -- configure how nvim-cmp interacts with snippet engine
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      mapping = {
        -- confirm selection
        ["<CR>"] = cmp.mapping(function(fallback)
          if cmp.visible() and cmp.get_active_entry() then
            cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert })
          else
            fallback()
          end
        end, { "i", "s", "c" }),

        -- go next
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.ConfirmBehavior.Replace })
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s", "c" }),

        -- go previous
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.ConfirmBehavior.Replace })
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s", "c" }),

        -- scroll docs top
        ["<C-e>"] = cmp.mapping({
          i = function(fallback)
            if not cmp.scroll_docs(4) then
              fallback()
            end
          end
        }),

        -- scroll docs bottom
        ["<C-y>"] = cmp.mapping({
          i = function(fallback)
            if not cmp.scroll_docs(-4) then
              fallback()
            end
          end
        }),

        -- cancel autocompletion
        ["<C-c>"] = cmp.mapping({
          i = function(fallback)
            if not cmp.abort() then
              fallback()
            end
          end
        }),
      },
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "buffer" }
      }),
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
        { name = "cmdline" }
      }),
      matching = { disallow_symbol_nonprefix_matching = false }
    })

    -- local cmp_nvim_lsp = require("cmp_nvim_lsp")
    -- local capabilities = cmp_nvim_lsp.default_capabilities()
    -- vim.lsp.config("*", {
    --   capabilities = capabilities,
    -- })
  end
}
