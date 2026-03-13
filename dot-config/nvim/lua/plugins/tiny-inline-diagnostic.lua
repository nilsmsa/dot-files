vim.pack.add({ "https://github.com/rachartier/tiny-inline-diagnostic.nvim" })

require("tiny-inline-diagnostic").setup({
	preset = "modern", -- or "classic"
})

local signs = {
	[vim.diagnostic.severity.ERROR] = " ",
	[vim.diagnostic.severity.WARN] = " ",
	[vim.diagnostic.severity.HINT] = "󰠠 ",
	[vim.diagnostic.severity.INFO] = " ",
}

vim.diagnostic.config({
	virtual_text = false,
	underline = true,
	severity_sort = true,
	update_in_insert = false,
	signs = {
		text = signs,
	},
})
