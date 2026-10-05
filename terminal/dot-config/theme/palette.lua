-- Felles fargepalett for wezterm og neovim.
-- Lastes med dofile() fra ~/.config/theme/palette.lua.
--
-- Hver modus har:
--   term    : felter wezterm bruker (foreground, background, cursor, ansi, brights)
--   editor  : felter neovim bruker (syntaks, UI, diff, diagnostikk)
-- Mørk modus er basert på Catppuccin Mocha, med mørkere flater og dempede aksenter.

local M = {}

-- ─── Mørk (dempet Catppuccin Mocha) ───────────────────────────────────────────
local d = {
  black = '#262735', red = '#ab7284', green = '#79a37e', yellow = '#b29f82',
  blue = '#7489ad', magenta = '#9681a8', cyan = '#719994', white = '#aeb2c3',
  bright_black = '#707486', bright_red = '#b98394', bright_green = '#88b08b',
  bright_yellow = '#bda98c', bright_blue = '#8197b8', bright_magenta = '#a38db6',
  bright_cyan = '#7fa7a1', bright_white = '#bac0cf',
}
local dark_bg = '#101019'

M.dark = {
  term = {
    foreground = d.white,
    background = dark_bg,
    cursor = d.bright_blue,
    ansi = { d.black, d.red, d.green, d.yellow, d.blue, d.magenta, d.cyan, d.white },
    brights = {
      d.bright_black, d.bright_red, d.bright_green, d.bright_yellow,
      d.bright_blue, d.bright_magenta, d.bright_cyan, d.bright_white,
    },
  },
  editor = {
    -- Syntaks
    comment = d.bright_black,
    string = d.green,
    func = d.cyan,
    keyword = d.magenta,
    number = d.yellow,
    variable = d.white,
    type = d.yellow,
    -- UI
    bg = dark_bg,
    bg_alt = '#191923',
    bg_float = '#22222e',
    fg = d.white,
    fg_muted = d.bright_black,
    border = '#363745',
    cursor = '#20212e',
    sel = '#33384a',
    dim = '#4b4d60',
    -- Git / diff
    added = d.bright_green,
    changed = d.cyan,
    removed = d.bright_red,
    diff_add = '#1c2c27',
    diff_change = '#232b3e',
    diff_delete = '#30232e',
    diff_text = '#303951',
    -- Diagnostikk
    error = d.bright_red,
    warn = d.bright_yellow,
    info = d.cyan,
    hint = d.cyan,
    -- Søk / markering
    search = d.bright_yellow,
    visual = '#303345',
  },
}

-- ─── Lys (foot nvim-light) ────────────────────────────────────────────────────
M.light = {
  term = {
    foreground = '#3d3d3d',
    background = '#f0e8d8',
    cursor = '#6f8fbd',
    ansi = {
      '#f5ede0', '#d63333', '#226b3d', '#a87b3e',
      '#2b5b9c', '#5a226e', '#226e6e', '#555555',
    },
    brights = {
      '#7b7b7b', '#e64444', '#338f5a', '#dcc26e',
      '#5c94e4', '#a63aa6', '#33b6b6', '#2a2a2a',
    },
  },
  editor = {
    comment = '#555555',
    string = '#005523',
    func = '#2a5a9c',
    keyword = '#470045',
    number = '#6b5300',
    variable = '#222222',
    type = '#d0a600',
    bg = '#e0e2ea',
    bg_alt = '#d4d6de',
    bg_float = '#eceef5',
    fg = '#222222',
    fg_muted = '#555555',
    border = '#aeb0b8',
    cursor = '#b8bac4',
    sel = '#b0b4c0',
    dim = '#9a9ca4',
    added = '#00aa46',
    changed = '#007373',
    removed = '#cc0000',
    diff_add = '#c8eac8',
    diff_change = '#c8dde8',
    diff_delete = '#ead0d0',
    diff_text = '#aacfe0',
    error = '#cc0000',
    warn = '#d0a600',
    info = '#2a5a9c',
    hint = '#007373',
    search = '#d0a600',
    visual = '#c0c2ca',
  },
}

return M
