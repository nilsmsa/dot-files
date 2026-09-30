local M = {}

local function apply_custom_highlights()
  local is_dark = vim.o.background == "dark"

  -- Paletten deles med wezterm: ~/.config/theme/palette.lua
  local palette = dofile(vim.fn.expand("~/.config/theme/palette.lua"))
  local colors = is_dark and palette.dark.editor or palette.light.editor

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
    PmenuSel     = { fg = colors.fg, bg = colors.sel, bold = true },
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
    DiffAdd      = { bg = colors.diff_add },
    DiffChange   = { bg = colors.diff_change },
    DiffDelete   = { fg = colors.removed, bg = colors.diff_delete },
    DiffText     = { bg = colors.diff_text, bold = true },

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

    -- ── Snacks picker ─────────────────────────────────────────────────────────
    SnacksPickerListCursorLine  = { bg = colors.sel, bold = true },
    SnacksPickerInputCursorLine = { bg = colors.sel },

    -- ── Snacks dim ────────────────────────────────────────────────────────────
    SnacksDim = { fg = colors.dim },

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
