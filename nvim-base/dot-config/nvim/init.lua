vim.g.mapleader = " "
vim.g.maplocalleader = " "
require("config")
require("plugins")

--require('theme_state')
--
local function apply_custom_highlights()
  local is_dark = vim.o.background == "dark"

  -- The Color Palette: High contrast, low eye-strain
  local colors = {
    comment  = is_dark and "#8b9eb3" or "#7c808d", -- Muted cool grey
    string   = is_dark and "#a6e3a1" or "#3a824e", -- Soft sage green / Deep forest green
    func     = is_dark and "#89b4fa" or "#1d4ed8", -- Soft sky blue / Rich royal blue
    keyword  = is_dark and "#cba6f7" or "#6b21a8", -- Soft lavender / Deep plum
    number   = is_dark and "#fab387" or "#c2410c", -- Warm peach / Burnt orange
    variable = is_dark and "#cdd6f4" or "#334155", -- Off-white / Charcoal grey
    type     = is_dark and "#f9e2af" or "#b45309", -- Soft coral red / Brick red
  }

  -- Define the styles and link modern Treesitter/LSP groups to them
  local highlights = {
    -- 1. Comments
    Comment = { fg = colors.comment, italic = true },
    ["@comment"] = { link = "Comment" },
    ["@lsp.type.comment"] = { link = "Comment" },

    -- 2. Strings
    String = { fg = colors.string },
    ["@string"] = { link = "String" },
    ["@lsp.type.string"] = { link = "String" },

    -- 3. Functions & Methods
    Function = { fg = colors.func, bold = true },
    ["@function"] = { link = "Function" },
    ["@lsp.type.function"] = { link = "Function" },
    ["@lsp.type.method"] = { link = "Function" },

    -- 4. Keywords (if, return, local, etc.)
    Keyword = { fg = colors.keyword, italic = true },
    ["@keyword"] = { link = "Keyword" },
    ["@lsp.type.keyword"] = { link = "Keyword" },

    -- 5. Numbers and Constants
    Number = { fg = colors.number },
    Constant = { fg = colors.number },
    ["@number"] = { link = "Number" },
    ["@constant"] = { link = "Constant" },
    ["@lsp.type.number"] = { link = "Number" },
    ["@lsp.type.enumMember"] = { link = "Constant" },

    -- 6. Variables and Identifiers
    Identifier = { fg = colors.variable },
    ["@variable"] = { link = "Identifier" },
    ["@lsp.type.variable"] = { link = "Identifier" },

    -- 7. Types (Classes, Structs, Enums)
    Type = { fg = colors.type },
    ["@type"] = { link = "Type" },
    ["@lsp.type.class"] = { link = "Type" },
    ["@lsp.type.type"] = { link = "Type" },
  }

  -- Loop through the table and apply them all
  for group, opts in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, opts)
  end
end

-- 1. Apply immediately on startup
apply_custom_highlights()

-- 2. Create the augroup for our listeners
local highlight_group = vim.api.nvim_create_augroup("CustomHighlights", { clear = true })

-- 3. Re-apply if the background changes (e.g., toggling light/dark mode)
vim.api.nvim_create_autocmd("OptionSet", {
  group = highlight_group,
  pattern = "background",
  callback = apply_custom_highlights,
})

-- 4. Keep the ColorScheme listener active
vim.api.nvim_create_autocmd("ColorScheme", {
  group = highlight_group,
  pattern = "*",
  callback = apply_custom_highlights,
})
