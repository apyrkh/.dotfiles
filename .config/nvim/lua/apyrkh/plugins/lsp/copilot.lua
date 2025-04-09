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

      vim.keymap.set("n", "<leader>cs", function()
        vim.cmd("Copilot setup")
        vim.notify("Copilot setup", vim.log.levels.INFO)
      end, { desc = "Setup Copilot" })

      vim.keymap.set("n", "<leader>cq", function()
        vim.cmd("Copilot signout")
        vim.notify("Copilot signout", vim.log.levels.INFO)
      end, { desc = "Signout Copilot" })
    end,
  }
}
