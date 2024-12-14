-- Manages and automates saving/restoring Neovim sessions for a seamless workflow
-- #session_management #automation #workflow
return {
  "rmagatti/auto-session",
  config = function()
    local auto_session = require("auto-session")

    auto_session.setup({
      log_level = "error",
      auto_restore_enabled = false,
      auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
    })
  end,
}
