local function has_command(command)
  return vim.fn.executable(command) == 1
end

local function use_osc52()
  return vim.env.SSH_TTY ~= nil or vim.env.SSH_CONNECTION ~= nil
end

local function has_graphical_clipboard()
  return (vim.env.WAYLAND_DISPLAY ~= nil and has_command("wl-copy"))
    or (vim.env.DISPLAY ~= nil and has_command("xclip"))
end

if vim.fn.has("macunix") == 1 or has_graphical_clipboard() then
  vim.opt.clipboard = "unnamedplus"
elseif use_osc52() then
  local ok, osc52 = pcall(require, "vim.ui.clipboard.osc52")

  if ok then
    vim.g.clipboard = {
      name = "OSC 52",
      copy = {
        ["+"] = osc52.copy("+"),
        ["*"] = osc52.copy("*"),
      },
      paste = {
        ["+"] = osc52.paste("+"),
        ["*"] = osc52.paste("*"),
      },
    }
    vim.opt.clipboard = "unnamedplus"
  end
end
