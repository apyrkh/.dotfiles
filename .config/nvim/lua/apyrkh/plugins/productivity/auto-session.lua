-- Manages and automates saving/restoring Neovim sessions for a seamless workflow
-- #productivity #session #management
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

return {
  "rmagatti/auto-session",
  lazy = true,
  config = function()
    local auto_session = require("auto-session")

    auto_session.setup({
      auto_restore = false,
      suppressed_dirs = { "~/", "~/Downloads", "~/Documents", "~/Desktop/" },
    })
  end,
}
