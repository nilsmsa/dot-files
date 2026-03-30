-- Minimal 0.12 config with native pack
vim.pack.add({ "https://github.com/copilotlsp-nvim/copilot-lsp" })
vim.pack.add({ "https://github.com/zbirenbaum/copilot.lua" })


require("copilot").setup({
	suggestion = {
		enabled = false,
	},
})

