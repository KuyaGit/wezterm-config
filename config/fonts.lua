local wezterm = require 'wezterm'
local M = {}

function M.apply(config)
  config.font = wezterm.font_with_fallback {
    { family = 'JetBrains Mono', weight = 'Medium' }, -- bundled with WezTerm
    '0xProto Nerd Font', -- icons / glyphs
    'Symbols Nerd Font Mono', -- bundled fallback for Nerd Font icons
  }
  config.font_size = 14.0
  config.line_height = 1.1
  config.harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' } -- ligatures
end

return M
