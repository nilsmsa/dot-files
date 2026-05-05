-- lua/plugins/theme.lua
vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })

-- Custom theme: active pane gets a visible blue tint, inactive is near-black
local theme = {
	normal   = { a = { fg = "#1a1b26", bg = "#7aa2f7", gui = "bold" }, b = { fg = "#c0caf5", bg = "#2d3f76" }, c = { fg = "#c0caf5", bg = "#1f2335" } },
	insert   = { a = { fg = "#1a1b26", bg = "#9ece6a", gui = "bold" }, b = { fg = "#c0caf5", bg = "#2d3f76" }, c = { fg = "#c0caf5", bg = "#1f2335" } },
	visual   = { a = { fg = "#1a1b26", bg = "#bb9af7", gui = "bold" }, b = { fg = "#c0caf5", bg = "#2d3f76" }, c = { fg = "#c0caf5", bg = "#1f2335" } },
	replace  = { a = { fg = "#1a1b26", bg = "#f7768e", gui = "bold" }, b = { fg = "#c0caf5", bg = "#2d3f76" }, c = { fg = "#c0caf5", bg = "#1f2335" } },
	command  = { a = { fg = "#1a1b26", bg = "#e0af68", gui = "bold" }, b = { fg = "#c0caf5", bg = "#2d3f76" }, c = { fg = "#c0caf5", bg = "#1f2335" } },
	inactive = { a = { fg = "#c0caf5", bg = "#2d3f76" }, b = { fg = "#3b4261", bg = "#0d0e16" }, c = { fg = "#3b4261", bg = "#0d0e16" } },
}

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = theme,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		always_show_tabline = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
			refresh_time = 16, -- ~60fps
			events = {
				"WinEnter",
				"BufEnter",
				"BufWritePost",
				"SessionLoadPost",
				"FileChangedShellPost",
				"VimResized",
				"Filetype",
				"CursorMoved",
				"CursorMovedI",
				"ModeChanged",
			},
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = { "filename" },
		lualine_b = {},
		lualine_c = {},
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})
