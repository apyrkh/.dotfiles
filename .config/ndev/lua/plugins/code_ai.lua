return {
  {
    "github/copilot.vim",
    init = function()
      vim.g.copilot_enabled = false
    end,
    keys = {
      {
        "<leader>ac",
        function()
          vim.cmd("Copilot status")
          if vim.g.copilot_enabled then
            vim.cmd("Copilot disable")
            vim.g.copilot_enabled = false
            vim.notify("Copilot disabled", vim.log.levels.INFO)
          else
            vim.cmd("Copilot enable")
            vim.g.copilot_enabled = true
            vim.notify("Copilot enabled", vim.log.levels.INFO)
          end
        end,
        desc = "Toggle Copilot"
      },
      {
        "<leader>as",
        function()
          vim.cmd("Copilot setup")
          vim.notify("Copilot setup", vim.log.levels.INFO)
        end,
        desc = "Setup Copilot"
      },
      {
        "<leader>ap",
        function()
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            local buf = vim.api.nvim_win_get_buf(win)
            local name = vim.api.nvim_buf_get_name(buf)
            if name:match("^copilot:///panel/") then
              vim.api.nvim_win_close(win, true)
              return
            end
          end

          vim.cmd("Copilot panel")
          vim.notify("Copilot panel", vim.log.levels.INFO)
        end,
        desc = "Open Copilot Panel"
      },
      {
        "<leader>aq",
        function()
          vim.cmd("Copilot signout")
          vim.notify("Copilot signout", vim.log.levels.INFO)
        end,
        desc = "Signout Copilot"
      },
    },
  },
}
