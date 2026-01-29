return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Oil",
    keys = {
      { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
    },
    opts = {
      keymaps = {
        ["<C-v>"] = { "actions.select", opts = { vertical = true } },
        ["<C-s>"] = { "actions.select", opts = { horizontal = true } },
        ["<C-h>"] = false,
        ["<C-l>"] = false,
      },
      view_options = {
        show_hidden = true,
        is_hidden_file = function(name, bufnr)
          -- default
          -- local m = name:match("^%.")
          -- return m ~= nil

          local hidden_files = {
            ["build"] = true,
            ["dist"] = true,
            ["node_modules"] = true,
            [".git"] = true,
          }
          return hidden_files[name] ~= nil
        end,
        is_always_hidden = function(name)
          local hidden_names = {
            ".DS_Store",
          }
          return vim.tbl_contains(hidden_names, name)
        end,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "OilActionsPost",
        callback = function(event)
          if event.data.actions[1].type == "move" then
            -- @TODO: make it save and check that Snacks.rename exists
            require("snacks").rename.on_rename_file(event.data.actions[1].src_url, event.data.actions[1].dest_url)
          end
        end,
      })
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    keys = {
      { "<leader>ee", "<cmd>NvimTreeToggle<CR>",   desc = "Toggle Explorer" },
      { "<leader>eo", "<cmd>NvimTreeFindFile<CR>", desc = "Open in Explorer" },
    },
    init = function()
      -- disabling netrw is strongly advised, :h nvim-tree-netrw
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    opts = {
      view = {
        width = 40,
        relativenumber = true,
      },
      filters = {
        git_ignored = false,
        custom = { ".DS_Store" },
      },
      renderer = {
        highlight_git = true,
        indent_markers = {
          enable = true,
        },
        -- TODO: ui.icons
        -- icons = {
        --   glyphs = {
        --     folder = {
        --       arrow_closed = "", -- arrow when folder is closed
        --       arrow_open = "", -- arrow when folder is open
        --     },
        --   },
        -- },
      },
      -- disable window_picker for explorer to work well with window splits
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      diagnostics = {
        enable = true,
        -- TODO: ui.icons
        -- icons = {
        --   hint = "",
        --   info = "",
        --   warning = "",
        --   error = "",
        -- },
      },
    },
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",                        desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>",                desc = "Symbols (Trouble)" },
      { "<leader>xr", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions/references (Trouble)" },
      { "<leader>xl", "<cmd>Trouble loclist toggle<cr>",                            desc = "Location List (Trouble)" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<cr>",                             desc = "Quickfix List (Trouble)" },
    },
    opts = {}, -- for default options, refer to the configuration section for custom setup.
  },
}
