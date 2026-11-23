local wezterm = require 'wezterm'
local act = wezterm.action
local M = {}

function M.apply(config)
  -- Defaults (Cmd+T, Cmd+W, Cmd+C/V, Cmd+=/-, ...) stay on; these are additions.
  config.keys = {
    -- Toggle see-through / opaque background
    { key = 'o', mods = 'CMD|SHIFT', action = act.EmitEvent 'toggle-opacity' },

    -- Splits (iTerm-style)
    { key = 'd', mods = 'CMD', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = 'd', mods = 'CMD|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
    { key = 'w', mods = 'CMD|SHIFT', action = act.CloseCurrentPane { confirm = true } },
    { key = 'z', mods = 'CMD|SHIFT', action = act.TogglePaneZoomState },

    -- Move between panes
    { key = 'LeftArrow', mods = 'CMD|ALT', action = act.ActivatePaneDirection 'Left' },
    { key = 'RightArrow', mods = 'CMD|ALT', action = act.ActivatePaneDirection 'Right' },
    { key = 'UpArrow', mods = 'CMD|ALT', action = act.ActivatePaneDirection 'Up' },
    { key = 'DownArrow', mods = 'CMD|ALT', action = act.ActivatePaneDirection 'Down' },

    -- Resize panes
    { key = 'LeftArrow', mods = 'CMD|CTRL', action = act.AdjustPaneSize { 'Left', 5 } },
    { key = 'RightArrow', mods = 'CMD|CTRL', action = act.AdjustPaneSize { 'Right', 5 } },
    { key = 'UpArrow', mods = 'CMD|CTRL', action = act.AdjustPaneSize { 'Up', 3 } },
    { key = 'DownArrow', mods = 'CMD|CTRL', action = act.AdjustPaneSize { 'Down', 3 } },

    -- Shell-style word/line movement with Option/Cmd + arrows
    { key = 'LeftArrow', mods = 'OPT', action = act.SendString '\x1bb' },
    { key = 'RightArrow', mods = 'OPT', action = act.SendString '\x1bf' },
    { key = 'LeftArrow', mods = 'CMD', action = act.SendString '\x01' },
    { key = 'RightArrow', mods = 'CMD', action = act.SendString '\x05' },

    -- Clear scrollback and screen
    { key = 'k', mods = 'CMD', action = act.Multiple {
      act.ClearScrollback 'ScrollbackAndViewport',
      act.SendKey { key = 'L', mods = 'CTRL' },
    } },

    -- Manual reload (auto-reload already watches the config files)
    { key = 'r', mods = 'CMD|SHIFT', action = act.ReloadConfiguration },

    -- Command palette & quick select (URLs, hashes, paths)
    { key = 'p', mods = 'CMD|SHIFT', action = act.ActivateCommandPalette },
    { key = 'Space', mods = 'CMD|SHIFT', action = act.QuickSelect },
  }

  -- Cmd+click opens links; plain click just selects text
  config.mouse_bindings = {
    { event = { Up = { streak = 1, button = 'Left' } }, mods = 'NONE', action = act.CompleteSelection 'ClipboardAndPrimarySelection' },
    { event = { Up = { streak = 1, button = 'Left' } }, mods = 'CMD', action = act.OpenLinkAtMouseCursor },
    { event = { Down = { streak = 1, button = 'Left' } }, mods = 'CMD', action = act.Nop },
  }
end

return M
