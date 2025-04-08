-- Autocompletion plugin for Neovim with flexible configuration, snippet integration, and LSP support
-- #code #autocompletion #snippets
local border = 'rounded'

return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = { 'rafamadriz/friendly-snippets' },

  -- use a release tag to download pre-built binaries
  version = '1.*',
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = {
      preset = 'default',
      ['C-<space>'] = {},
      ['<C-e>'] = { 'show', 'hide' },
    },

    appearance = {
      nerd_font_variant = 'mono'
    },

    completion = {
      ghost_text = {
        enabled = true,
      },
      list = {
        max_items = 20,
      },
      menu = {
        enabled = true,
        border = border,
        max_height = 22,
        scrollbar = false,
      },
      documentation = {
        auto_show = true,
        window = {
          border = border,
        }
      }
    },
    signature = {
      enabled = true,
      window = {
        border = border,
      }
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'snippets', 'buffer', 'path' },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },

    cmdline = {
      keymap = {
        preset = 'cmdline',
        ['<C-e>'] = { 'show', 'hide', 'show_documentation', 'hide_documentation' },
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
}
