-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\n\n" },
      { "Press any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Set up lazy.nvim with plugin categories
require("lazy").setup(
  {
    { import = "apyrkh.plugins.code" },
    { import = "apyrkh.plugins.file" },
    { import = "apyrkh.plugins.lsp" },
    { import = "apyrkh.plugins.navigation" },
    { import = "apyrkh.plugins.productivity" },
    { import = "apyrkh.plugins.ui" },
    { import = "apyrkh.plugins.vcs" },
  },
  {
    -- Enable plugin update checker
    checker = {
      enabled = true,
      notify = false, -- Disable notifications for updates
    },

    -- concurrency = 5,

    -- Disable change detection notifications
    change_detection = {
      notify = false,
    },
  }
)
