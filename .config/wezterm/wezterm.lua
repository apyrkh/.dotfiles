-- Pull in the wezterm API
local wezterm = require "wezterm"

-- Use the config_builder which will help provide clearer error messages
local config = wezterm.config_builder()

config.default_prog = { "/bin/zsh", "-l" }

-- config.color_scheme = "Tokyo Night Moon"
-- config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" } -- no ligatures
config.font = wezterm.font("JetBrainsMonoNL Nerd Font Mono") -- NL means no ligatures ===
config.font_size = 13

-- config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false

config.window_decorations = "RESIZE"
config.window_padding = {
  left = 5,
  right = 5,
  top = 0,
  bottom = 0,
}


wezterm.on("update-right-status", function(window, _)
  local text = ""
  local LEFT_ARROW = ""
  local LEFT_ARROW_FOREGROUND = { Foreground = { Color = "#1e2030" } }

  if window:leader_is_active() then
    text = " " .. utf8.char(0x26A1) -- lightning
    LEFT_ARROW = utf8.char(0xe0b2)
  end

  window:set_left_status(wezterm.format {
    { Background = { Color = "#b7bdf8" } },
    { Text = text },
    LEFT_ARROW_FOREGROUND,
    { Text = LEFT_ARROW }
  })
end)

local window_maximize = wezterm.action_callback(function(window)
  window:maximize()
end)

local window_restore = wezterm.action_callback(function(window)
  window:restore()
end)

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = {
  {
    key = '[',
    mods = 'LEADER',
    action = wezterm.action.MoveTabRelative(-1),
  },
  {
    key = ']',
    mods = 'LEADER',
    action = wezterm.action.MoveTabRelative(1),
  },
  {
    mods = "LEADER",
    key = "m",
    action = window_maximize,
  },
  {
    mods = "LEADER",
    key = "n",
    action = window_restore,
  },
  {
    mods = "LEADER",
    key = "c",
    action = wezterm.action.SpawnTab "CurrentPaneDomain",
  },
  {
    mods = "LEADER",
    key = "x",
    action = wezterm.action.CloseCurrentPane { confirm = true }
  },
  {
    mods = "LEADER",
    key = "=",
    action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" }
  },
  {
    mods = "LEADER",
    key = "-",
    action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" }
  },
  {
    mods = "LEADER",
    key = "h",
    action = wezterm.action.ActivatePaneDirection "Left"
  },
  {
    mods = "LEADER",
    key = "j",
    action = wezterm.action.ActivatePaneDirection "Down"
  },
  {
    mods = "LEADER",
    key = "k",
    action = wezterm.action.ActivatePaneDirection "Up"
  },
  {
    mods = "LEADER",
    key = "l",
    action = wezterm.action.ActivatePaneDirection "Right"
  },
  {
    mods = "LEADER",
    key = "LeftArrow",
    action = wezterm.action.AdjustPaneSize { "Left", 5 }
  },
  {
    mods = "LEADER",
    key = "RightArrow",
    action = wezterm.action.AdjustPaneSize { "Right", 5 }
  },
  {
    mods = "LEADER",
    key = "DownArrow",
    action = wezterm.action.AdjustPaneSize { "Down", 5 }
  },
  {
    mods = "LEADER",
    key = "UpArrow",
    action = wezterm.action.AdjustPaneSize { "Up", 5 }
  },

  -- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
  -- { key = "LeftArrow", mods = "OPT", action = wezterm.action { SendString = "\x1bb" } },
  -- Make Option-Right equivalent to Alt-f; forward-word
  -- { key = "RightArrow", mods = "OPT", action = wezterm.action { SendString = "\x1bf" } },
}

for i = 1, 9 do
  -- leader + number to activate that tab
  table.insert(config.keys, {
    key = tostring(i),
    mods = "LEADER",
    action = wezterm.action.ActivateTab(i - 1),
  })
end

-- and finally, return the configuration to wezterm
return config
