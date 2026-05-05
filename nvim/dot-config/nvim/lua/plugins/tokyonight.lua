-- lua/plugins/theme.lua
vim.pack.add({ "https://github.com/folke/tokyonight.nvim" })

require("tokyonight").setup({
	style = "night",
	transparent = true,
	on_highlights = function(hl, _)
		-- Dim inactive splits — mirrors tmux window-style fg=#565f89
		hl.NormalNC = { fg = "#565f89", bg = "NONE" }
		-- Active statusline: bright background to stand out against transparent panes
		hl.StatusLine = { fg = "#c0caf5", bg = "#2d3f76" }
		-- Inactive statusline: clearly muted
		hl.StatusLineNC = { fg = "#3b4261", bg = "#0d0e16" }
		-- Window separator: bright accent so the split boundary is unmistakable
		hl.WinSeparator = { fg = "#2d3f76", bg = "NONE" }
	end,
})

vim.cmd("colorscheme tokyonight")
