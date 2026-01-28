return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      { "<leader>v[", function() require("gitsigns").nav_hunk("prev", { target = "all" }) end, desc = "Prev Hunk" },
      { "<leader>v]", function() require("gitsigns").nav_hunk("next", { target = "all" }) end, desc = "Next Hunk" },
      { "<leader>vb", function() require("gitsigns").blame_line({ full = true }) end,          desc = "Blame line (full)" },
      { "<leader>vB", function() require("gitsigns").blame() end,                              desc = "Blame" },
      { "<leader>vp", function() require("gitsigns").preview_hunk() end,                       desc = "Preview Hunk" },
      { "<leader>vP", function() require("gitsigns").preview_hunk_inline() end,                desc = "Preview Hunk (inline)" },
      { "<leader>vd", function() require("gitsigns").diffthis() end,                           desc = "Diff This" },
      { "<leader>vD", function() require("gitsigns").diffthis("~") end,                        desc = "Diff This (~)" },
    },
    opts = {
      -- current_line_blame = true,
      -- current_line_blame_formatter = "<abbrev_sha> <author_time:%Y.%m.%d %H:%M> <author>: <summary>",
      word_diff = true,
    },
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "sindrets/diffview.nvim",
        opts = {
          enhanced_diff_hl = true, -- Highlight word-level changes in diffs
          -- TODO: ui.icons
          -- signs = {
          --   fold_closed = "",
          --   fold_open = "",
          --   done = "✓",
          -- },
        },
      },

      -- Only one of these is needed, not both.
      -- "nvim-telescope/telescope.nvim",
      "ibhagwan/fzf-lua",
    },
    keys = {
      { "<leader>vv", "<cmd>Neogit<CR>", desc = "Neogit" },
    },
    opts = {
      graph_style = "unicode",
      remember_settings = false,
      commit_editor = {
        kind = "vsplit",
      },
      integrations = {
        diffview = true,
        fzf_lua = true,
      },
      -- TODO: ui.icons
      -- signs = {
      --   hunk = { "", "" },
      --   item = { "", "" },
      --   section = { "", "" },
      -- },
    },
  },
}
