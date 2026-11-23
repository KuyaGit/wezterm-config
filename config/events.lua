local wezterm = require 'wezterm'
local appearance = require 'config.appearance'
local M = {}

function M.setup()
  -- Cmd+Shift+O: switch between translucent and fully opaque
  wezterm.on('toggle-opacity', function(window)
    local overrides = window:get_config_overrides() or {}
    if overrides.window_background_opacity == 1.0 then
      overrides.window_background_opacity = appearance.opacity
    else
      overrides.window_background_opacity = 1.0
    end
    window:set_config_overrides(overrides)
  end)

  -- Show a small notification whenever the config reloads
  wezterm.on('window-config-reloaded', function(window)
    window:toast_notification('WezTerm', 'Configuration reloaded', nil, 2000)
  end)

  -- Tab title: just the process/folder name, numbered
  wezterm.on('format-tab-title', function(tab)
    local title = tab.tab_title
    if not title or #title == 0 then
      title = tab.active_pane.title
    end
    return ' ' .. (tab.tab_index + 1) .. ': ' .. title .. ' '
  end)
end

return M
