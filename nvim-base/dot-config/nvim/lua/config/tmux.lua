local function in_tmux()
	return os.getenv("TMUX") ~= nil
end

local function update_tmux_window_name()
	if not in_tmux() then
		return
	end
	-- Small delay to ensure filename is updated (especially for Telescope/file explorers)
	vim.defer_fn(function()
		local filename = vim.fn.expand("%:t")
		local buftype = vim.bo.buftype
		local name
		if buftype == "terminal" then
			name = "Terminal"
		elseif filename == "" then
			name = "[No Name]"
		else
			name = filename
		end
		os.execute("tmux set-window-option automatic-rename off && tmux rename-window '" .. name:gsub("'", "'\\''" ) .. "'")
	end, 50)
end

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "WinEnter" }, {
	pattern = "*",
	callback = update_tmux_window_name,
})

-- Reset to automatic naming when Neovim exits
vim.api.nvim_create_autocmd("VimLeave", {
	callback = function()
		if in_tmux() then
			os.execute("tmux set-window-option automatic-rename on")
		end
	end,
})
