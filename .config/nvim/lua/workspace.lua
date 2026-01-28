-- Search for .nvim/init.lua from current working directory up to home directory
local function find_project_file()
  local home_dir = vim.loop.os_homedir() or "/" -- stop at home directory
  local current_dir = vim.fn.getcwd()

  while current_dir and #current_dir >= #home_dir do
    local project_file = current_dir .. "/.nvim/init.lua"
    if vim.fn.filereadable(project_file) == 1 then
      return project_file
    end

    current_dir = vim.fn.fnamemodify(current_dir, ":h")
  end
end

local project_file = find_project_file()
if project_file then
  print("Loading project settings from: " .. project_file)
  dofile(project_file)
end
