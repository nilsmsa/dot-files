vim.pack.add({ "https://github.com/saecki/crates.nvim" })
-- 1. Define the config for 'crates'
-- (Blink automatically injects capabilities if using the 0.11+ API)
vim.lsp.config("crates", {
	cmd = { "lua", "require('crates').start_lsp()" }, -- Internal command for crates.nvim
	root_markers = { "Cargo.toml" },
})

-- 2. Enable it
vim.lsp.enable("crates")

require("crates").setup({
	lsp = {
		enabled = true,
		completion = true,
		hover = true,
	},
})
