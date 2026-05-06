-- lua/plugins/theme.lua
vim.pack.add({ "https://github.com/folke/tokyonight.nvim" })

require("tokyonight").setup({
	style = "night",
	transparent = true,
	on_highlights = function(hl, c)
		-- Dim inactive splits — mirrors tmux window-style fg=#565f89
		hl.NormalNC = { fg = "#565f89", bg = "NONE" }
		-- Active statusline: bright background to stand out against transparent panes
		hl.StatusLine = { fg = "#c0caf5", bg = "#2d3f76" }
		-- Inactive statusline: clearly muted
		hl.StatusLineNC = { fg = "#3b4261", bg = "#0d0e16" }
		-- Window separator: bright accent so the split boundary is unmistakable
		hl.WinSeparator = { fg = "#2d3f76", bg = "NONE" }

		-- blink.cmp — give float windows a solid surface so they contrast
		-- against the transparent background. bg_float is NONE when
		-- transparent=true, so we override with an elevated dark tone.
		local surface = "#1e2030"
		local border = c.border_highlight -- #29a4bd (cyan accent)
		hl.BlinkCmpMenu = { fg = c.fg, bg = surface }
		hl.BlinkCmpMenuBorder = { fg = border, bg = surface }
		hl.BlinkCmpMenuSelection = { bg = "#2d3f76" } -- same blue as statusline
		hl.BlinkCmpDoc = { fg = c.fg, bg = surface }
		hl.BlinkCmpDocBorder = { fg = border, bg = surface }
		hl.BlinkCmpLabelMatch = { fg = c.blue1, bold = true } -- highlight typed chars
	end,
})

vim.cmd("colorscheme tokyonight")
