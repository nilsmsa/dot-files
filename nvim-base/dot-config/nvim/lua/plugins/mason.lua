-- 1. Register and download plugins from GitHub
-- On first run, Neovim 0.12 may prompt to install these
vim.pack.add({
	"https://github.com/williamboman/mason.nvim",
	"https://github.com/williamboman/mason-lspconfig.nvim",
	"https://github.com/neovim/nvim-lspconfig",
})

-- 2. Initialize plugins in the correct order
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"bashls",
		"gradle_ls",
		"kotlin_lsp",
		"postgres_lsp",
	}, -- Use 'lua_ls', NOT 'lua-lsp'
})

-- 3. Configure the LSP client
--local lspconfig = require("lspconfig")
--lspconfig.lua_ls.setup({
--	settings = {
--		Lua = {
--			diagnostics = { globals = { "vim" } }, -- Fixes 'undefined global vim'
--		},
--	},
--})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } }, -- Fixes 'undefined global vim'
		},
	},
})

vim.lsp.enable("lua_ls")
