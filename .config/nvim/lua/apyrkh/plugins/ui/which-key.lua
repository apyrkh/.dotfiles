-- Display keybindings in a popup for faster learning and usage
-- #ui #keymaps
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.opt.timeout = true
    vim.opt.timeoutlen = 5000
  end,
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
  opts = {
    plugins = {
      -- hotkey: z=
      spelling = { enabled = true },
    },
    win = {
      border = "rounded",
    },
  }
}
