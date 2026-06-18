local M = {}

local function apply_custom_highlights()
  local is_dark = vim.o.background == "dark"

  -- ─── Colour Palette ─────────────────────────────────────────────────────────
  -- Background/foreground sourced from foot themes:
  --   dark:  terminal/dot-config/foot/themes/nvim-dark.ini   (bg=#14161b, fg=#dcdccc)
  --   light: terminal/dot-config/foot/themes/nvim-light.ini  (bg=#e0e2ea, fg=#222222)
  -- Syntax and accent colours are derived from the same foot palettes for consistency.
  local colors = {
    -- Syntax (dark: Zenburn-ish from foot dark palette; light: from foot light palette)
    comment  = is_dark and "#6fa0af" or "#555555", -- foot blue / bright-black
    string   = is_dark and "#bfebbf" or "#005523", -- bright green / green
    func     = is_dark and "#8cd0d3" or "#2a5a9c", -- cyan / blue
    keyword  = is_dark and "#cc85cc" or "#470045", -- magenta / magenta
    number   = is_dark and "#d0bf8f" or "#6b5300", -- yellow / yellow-brown
    variable = is_dark and "#dcdccc" or "#222222", -- fg / fg
    type     = is_dark and "#f0dfaf" or "#d0a600", -- bright yellow / bright yellow
    -- UI chrome (anchored to foot terminal backgrounds)
    bg       = is_dark and "#14161b" or "#e0e2ea", -- foot dark bg / foot light bg
    bg_alt   = is_dark and "#1a1c22" or "#d4d6de", -- slightly lighter / slightly darker
    bg_float = is_dark and "#1e2025" or "#eceef5", -- popup bg
    fg       = is_dark and "#dcdccc" or "#222222", -- foot fg
    fg_muted = is_dark and "#606060" or "#555555", -- foot bright-black
    border   = is_dark and "#3a3d45" or "#aeb0b8",
    cursor   = is_dark and "#2c2f3a" or "#b8bac4", -- cursor-line highlight
    -- Git / diff
    added    = is_dark and "#bfebbf" or "#00aa46", -- bright green
    changed  = is_dark and "#8cd0d3" or "#007373", -- cyan
    removed  = is_dark and "#dca3a3" or "#cc0000", -- bright red / red
    -- Diagnostics
    error    = is_dark and "#dca3a3" or "#cc0000",
    warn     = is_dark and "#f0dfaf" or "#d0a600",
    info     = is_dark and "#8cd0d3" or "#2a5a9c",
    hint     = is_dark and "#8cd0d3" or "#007373",
    -- Search / selection
    search   = is_dark and "#f0dfaf" or "#d0a600",
    visual   = is_dark and "#2a2d35" or "#c0c2ca",
  }

  local highlights = {
    -- ── Syntax ───────────────────────────────────────────────────────────────
    Comment = { fg = colors.comment, italic = true },
    ["@comment"] = { link = "Comment" },
    ["@lsp.type.comment"] = { link = "Comment" },

    String = { fg = colors.string },
    ["@string"] = { link = "String" },
    ["@lsp.type.string"] = { link = "String" },

    Function = { fg = colors.func, bold = true },
    ["@function"] = { link = "Function" },
    ["@lsp.type.function"] = { link = "Function" },
    ["@lsp.type.method"] = { link = "Function" },

    Keyword = { fg = colors.keyword, italic = true },
    ["@keyword"] = { link = "Keyword" },
    ["@lsp.type.keyword"] = { link = "Keyword" },

    Number = { fg = colors.number },
    Constant = { fg = colors.number },
    ["@number"] = { link = "Number" },
    ["@constant"] = { link = "Constant" },
    ["@lsp.type.number"] = { link = "Number" },
    ["@lsp.type.enumMember"] = { link = "Constant" },

    Identifier = { fg = colors.variable },
    ["@variable"] = { link = "Identifier" },
    ["@lsp.type.variable"] = { link = "Identifier" },

    Type = { fg = colors.type },
    ["@type"] = { link = "Type" },
    ["@lsp.type.class"] = { link = "Type" },
    ["@lsp.type.type"] = { link = "Type" },

    -- ── Editor UI ─────────────────────────────────────────────────────────────
    Normal       = { fg = colors.fg, bg = colors.bg },
    NormalNC     = { fg = colors.fg, bg = colors.bg },
    CursorLine   = { bg = colors.cursor },
    CursorLineNr = { fg = colors.func, bold = true },
    LineNr       = { fg = colors.fg_muted },
    SignColumn   = { bg = colors.bg },
    ColorColumn  = { bg = colors.cursor },
    VertSplit    = { fg = colors.border },
    WinSeparator = { fg = colors.border },
    EndOfBuffer  = { fg = colors.fg_muted },
    Folded       = { fg = colors.comment, bg = colors.bg_alt, italic = true },
    FoldColumn   = { fg = colors.fg_muted, bg = colors.bg },

    -- ── Floating windows & popups ─────────────────────────────────────────────
    NormalFloat  = { fg = colors.fg, bg = colors.bg_float },
    FloatBorder  = { fg = colors.border, bg = colors.bg_float },
    FloatTitle   = { fg = colors.func, bg = colors.bg_float, bold = true },

    -- ── Completion menu ───────────────────────────────────────────────────────
    Pmenu        = { fg = colors.fg, bg = colors.bg_float },
    PmenuSel     = { fg = colors.fg, bg = colors.cursor, bold = true },
    PmenuSbar    = { bg = colors.bg_alt },
    PmenuThumb   = { bg = colors.border },

    -- ── Search & substitution ─────────────────────────────────────────────────
    Search       = { fg = colors.bg, bg = colors.search, bold = true },
    CurSearch    = { fg = colors.bg, bg = colors.func, bold = true },
    IncSearch    = { fg = colors.bg, bg = colors.func, bold = true },
    Substitute   = { fg = colors.bg, bg = colors.removed },

    -- ── Visual selection ──────────────────────────────────────────────────────
    Visual       = { bg = colors.visual },
    VisualNOS    = { bg = colors.visual },

    -- ── Diff ──────────────────────────────────────────────────────────────────
    DiffAdd      = { bg = is_dark and "#1a2e1a" or "#c8eac8" },
    DiffChange   = { bg = is_dark and "#1a2430" or "#c8dde8" },
    DiffDelete   = { fg = colors.removed, bg = is_dark and "#2e1a1a" or "#ead0d0" },
    DiffText     = { bg = is_dark and "#1e3040" or "#aacfe0", bold = true },

    -- ── Diagnostics ───────────────────────────────────────────────────────────
    DiagnosticError          = { fg = colors.error },
    DiagnosticWarn           = { fg = colors.warn },
    DiagnosticInfo           = { fg = colors.info },
    DiagnosticHint           = { fg = colors.hint },
    DiagnosticUnderlineError = { undercurl = true, sp = colors.error },
    DiagnosticUnderlineWarn  = { undercurl = true, sp = colors.warn },
    DiagnosticUnderlineInfo  = { undercurl = true, sp = colors.info },
    DiagnosticUnderlineHint  = { undercurl = true, sp = colors.hint },
    DiagnosticVirtualTextError = { fg = colors.error, italic = true },
    DiagnosticVirtualTextWarn  = { fg = colors.warn,  italic = true },
    DiagnosticVirtualTextInfo  = { fg = colors.info,  italic = true },
    DiagnosticVirtualTextHint  = { fg = colors.hint,  italic = true },

    -- ── Git signs (gitsigns.nvim) ─────────────────────────────────────────────
    GitSignsAdd    = { fg = colors.added },
    GitSignsChange = { fg = colors.changed },
    GitSignsDelete = { fg = colors.removed },

    -- ── Status & tab line ─────────────────────────────────────────────────────
    StatusLine   = { fg = colors.fg,       bg = colors.bg_alt },
    StatusLineNC = { fg = colors.fg_muted, bg = colors.bg_alt },
    TabLine      = { fg = colors.fg_muted, bg = colors.bg_alt },
    TabLineFill  = { bg = colors.bg_alt },
    TabLineSel   = { fg = colors.fg,       bg = colors.bg, bold = true },

    -- ── Spelling ──────────────────────────────────────────────────────────────
    SpellBad   = { undercurl = true, sp = colors.error },
    SpellCap   = { undercurl = true, sp = colors.warn },
    SpellRare  = { undercurl = true, sp = colors.hint },
    SpellLocal = { undercurl = true, sp = colors.info },

    -- ── Misc UI ───────────────────────────────────────────────────────────────
    MatchParen    = { fg = colors.func, bold = true, underline = true },
    NonText       = { fg = colors.fg_muted },
    SpecialKey    = { fg = colors.fg_muted },
    Whitespace    = { fg = colors.fg_muted },
    Title         = { fg = colors.func, bold = true },
    Directory     = { fg = colors.func },
    Question      = { fg = colors.warn },
    MoreMsg       = { fg = colors.added },
    WarningMsg    = { fg = colors.warn },
    ErrorMsg      = { fg = colors.error, bold = true },
  }

  for group, opts in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, opts)
  end
end

function M.setup()
  apply_custom_highlights()

  local highlight_group = vim.api.nvim_create_augroup("CustomHighlights", { clear = true })

  vim.api.nvim_create_autocmd("OptionSet", {
    group = highlight_group,
    pattern = "background",
    callback = apply_custom_highlights,
  })

  vim.api.nvim_create_autocmd("ColorScheme", {
    group = highlight_group,
    pattern = "*",
    callback = apply_custom_highlights,
  })
end

return M
