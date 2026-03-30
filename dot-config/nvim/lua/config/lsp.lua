local augroup = function(name)
	return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

local toggle_inlay_hints = function()
	local enabled = not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
	vim.lsp.inlay_hint.enable(enabled, { bufnr = 0 })
	vim.notify("Inlay hints: " .. (enabled and "ON" or "OFF"))
end

local default_keymaps = {
	{ keys = "<leader>ca", func = vim.lsp.buf.code_action, desc = "Code Actions" },
	{ keys = "<leader>cr", func = vim.lsp.buf.rename, desc = "Code Rename" },
	{ keys = "<leader>k", func = vim.lsp.buf.hover, desc = "Hover Documentation", has = "hoverProvider" },
	{ keys = "<leader>cd", func = vim.lsp.buf.definition, desc = "Goto Definition", has = "definitionProvider" },
	{ keys = "<leader>cD", func = vim.lsp.buf.declaration, desc = "Goto Declaration", has = "declarationProvider" },
	{ keys = "<leader>cR", func = vim.lsp.buf.references, desc = "List References", has = "referencesProvider" },
	{
		keys = "<leader>ci",
		func = vim.lsp.buf.implementation,
		desc = "Goto Implementation",
		has = "implementationProvider",
	},
	{
		keys = "<leader>ct",
		func = vim.lsp.buf.type_definition,
		desc = "Type Definition",
		has = "typeDefinitionProvider",
	},
	{ keys = "<leader>K", func = vim.lsp.buf.hover, desc = "Hover Docs", has = "hoverProvider" },
	{ keys = "<leader>cs", func = vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelpProvider" },
	{
		keys = "<leader>cf",
		func = function()
			vim.lsp.buf.format({ async = true })
		end,
		desc = "Format Buffer",
		has = "documentFormattingProvider",
	},
	{ keys = "<leader>wa", func = vim.lsp.buf.add_workspace_folder, desc = "Add Workspace Folder", has = "workspace" },
	{
		keys = "<leader>wr",
		func = vim.lsp.buf.remove_workspace_folder,
		desc = "Remove Workspace Folder",
		has = "workspace",
	},
	{
		keys = "<leader>wl",
		func = function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end,
		desc = "List Workspace Folders",
		has = "workspace",
	},
	{
		keys = "<leader>i",
		func = toggle_inlay_hints,
		desc = "Toggle LSP Inlay Hints",
	},
}

-- I use blink.cmp for completion, but you can use native completion too
local completion = vim.g.completion_mode or "blink" -- or 'native' for built-in completion
vim.api.nvim_create_autocmd("LspAttach", {
	group = augroup("lsp_attach"),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		local buf = args.buf
		if client then
			-- Built-in completion
			if completion == "native" and client:supports_method("textDocument/completion") then
				vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
			end

			-- Inlay hints
			if client:supports_method("textDocument/inlayHints") then
				vim.lsp.inlay_hint.enable(false, { bufnr = args.buf })
			end

			if client:supports_method("textDocument/documentColor") then
				vim.lsp.document_color.enable(true, { bufnr = args.buf }, {
					style = "background", -- 'background', 'foreground', or 'virtual'
				})
			end
			local wk = require("which-key")

			-- Prepare a list for WhichKey
			local wk_mappings = {}
			for _, km in ipairs(default_keymaps) do
				-- Only bind if there's no `has` requirement, or the server supports it
				if not km.has or client.server_capabilities[km.has] then
					vim.keymap.set(
						km.mode or "n",
						km.keys,
						km.func,
						{ buffer = buf, desc = "LSP: " .. km.desc, nowait = km.nowait }
					)
				end
			end
			for _, map in ipairs(default_keymaps) do
				-- Check capabilities
				if map.has == "workspace" or client.server_capabilities[map.has] then
					table.insert(wk_mappings, {
						map.keys,
						map.func,
						desc = map.desc,
						buffer = buf, -- CRITICAL: Ties the mapping to the current buffer
						mode = map.mode or "n",
					})
				end
			end
			wk.add(wk_mappings)
		end
	end,
})

-- Enable LSP servers for Neovim 0.11+
vim.lsp.enable({
	"lua_ls",
	--"kotlin_language_server",
})

-- Load Lsp on-demand, e.g: eslint is disable by default
-- e.g: We could enable eslint by set vim.g.lsp_on_demands = {"eslint"}
if vim.g.lsp_on_demands then
	vim.lsp.enable(vim.g.lsp_on_demands)
end
