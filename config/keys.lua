local wezterm = require 'wezterm'
local act = wezterm.action
local M = {}

function M.apply(config)
  -- Defaults (Cmd+T, Cmd+W, Cmd+C/V, Cmd+=/-, ...) stay on; these are additions.
  config.keys = {
    -- Toggle see-through / opaque background
    { key = 'o', mods = 'CMD|SHIFT', action = act.EmitEvent 'toggle-opacity' },

    -- Splits (iTerm-style)
    { key = 'd', mods = 'CMD|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
    -- Cmd+D: 1st press opens a right column; later presses stack new panes in it (max 2 columns)
    { key = 'd', mods = 'CMD', action = wezterm.action_callback(function(window, pane)
      local panes = pane:tab():panes_with_info()
      if #panes == 1 then
        window:perform_action(act.SplitPane { direction = 'Right' }, pane)
        return
      end
      -- Right column = panes with the largest `left`; split its tallest pane (bottom-most on ties)
      local maxLeft = 0
      for _, p in ipairs(panes) do maxLeft = math.max(maxLeft, p.left) end
      local target
      for _, p in ipairs(panes) do
        if p.left == maxLeft and (not target or p.height > target.height
            or (p.height == target.height and p.top > target.top)) then
          target = p
        end
      end
      window:perform_action(act.SplitPane { direction = 'Down' }, target.pane)
    end) },
    { key = 'w', mods = 'CMD|SHIFT', action = act.CloseCurrentPane { confirm = true } },
    -- Ctrl+Shift+W: close the active split (WezTerm's default here closes the whole tab)
    { key = 'w', mods = 'CTRL|SHIFT', action = act.CloseCurrentPane { confirm = true } },
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

    -- Multi-line input (Claude Code, etc.): Shift+Enter inserts a newline instead of submitting
    { key = 'Enter', mods = 'SHIFT', action = act.SendString '\x1b\r' },
    { key = 'Enter', mods = 'ALT', action = act.SendString '\x1b\r' }, -- default was ToggleFullScreen
    -- Delete previous word / whole line, macOS-style
    { key = 'Backspace', mods = 'OPT', action = act.SendString '\x17' },
    { key = 'Backspace', mods = 'CMD', action = act.SendString '\x15' },

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

    -- Help: open this config's README in a new tab (rendered with glow if installed, else less). q closes it.
    { key = 'h', mods = 'CMD|SHIFT', action = act.SpawnCommandInNewTab {
      args = { '/bin/zsh', '-lc',
        'if command -v glow >/dev/null; then glow -p README.md; else less README.md; fi' },
      cwd = wezterm.config_dir,
    } },
  }

  -- Cmd+click opens links; plain click just selects text
  config.mouse_bindings = {
    { event = { Up = { streak = 1, button = 'Left' } }, mods = 'NONE', action = act.CompleteSelection 'ClipboardAndPrimarySelection' },
    { event = { Up = { streak = 1, button = 'Left' } }, mods = 'CMD', action = act.OpenLinkAtMouseCursor },
    { event = { Down = { streak = 1, button = 'Left' } }, mods = 'CMD', action = act.Nop },
  }
end

return M
