local wezterm = require 'wezterm'
local M = {}

M.opacity = 0.80

function M.apply(config)
  -- Theme
  config.color_scheme = 'nord'

  -- Translucent, blurred background (wallpaper shows through)
  config.window_background_opacity = M.opacity
  config.macos_window_background_blur = 30
  config.text_background_opacity = 1.0

  -- GPU rendering, smooth output
  config.front_end = 'WebGpu'
  config.webgpu_power_preference = 'HighPerformance'
  config.max_fps = 120
  config.animation_fps = 60

  -- Window chrome
  config.window_decorations = 'RESIZE' -- no title bar, still resizable
  config.window_padding = { left = 8, right = 8, top = 8, bottom = 4 }
  config.initial_cols = 220
  config.initial_rows = 55
  config.adjust_window_size_when_changing_font_size = false
  config.native_macos_fullscreen_mode = false

  -- Tab bar only appears with 2+ tabs (tmux normally handles tabs)
  config.enable_tab_bar = true
  config.hide_tab_bar_if_only_one_tab = true
  config.use_fancy_tab_bar = false
  config.tab_bar_at_bottom = true
  config.tab_max_width = 32
  config.colors = {
    tab_bar = {
      background = 'rgba(0,0,0,0)',
      active_tab = { bg_color = '#88c0d0', fg_color = '#2e3440' },
      inactive_tab = { bg_color = '#3b4252', fg_color = '#d8dee9' },
      inactive_tab_hover = { bg_color = '#434c5e', fg_color = '#eceff4' },
      new_tab = { bg_color = 'rgba(0,0,0,0)', fg_color = '#4c566a' },
      new_tab_hover = { bg_color = '#434c5e', fg_color = '#eceff4' },
    },
  }

  -- Dim unfocused panes slightly
  config.inactive_pane_hsb = { saturation = 0.9, brightness = 0.7 }

  -- Cursor
  config.default_cursor_style = 'BlinkingBar'
  config.cursor_blink_rate = 600
  config.cursor_blink_ease_in = 'Constant'
  config.cursor_blink_ease_out = 'Constant'
end

return M
