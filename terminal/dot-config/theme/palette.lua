-- Felles fargepalett for wezterm og neovim.
-- Lastes med dofile() fra ~/.config/theme/palette.lua.
--
-- Hver modus har:
--   term    : felter wezterm bruker (foreground, background, cursor, ansi, brights)
--   editor  : felter neovim bruker (syntaks, UI, diff, diagnostikk)
-- I mørk modus hentes syntaksfargene fra ANSI-fargene, så de følger hverandre.

local M = {}

-- ─── Mørk (foot less-dark) ────────────────────────────────────────────────────
local d = {
  black = '#3c3c3c', red = '#e06c75', green = '#98c379', yellow = '#e5c07b',
  blue = '#61afef', magenta = '#c678dd', cyan = '#56b6c2', white = '#d6d6ca',
  bright_black = '#828282', bright_red = '#f08085', bright_green = '#b0dc8b',
  bright_yellow = '#f5cf8a', bright_blue = '#82c0e8', bright_magenta = '#d090d0',
  bright_cyan = '#78d4d8', bright_white = '#e4e4d8',
}
local dark_bg = '#151a21'

M.dark = {
  term = {
    foreground = '#a8a89e',
    background = dark_bg,
    cursor = '#7a9cc6',
    ansi = { d.black, d.red, d.green, d.yellow, d.blue, d.magenta, d.cyan, d.white },
    brights = {
      d.bright_black, d.bright_red, d.bright_green, d.bright_yellow,
      d.bright_blue, d.bright_magenta, d.bright_cyan, d.bright_white,
    },
  },
  editor = {
    -- Syntaks
    comment = d.blue,
    string = d.bright_green,
    func = d.cyan,
    keyword = d.magenta,
    number = d.yellow,
    variable = '#c2c2b7',
    type = d.bright_yellow,
    -- UI
    bg = dark_bg,
    bg_alt = '#1c222b',
    bg_float = '#202731',
    fg = '#c2c2b7',
    fg_muted = d.bright_black,
    border = '#343b47',
    cursor = '#222936',
    sel = '#26344c',
    dim = '#3d434e',
    -- Git / diff
    added = d.bright_green,
    changed = d.cyan,
    removed = d.bright_red,
    diff_add = '#242e24',
    diff_change = '#23293a',
    diff_delete = '#30252a',
    diff_text = '#263242',
    -- Diagnostikk
    error = d.bright_red,
    warn = d.bright_yellow,
    info = d.cyan,
    hint = d.cyan,
    -- Søk / markering
    search = d.bright_yellow,
    visual = '#2a2f3c',
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
