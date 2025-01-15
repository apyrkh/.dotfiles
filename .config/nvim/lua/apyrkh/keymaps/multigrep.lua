local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local conf = require "telescope.config".values

-- Telescope live_grep alternative: allows to specify glob after double space
-- The idea is taken from https://youtu.be/xdXE1tOT-qg
-- see also https://github.com/tjdevries/advent-of-nvim/blob/master/nvim/lua/config/telescope/multigrep.lua
local function live_multigrep(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()

  local finder = finders.new_async_job {
    command_generator = function(prompt)
      if not prompt or prompt == "" then return nil end

      local pieces = vim.split(prompt, "  ")
      local args = {
        "rg",
        "--hidden",
        "--glob", "!**/.git/*",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case"
      }

      if pieces[1] then
        vim.list_extend(args, { "-e", pieces[1] })
      end

      if pieces[2] then
        vim.list_extend(args, { "-g", pieces[2] })
      end

      return args
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  }

  pickers.new(opts, {
    debounce = 100,
    prompt_title = "Multi Grep",
    finder = finder,
    previewer = conf.grep_previewer(opts),
    sorter = require("telescope.sorters").empty(),
  }):find()
end

return live_multigrep
