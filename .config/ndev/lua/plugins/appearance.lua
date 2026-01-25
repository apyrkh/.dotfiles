return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
      -- notifier
      {
        "<leader>un",
        function() require("snacks").notifier.show_history() end,
        desc = "Notification History"
      },

      -- rename
      {
        "<leader>rn",
        function() require("snacks").rename.rename_file() end,
        desc = "Rename File",
      },

      -- words
      {
        "]w",
        function() require("snacks").words.jump(1, true) end,
        desc = "Next Word"
      },
      {
        "[w",
        function() require("snacks").words.jump(-1, true) end,
        desc = "Prev Word"
      },

      -- terminal
      {
        "<leader>ut",
        function() require("snacks").terminal.toggle() end,
        desc = "Toggle Terminal"
      },

      -- scratch
      {
        "<leader>.",
        function() require("snacks").scratch() end,
        desc = "Toggle Scratch Buffer"
      },
      {
        "<leader>S",
        function() require("snacks").scratch.select() end,
        desc = "Select Scratch Buffer"
      },
      {
        "<leader>sc",
        function()
          local filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "html",
            "css",
            "json",
            "markdown",
            "text",
          }
          vim.ui.select(filetypes, {
            prompt = "Scratch Filetype:",
          }, function(ft)
            if ft then
              -- require("snacks").scratch({ ft = ft, name = "Scratch: " .. ft })
              require("snacks").scratch({ ft = ft })
            end
          end)
        end,
        desc = "Create Scratch Buffer with Filetype",
      }
    },
    opts = {
      input = { enabled = true },
      notifier = { enabled = true },
      scroll = { enabled = true },

      rename = { enabled = true },
      words = { enabled = true },

      scratch = { enabled = true },
      terminal = { enabled = true },
    },
  },
  {
    "catgoose/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      user_default_options = {
        names = false,
        rgb_fn = true,
        hsl_fn = true,
        oklch_fn = true,
        css = true,
        css_fn = true,
      },
    },
  },
  {
    "nvim-mini/mini.indentscope",
    version = false,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      draw = {
        delay = 10,
        animation = function() return 0 end, -- disable animation
      },
      -- @TODO: ui.icon
      -- "╎" (default) "│" "┊" "┆" "⋮"
      -- symbol = "╎",
      options = {
        try_as_border = true,
      },
    },
  },
  {
    -- @TODO: consider nvim-mini/mini.statusline
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      sections = {
        lualine_b = { "branch" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "encoding", "filetype" },
      }
    },
  },
  -- themes
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    -- make sure to load this before all the other start plugins
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
      })
      vim.cmd.colorscheme "catppuccin"
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "moon",
      light_style = "day",
    },
  },
  {
    "eandrju/cellular-automaton.nvim",
    keys = {
      {
        "<leader>uq",
        function()
          vim.cmd("CellularAutomaton make_it_rain")
        end,
        desc = "Make It Rain"
      },
    },
    opts = {},
  }
}
