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

      vim.keymap.set("n", "<leader>cp", function()
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

        -- local win_before = vim.api.nvim_get_current_win()
        -- vim.defer_fn(function()
        --   local win_after = vim.api.nvim_get_current_win()
        --   if win_after ~= win_before then
        --     vim.cmd("wincmd L") -- move left (H, J, K, L + R, X)
        --   end
        -- end, 20)
      end, { desc = "Open Copilot Panel" })

      vim.keymap.set("n", "<leader>cq", function()
        vim.cmd("Copilot signout")
        vim.notify("Copilot signout", vim.log.levels.INFO)
      end, { desc = "Signout Copilot" })
    end,
  }
}
