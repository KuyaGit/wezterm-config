# WezTerm config

Personal WezTerm setup for macOS. It uses the Catppuccin Mocha theme, a translucent blurred background, JetBrains Mono, and iTerm-style splits.

## Layout

```
wezterm.lua            entry point: loads each module, watches ./config for auto-reload
config/
  appearance.lua       theme, opacity/blur, window chrome, tab bar, cursor
  fonts.lua            font stack, size, ligatures
  general.lua          scrollback, bell, close confirmation, Option-key behavior
  keys.lua             keyboard and mouse bindings
  events.lua           opacity toggle, reload toast, tab titles
```

Each module exposes `apply(config)` (or `setup()` for events). To add settings, put them in the module they belong to, or create a new `config/<name>.lua` and `require` it in `wezterm.lua`.

Saving any file reloads the config automatically, and a "Configuration reloaded" toast confirms it. To reload by hand, press `Cmd+Shift+R`.

## Keyboard shortcuts

### Tabs (WezTerm defaults)

| Keys | Action |
| --- | --- |
| `Cmd+T` | New tab |
| `Cmd+W` | Close tab |
| `Cmd+1` … `Cmd+8` | Go to tab N |
| `Cmd+9` | Go to last tab |
| `Cmd+Shift+[` / `Cmd+Shift+]` | Previous / next tab |

The tab bar sits at the bottom and appears only when there are 2 or more tabs. Tabs are numbered (`1: zsh`) so you can see which `Cmd+N` reaches them.

### Panes (splits)

| Keys | Action |
| --- | --- |
| `Cmd+D` | Split: 1st press opens a right column, later presses stack new panes in it (max 2 columns) |
| `Cmd+Shift+D` | Split stacked (new pane below) |
| `Cmd+Shift+W` or `Ctrl+Shift+W` | Close current pane only (not the whole tab) |
| `Cmd+Opt+←/→/↑/↓` | Focus the pane in that direction |
| `Cmd+Ctrl+←/→/↑/↓` | Resize current pane |
| `Cmd+Shift+Z` | Zoom current pane to full tab and back again |
| Click | Focus a pane |

Unfocused panes are dimmed, so the active one stands out.

### Editing and text

| Keys | Action |
| --- | --- |
| `Opt+←` / `Opt+→` | Move back / forward one word |
| `Cmd+←` / `Cmd+→` | Jump to start / end of line |
| `Shift+Enter` or `Opt+Enter` | New line without submitting (Claude Code and other prompts) |
| `Opt+Backspace` | Delete previous word |
| `Cmd+Backspace` | Delete to start of line |
| `Cmd+K` | Clear screen and scrollback |
| `Cmd+C` / `Cmd+V` | Copy / paste |
| `Cmd+=` / `Cmd+-` / `Cmd+0` | Font bigger / smaller / reset |
| `Cmd+F` | Search scrollback |

### Tools

| Keys | Action |
| --- | --- |
| `Cmd+Shift+P` | Command palette: search any action by name |
| `Cmd+Shift+Space` | Quick Select: highlights URLs, hashes and paths; press the letter to copy one |
| `Cmd+Shift+O` | Toggle translucent / fully opaque background |
| `Cmd+Shift+R` | Reload config |
| `Cmd+Shift+H` | Open this README in a new tab (`q` to close) |

### Mouse

- **Click or drag**: select text, which is copied automatically.
- **Cmd+click**: open the link under the cursor.

## Guidelines

- **Left Option is Alt/Meta** (for tmux, nvim and shell shortcuts). **Right Option** types special characters such as `©` or `é`.
- **Closing**: panes, tabs and windows close immediately when only a shell (zsh, bash, fish, tmux…) is running. If another program is running (vim, a dev server…), WezTerm asks first. `Cmd+W` closes the whole tab; use `Cmd+Shift+W` to close just the active split.
- **Focusing one terminal**: use `Cmd+N` for tabs, `Cmd+Opt+arrows` for panes, and `Cmd+Shift+Z` to give one pane the full tab.
- **Forgot a shortcut?** Open `Cmd+Shift+P` and type what you want ("split", "tab", "zoom").
- **Adding a binding**: append to the `config.keys` table in `config/keys.lua`. Defaults stay active unless you rebind the same keys.
- **Changing opacity**: edit `M.opacity` in `config/appearance.lua`. The `Cmd+Shift+O` toggle uses it too.
- **README viewer**: `Cmd+Shift+H` renders this file with [glow](https://github.com/charmbracelet/glow) (`brew install glow`). Without glow it falls back to plain `less`.
- **Fonts**: JetBrains Mono and Symbols Nerd Font come bundled. `0xProto Nerd Font` must be installed separately (`brew install --cask font-0xproto-nerd-font`), and if it's missing WezTerm falls back without errors.
