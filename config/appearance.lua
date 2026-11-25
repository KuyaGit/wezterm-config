local wezterm = require 'wezterm'
local M = {}

M.opacity = 0.80

function M.apply(config)
  -- Theme
  config.color_scheme = 'Catppuccin Mocha'

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
      active_tab = { bg_color = '#cba6f7', fg_color = '#1e1e2e' }, -- mauve on base
      inactive_tab = { bg_color = '#313244', fg_color = '#bac2de' }, -- surface0 / subtext1
      inactive_tab_hover = { bg_color = '#45475a', fg_color = '#cdd6f4' }, -- surface1 / text
      new_tab = { bg_color = 'rgba(0,0,0,0)', fg_color = '#6c7086' }, -- overlay0
      new_tab_hover = { bg_color = '#45475a', fg_color = '#cdd6f4' },
    },
  }

  -- Dim unfocused panes so the active one stands out
  config.inactive_pane_hsb = { saturation = 0.7, brightness = 0.45 }

  -- Cursor
  config.default_cursor_style = 'BlinkingBlock'
  config.cursor_blink_rate = 600
  -- Smooth fade in/out instead of a hard on/off blink
  config.cursor_blink_ease_in = 'EaseIn'
  config.cursor_blink_ease_out = 'EaseOut'
end

return M
