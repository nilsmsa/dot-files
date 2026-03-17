-- lua/plugins/theme.lua
vim.pack.add({ "https://github.com/folke/tokyonight.nvim" })

require("tokyonight").setup({
	style = "night",
	transparent = true,
	on_highlights = function(hl, _)
		-- Dim inactive splits — mirrors tmux window-style fg=#565f89
		hl.NormalNC = { fg = "#565f89", bg = "NONE" }
	end,
})

vim.cmd("colorscheme tokyonight")
