local function has_command(command)
  return vim.fn.executable(command) == 1
end

local function has_graphical_clipboard()
  return (vim.env.WAYLAND_DISPLAY ~= nil and has_command("wl-copy"))
    or (vim.env.DISPLAY ~= nil and has_command("xclip"))
end

-- Fallback for any environment without a direct clipboard tool (SSH,
-- devcontainers, remote tmux, etc.): OSC 52 sends the yank through the
-- terminal escape sequence, so it works as long as the terminal emulator
-- (e.g. WezTerm) supports it, no matter how nvim was reached.
if vim.fn.has("macunix") == 1 or has_graphical_clipboard() then
  vim.opt.clipboard = "unnamedplus"
else
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
