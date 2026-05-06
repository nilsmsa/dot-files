vim.pack.add({ { src = "https://github.com/saecki/crates.nvim", version = vim.version.range("^0.7") } })

require("crates").setup({
	lsp = {
		enabled = true,
		completion = true,
		hover = true,
	},
})
