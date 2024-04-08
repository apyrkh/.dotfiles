-- auto-reload files when modified externally
-- https://unix.stackexchange.com/a/383044
vim.o.autoread = true

-- highligh yanked text
-- vim.api.nvim_create_autocmd("TextYankPost", {
--   pattern = "*",
--   callback = function()
--     vim.highlight.on_yank({ higroup = 'IncSearch', timeout = '500' })
--   end
-- })

