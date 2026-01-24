return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>f=",  function() require("fzf-lua").builtin() end,         desc = "Buildins" },

      -- Files / search
      { "<leader>ff",  function() require("fzf-lua").files() end,           desc = "Find files" },
      { "<leader>fg",  function() require("fzf-lua").live_grep() end,       desc = "Live grep" },
      { "<leader>fg",  function() require("fzf-lua").grep_visual() end,     desc = "Live grep selection",   mode = "v", },
      { "<leader>fc",  function() require("fzf-lua").grep_cword() end,      desc = "Grep word under cursor" },
      { "<leader>fr",  function() require("fzf-lua").resume() end,          desc = "Resume" },

      -- Buffers
      { "<leader>fb",  function() require("fzf-lua").buffers() end,         desc = "Buffers" },

      -- Help / misc
      { "<leader>fh",  function() require("fzf-lua").help_tags() end,       desc = "Help tags" },
      { "<leader>fk",  function() require("fzf-lua").keymaps() end,         desc = "Keymaps" },
      { "<leader>fs",  function() require("fzf-lua").spell_suggest() end,   desc = "Spelling" },

      -- VCS: Git
      { "<leader>fvs", function() require("fzf-lua").git_status() end,      desc = "Git status" },
      { "<leader>fvb", function() require("fzf-lua").git_blame() end,       desc = "Git blame" },
      { "<leader>fvc", function() require("fzf-lua").git_commits() end,     desc = "Git commits" },
      { "<leader>fvC", function() require("fzf-lua").git_bcommits() end,    desc = "Git buffer commits" },

      -- LSP
      -- TODO: rethink necessity of lsp bindings
      { "<leader>dd",  function() require("fzf-lua").lsp_definitions() end, desc = "LSP definitions" },
      { "<leader>dt",  function() require("fzf-lua").lsp_typedefs() end,    desc = "LSP type definitions" },
    },
    config = function()
      require("fzf-lua").setup({
        winopts = { backdrop = 50 },
        defaults = {
          cwd_prompt = false,
        },
        buffers = {
          sort_lastused = true,
        },
      })
    end
  },
}
