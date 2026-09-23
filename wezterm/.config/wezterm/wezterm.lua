local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "Dracula (Official)"
-- config.color_scheme = "Dracula"
-- config.color_scheme = "Catppuccin Mocha"

config.text_background_opacity = 1.0

config.window_padding = {
  left = 8,
  right = 8,
  top = 8,
  bottom = 8,
}

config.enable_tab_bar = false

config.window_decorations = "RESIZE"

config.hide_mouse_cursor_when_typing = true

-- config.macos_window_background_blur = 20

require("kitty-migration").apply(config)

return config
