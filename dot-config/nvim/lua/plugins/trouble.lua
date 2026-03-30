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
				size = { height = 12 },
			},
		},
	},
})

vim.keymap.set("n", "t", "<cmd>Trouble buf_diag toggle<cr>", { desc = "Toggle Buffer Diagnostics" })
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>xX", "<cmd>Trouble buf_diag toggle<cr>", { desc = "Buffer Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
vim.keymap.set(
	"n",
	"<leader>cl",
	"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
	{ desc = "LSP Definitions / references / ... (Trouble)" }
)
vim.keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })
