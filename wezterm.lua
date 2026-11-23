-- WezTerm entry point. Each module in ./config adds its settings to one shared builder.
local wezterm = require 'wezterm'

local config = wezterm.config_builder() -- reports typos / bad values as warnings

require('config.appearance').apply(config)
require('config.fonts').apply(config)
require('config.general').apply(config)
require('config.keys').apply(config)
require('config.events').setup()

-- Auto-reload: watch every module in ./config too, not just this file
config.automatically_reload_config = true
for _, file in ipairs(wezterm.glob(wezterm.config_dir .. '/config/*.lua')) do
  wezterm.add_to_config_reload_watch_list(file)
end

return config
