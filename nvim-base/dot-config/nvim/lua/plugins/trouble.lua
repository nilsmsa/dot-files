vim.pack.add({ "https://github.com/folke/trouble.nvim" }, { "https://github.com/nvim-tree/nvim-web-devicons" })

require("trouble").setup({
	focus = false,
	icons = { indent = { ws = "  " } },
	modes = {
		buf_diag = {
			mode = "diagnostics",
			filter = { buf = 0 },
			follow = true,
			auto_close = false,
			win = {
				position = "bottom",
				size = { height = 8 },
			},
		},
	},
})

vim.keymap.set("n", "t", "<cmd>Trouble buf_diag toggle<cr>", { desc = "Toggle Buffer Diagnostics" })
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>xX", "<cmd>Trouble buf_diag toggle<cr>", { desc = "Buffer Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>cs", function()
	local trouble = require("trouble")
	if trouble.is_open("symbols") then
		trouble.close("symbols")
		return
	end

	local function tree_window()
		for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
			if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "neo-tree" then
				return win
			end
		end
	end

	local source_win = vim.api.nvim_get_current_win()
	if vim.bo[vim.api.nvim_win_get_buf(source_win)].buftype ~= "" then
		for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
			if vim.bo[vim.api.nvim_win_get_buf(win)].buftype == "" then
				source_win = win
				break
			end
		end
	end

	local tree_win = tree_window()
	if not tree_win then
		vim.cmd("Neotree filesystem show")
		tree_win = tree_window()
	end
	if not tree_win then return end

	-- Knyt symbolene til kodevinduet, men del selve Neo-tree-kolonnen.
	vim.api.nvim_set_current_win(source_win)
	trouble.open({
		mode = "symbols",
		focus = false,
		win = { type = "split", relative = "win", win = tree_win, position = "bottom", size = 0.4 },
	})
end, { desc = "Symbols (Trouble)" })
vim.keymap.set(
	"n",
	"<leader>cl",
	"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
	{ desc = "LSP Definitions / references / ... (Trouble)" }
)
vim.keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })
