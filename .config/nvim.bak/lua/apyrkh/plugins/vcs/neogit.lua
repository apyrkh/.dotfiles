-- A Git client for Neovim, providing a full-featured interface for Git operations
-- #vcs #git #git-client
return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",

    -- Only one of these is needed, not both.
    "nvim-telescope/telescope.nvim",
    -- "ibhagwan/fzf-lua",
  },
  opts = {
    graph_style = "unicode",
    remember_settings = false,
    commit_editor = {
      kind = "vsplit",
    },
    signs = {
      hunk = { "", "" },
      item = { "", "" },
      section = { "", "" },
    },
    integrations = {
      diffview = true,
      telescope = false,
    },
  },
}
