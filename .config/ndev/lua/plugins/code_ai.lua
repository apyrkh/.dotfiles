return {
  {
    "github/copilot.vim",
    event = "InsertEnter", -- optional
    keys = {
      { "<leader>cc", function() _G.CopilotToggle() end, desc = "Toggle Copilot" },
      { "<leader>cs", "<cmd>Copilot setup<CR>",          desc = "Setup Copilot" },
      { "<leader>cp", "<cmd>Copilot panel<CR>",          desc = "Open Copilot Panel" },
      { "<leader>cq", "<cmd>Copilot signout<CR>",        desc = "Signout Copilot" },
    },
    init = function()
      vim.g.copilot_enabled = false
    end,
    config = function()
      local function toggle_copilot()
        if vim.g.copilot_enabled then
          vim.cmd("Copilot disable")
          vim.g.copilot_enabled = false
          vim.notify("Copilot disabled")
        else
          vim.cmd("Copilot enable")
          vim.g.copilot_enabled = true
          vim.notify("Copilot enabled")
        end
      end

      _G.CopilotToggle = toggle_copilot
    end,
  },
}
