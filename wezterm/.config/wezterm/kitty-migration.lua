local wezterm = require("wezterm")
local act = wezterm.action

return {
  apply = function(config)
    config.font = wezterm.font("JetBrains Mono")
    config.font_size = 11.5
    config.window_background_opacity = 0.9

    config.keys = {
      { key = "LeftArrow",  mods = "CMD", action = act.ActivateTabRelative(-1) },
      { key = "RightArrow", mods = "CMD", action = act.ActivateTabRelative(1) },
      { key = "h",          mods = "CMD", action = act.Hide },
    }
  end,
}
