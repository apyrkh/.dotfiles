-- Set up the path for lazy.nvim plugin
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- If lazy.nvim is not already installed, clone it from GitHub
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

-- Add lazy.nvim to the runtime path
vim.opt.rtp:prepend(lazypath)

-- Set up lazy.nvim with plugin categories
require("lazy").setup(
  {
    { import = "apyrkh.plugins" },
    { import = "apyrkh.plugins.lsp" },
    { import = "apyrkh.plugins.code" },
    { import = "apyrkh.plugins.vcs" },
    { import = "apyrkh.plugins.ui" },
  },
  {
    -- Enable plugin update checker
    checker = {
      enabled = true,
      notify = false, -- Disable notifications for updates
    },

    -- Disable change detection notifications
    change_detection = {
      notify = false,
    },
  }
)
