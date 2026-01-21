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
