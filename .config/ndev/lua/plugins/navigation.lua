return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>h",  nil,                                                                               desc = "Harpoon" },
      { "<leader>ha", function() require("harpoon"):list():add() end,                                    desc = "Harpoon File" },
      { "<leader>hh", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Harpoon Quick Menu" },
      { "<leader>1",  function() require("harpoon"):list():select(1) end,                                desc = "Harpoon to File 1" },
      { "<leader>2",  function() require("harpoon"):list():select(2) end,                                desc = "Harpoon to File 2" },
      { "<leader>3",  function() require("harpoon"):list():select(3) end,                                desc = "Harpoon to File 3" },
      { "<leader>4",  function() require("harpoon"):list():select(4) end,                                desc = "Harpoon to File 4" },
      { "<leader>5",  function() require("harpoon"):list():select(5) end,                                desc = "Harpoon to File 5" },
      { "<leader>6",  function() require("harpoon"):list():select(6) end,                                desc = "Harpoon to File 6" },
      { "<leader>7",  function() require("harpoon"):list():select(7) end,                                desc = "Harpoon to File 7" },
      { "<leader>8",  function() require("harpoon"):list():select(8) end,                                desc = "Harpoon to File 8" },
      { "<leader>9",  function() require("harpoon"):list():select(9) end,                                desc = "Harpoon to File 9" },
      { "<leader>0",  function() require("harpoon"):list():select(0) end,                                desc = "Harpoon to File 0" },
      { "<leader>h[", function() require("harpoon"):list():prev() end,                                   desc = "Harpoon Prev File" },
      { "<leader>h]", function() require("harpoon"):list():next() end,                                   desc = "Harpoon Next File" },
    },
    opts = {
      settings = {
        save_on_toggle = true,
      },
    },
  },
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    keys = {
      { "<leader>f=",  function() require("fzf-lua").builtin() end,              desc = "Buildins" },

      -- Files / search
      { "<leader>ff",  function() require("fzf-lua").files() end,                desc = "Find files" },
      { "<leader>fg",  function() require("fzf-lua").live_grep() end,            desc = "Live grep" },
      { "<leader>fg",  function() require("fzf-lua").grep_visual() end,          desc = "Live grep selection",   mode = "v", },
      { "<leader>fc",  function() require("fzf-lua").grep_cword() end,           desc = "Grep word under cursor" },
      { "<leader>fr",  function() require("fzf-lua").resume() end,               desc = "Resume" },

      -- Buffers
      { "<leader>fb",  function() require("fzf-lua").buffers() end,              desc = "Buffers" },

      -- Help / misc
      { "<leader>fh",  function() require("fzf-lua").help_tags() end,            desc = "Help tags" },
      { "<leader>fk",  function() require("fzf-lua").keymaps() end,              desc = "Keymaps" },
      { "<leader>fs",  function() require("fzf-lua").spell_suggest() end,        desc = "Spelling" },

      -- VCS: Git
      { "<leader>fvs", function() require("fzf-lua").git_status() end,           desc = "Git status" },
      { "<leader>fvb", function() require("fzf-lua").git_blame() end,            desc = "Git blame" },
      { "<leader>fvc", function() require("fzf-lua").git_commits() end,          desc = "Git commits" },
      { "<leader>fvC", function() require("fzf-lua").git_bcommits() end,         desc = "Git buffer commits" },

      -- LSP
      -- TODO: rethink necessity of lsp bindings
      { "<leader>dd",  function() require("fzf-lua").lsp_definitions() end,      desc = "LSP definitions" },
      { "<leader>dr",  function() require("fzf-lua").lsp_references() end,       desc = "References (Fzf)" },
      { "<leader>dt",  function() require("fzf-lua").lsp_typedefs() end,         desc = "LSP type definitions" },
      { "<leader>ds",  function() require("fzf-lua").lsp_document_symbols() end, desc = "Document Symbols" },
    },
    opts = {
      winopts = { backdrop = 50 },
      defaults = { cwd_prompt = false },
      buffers = { sort_lastused = true },
    },
    config = function(_, opts)
      local fzf = require("fzf-lua")
      fzf.setup(opts)
      fzf.register_ui_select()
    end,
  },
}
