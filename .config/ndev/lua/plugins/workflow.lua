return {
  {
    "rmagatti/auto-session",
    dependencies = { "ibhagwan/fzf-lua" },
    keys = {
      { "<leader>ww", "<cmd>AutoSession save<CR>",          desc = "Save Session" },
      { "<leader>wr", "<cmd>AutoSession restore<CR>",       desc = "Restore Session" },
      { "<leader>wo", "<cmd>AutoSession search<CR>",        desc = "List Saved Sessions" },
      { "<leader>wd", "<cmd>AutoSession delete<CR>",        desc = "Delete Saved Sessions" },
      { "<leader>wD", "<cmd>AutoSession purgeOrphaned<CR>", desc = "Purge All Orphaned Sessions" },
    },
    init = function()
      vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    end,
    opts = {
      auto_restore = false,
      suppressed_dirs = { "~/", "~/Downloads", "~/Documents", "~/Desktop/" },
      session_lens = {
        picker = "fzf",

        picker_opts = {
          preview = {
            default = "bat",
            layout = "vertical",
          },
        },
      },
    },
  },
  {
    "gbprod/yanky.nvim",
    keys = {
      { "<leader>p", require("fzf-lua").registers, desc = "Search Yank History", mode = "n" },
      { "P",         "<Plug>(YankyPutBefore)",     desc = "Put Before",          mode = { "n", "x" } },
      { "p",         "<Plug>(YankyPutAfter)",      desc = "Put After",           mode = { "n", "x" } },
    },
    opts = {
      ring = {
        history_length = 50,
        storage = "memory",
        update_register_on_cycle = true,
      },
    },
  },
  -- FIX:
  -- HACK:
  -- WARN:
  -- TODO:
  -- NOTE:
  -- TEST:
  -- PERF:
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ft", "<cmd>TodoFzfLua<CR>", desc = "Search todo comments" },
    },
    opts = {
      search = {
        command = "rg",
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--hidden", -- added line
        },
      },
    }
  },
}
