local M = {}

function M.apply(config)
  config.scrollback_lines = 10000
  config.audible_bell = 'Disabled'
  config.window_close_confirmation = 'AlwaysPrompt'
  config.skip_close_confirmation_for_processes_named = {
    'bash', 'sh', 'zsh', 'fish', 'tmux', 'nu',
  }

  -- macOS: Left Option acts as Alt/Meta (for tmux/nvim); Right Option types special chars
  config.send_composed_key_when_left_alt_is_pressed = false
  config.send_composed_key_when_right_alt_is_pressed = true

  -- Avoid stray characters when a modifier key is held during startup
  config.use_dead_keys = false
end

return M
