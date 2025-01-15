-- Manages and automates saving/restoring Neovim sessions for a seamless workflow
-- #productivity #session #management
return {
  "rmagatti/auto-session",
  config = function()
    local auto_session = require("auto-session")

    auto_session.setup({
      auto_restore = false,
      suppressed_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
    })
  end,
}
