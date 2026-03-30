-- Minimal 0.12 config with native pack
vim.pack.add({ "https://github.com/copilotlsp-nvim/copilot-lsp" })
vim.pack.add({ "https://github.com/zbirenbaum/copilot.lua" })


require("copilot").setup({
	suggestion = {
		enabled = false,
	},
	nes = {
		enabled = true,
		-- NES keymaps registered by the plugin are normal-mode only.
		-- Insert-mode bindings are added separately in keymaps.lua.
		keymap = {
			accept_and_goto = "<M-a>",
			accept = false,
			dismiss = "<M-e>",
		},
	},
})

-- Insert-mode NES keymaps (plugin only registers normal-mode ones)
local nes_api = require("copilot.nes.api")
vim.keymap.set("i", "<M-a>", function()
	if nes_api.nes_apply_pending_nes() then
		nes_api.nes_walk_cursor_end_edit()
	end
end, { desc = "NES: accept suggestion", silent = true })
vim.keymap.set("i", "<M-e>", function()
	nes_api.nes_clear()
end, { desc = "NES: dismiss suggestion", silent = true })
