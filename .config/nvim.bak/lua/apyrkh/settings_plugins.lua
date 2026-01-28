-- Hide copilot on suggestion
local copilot_was_enabled = vim.g.copilot_enabled;

vim.api.nvim_create_autocmd('User', {
  pattern = 'BlinkCmpMenuOpen',
  callback = function()
    copilot_was_enabled = vim.g.copilot_enabled
    if copilot_was_enabled then
      vim.fn['copilot#Dismiss']()
      vim.cmd("Copilot disable")
    end
  end,
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'BlinkCmpMenuClose',
  callback = function()
    if copilot_was_enabled then
      vim.cmd("Copilot enable")
      vim.fn['copilot#Suggest']()
    end
  end,
})
