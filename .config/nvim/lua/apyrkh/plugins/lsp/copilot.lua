return {
  {
    "github/copilot.vim",
    init = function()
      vim.g.copilot_enabled = false

      vim.keymap.set("n", "<leader>cc", function()
        if vim.g.copilot_enabled == true then
          vim.cmd("Copilot disable")
          vim.g.copilot_enabled = false
          vim.notify("Copilot disabled", vim.log.levels.INFO)
        else
          vim.cmd("Copilot enable")
          vim.g.copilot_enabled = true
          vim.notify("Copilot enabled", vim.log.levels.INFO)
        end
      end, { desc = "Toggle Copilot" })
    end,
  }
}
