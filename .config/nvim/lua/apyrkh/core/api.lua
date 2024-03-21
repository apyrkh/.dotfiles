local api = vim.api

api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = 'IncSearch', timeout = '500' })
    end
})