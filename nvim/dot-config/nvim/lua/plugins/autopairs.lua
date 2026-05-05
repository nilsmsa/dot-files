vim.pack.add({ "https://github.com/windwp/nvim-autopairs" })

require("nvim-autopairs").setup({
	disable_filetype = { "TelescopePrompt", "vim" },
	disable_in_macro = true,
	disable_in_visualblock = false,
	disable_in_replace_mode = true,
	ignored_next_char = "[%w%.]",
	enable_moveright = true,
	enable_afterquote = true,
	map_bs = true,
	map_c_h = false,
	map_c_w = false,
	fast_wrap = {
		map = "<M-e>",
		chars = { "{", "[", "(", '"', "'" },
		pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
		offset = 0,
		end_key = "$",
		keys = "qwertyuiopzxcvbnmasdfghjkl",
		check_comma = true,
		highlight = "PmenuSel",
		highlight_grey = "LineNr",
	},
})
