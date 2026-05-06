-- lua/plugins/theme.lua
vim.pack.add({ { src = "https://github.com/mrcjkb/rustaceanvim", version = vim.version.range("^9") } })

-- Configuration is done via a global variable, NOT a setup function
vim.g.rustaceanvim = {
	server = {
		settings = {
			["rust-analyzer"] = {
				completion = {
					-- Fill in parameter names as snippet tab stops instead of just adding ()
					callable = { snippets = "fill_arguments" },
				},
			},
		},
	},
}
