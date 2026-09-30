local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Fargene ligger i ~/.config/theme/palette.lua og deles med neovim
local palette = dofile(wezterm.home_dir .. '/.config/theme/palette.lua')

local function scheme(p)
  return {
    foreground = p.term.foreground,
    background = p.term.background,
    cursor_bg = p.term.cursor,
    cursor_border = p.term.cursor,
    cursor_fg = p.term.background,
    ansi = p.term.ansi,
    brights = p.term.brights,
  }
end

local schemes = {
  dark = scheme(palette.dark),
  light = scheme(palette.light),
}

config.color_schemes = {
  ['foot-less-dark'] = schemes.dark,
  ['foot-nvim-light'] = schemes.light,
}

-- Fast mørkt tema. Under niri oppgir ikke portalen lys/mørk-modus, og wezterm
-- faller da tilbake til lyst. Bytt til 'foot-nvim-light' for lyst tema, eller
-- bruk wezterm.gui.get_appearance() hvis portalen kommer på plass.
config.color_scheme = 'foot-less-dark'

config.font = wezterm.font('JetBrainsMono Nerd Font', { weight = 'Regular' })
config.font_size = 22
config.line_height = 1.1
config.freetype_load_target = 'Normal'
config.freetype_load_flags = 'NO_HINTING'

config.front_end = 'OpenGL'
config.max_fps = 120

config.enable_tab_bar = false

config.scrollback_lines = 10000
config.inactive_pane_hsb = { brightness = 0.7 }

config.window_padding = { left = 15, right = 15, top = 12, bottom = 12 }

config.default_cursor_style = 'SteadyBlock'
config.hide_mouse_cursor_when_typing = true

config.keys = {
  -- Alt+| : ny pane til høyre
  { key = '|', mods = 'ALT|SHIFT', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  -- Alt+< (tasten til venstre for Z): samme, siden | krever AltGr på norsk tastatur
  { key = '<', mods = 'ALT',       action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  -- Alt+- : ny pane under
  { key = '-', mods = 'ALT',       action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
  -- Alt+piltaster : bytt fokus mellom panes
  { key = 'LeftArrow',  mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'RightArrow', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Right' },
  { key = 'UpArrow',    mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'DownArrow',  mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Down' },
  -- Alt+p : vis bokstaver på panes, trykk bokstaven for å hoppe dit
  { key = 'p', mods = 'ALT', action = wezterm.action.PaneSelect },
  -- Alt+Shift+piltaster : endre størrelse på gjeldende pane (5 celler)
  { key = 'LeftArrow',  mods = 'ALT|SHIFT', action = wezterm.action.AdjustPaneSize { 'Left', 5 } },
  { key = 'RightArrow', mods = 'ALT|SHIFT', action = wezterm.action.AdjustPaneSize { 'Right', 5 } },
  { key = 'UpArrow',    mods = 'ALT|SHIFT', action = wezterm.action.AdjustPaneSize { 'Up', 5 } },
  { key = 'DownArrow',  mods = 'ALT|SHIFT', action = wezterm.action.AdjustPaneSize { 'Down', 5 } },
}

return config
