local function update_tmux_window_name()
	local colors = {
		bg_dark = "#16161e",
		-- Clearer Vibrant Dark Tones
		dark_blue = "#2a3a6a",
		dark_green = "#2d4f3b",
		dark_orange = "#713e27",
		dark_purple = "#443666",
		-- Bright Accents for Text
		bright_blue = "#7aa2f7",
		bright_green = "#9ece6a",
		bright_orange = "#ff9e64",
		bright_purple = "#bb9af7",
		fg_text = "#c0caf5",
	}

	local mode_colors = {
		["n"] = { name = " NORMAL ", bg = colors.blue, fg = colors.black },
		["i"] = { name = " INSERT ", bg = colors.green, fg = colors.black },
		["v"] = { name = " VISUAL ", bg = colors.magenta, fg = colors.black },
		["V"] = { name = " V-LINE ", bg = colors.magenta, fg = colors.black },
		["\22"] = { name = " V-BLOCK ", bg = colors.magenta, fg = colors.black },
		["c"] = { name = " COMMAND ", bg = colors.orange, fg = colors.black },
	}
	local mode_map = {
		["n"] = "NORMAL",
		["i"] = "INSERT",
		["v"] = "VISUAL",
		["V"] = "V-LINE",
		["\22"] = "V-BLOCK",
		["c"] = "COMMAND",
		["R"] = "REPLACE",
	}
	-- Small delay to ensure filename is updated (especially for Telescope/File explorers)
	vim.defer_fn(function()
		local filename = vim.fn.expand("%:t")
		local buftype = vim.bo.buftype
		local m = mode_colors[vim.api.nvim_get_mode().mode] or { name = " NVIM ", bg = colors.blue, fg = colors.black }
		if buftype == "terminal" then
			filename = " Terminal"
		elseif filename == "" then
			filename = "󰈙 Empty"
		end
		local title = string.format("#[fg=%s,bold]%s#[fg=%s,nobold] %s ", m.fg, m.name, m.fg, filename)
		--local title = string.format("%s | %s", mode, filename)
		-- Update tmux window name
		os.execute("tmux rename-window '" .. title .. "'")
	end, 50)
end

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "WinEnter", "ModeChanged" }, {
	pattern = "*",
	callback = update_tmux_window_name,
})

-- Reset to automatic naming when you close Neovim
vim.api.nvim_create_autocmd("VimLeave", {
	callback = function()
		os.execute("tmux set-window-option automatic-rename on")
	end,
})
