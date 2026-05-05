--- diagnostic settings
local map = vim.keymap.set

vim.api.nvim_set_hl(0, "DapBreakpointSign", { fg = "#FF0000", bg = nil, bold = true })
vim.fn.sign_define("DapBreakpoint", {
	text = "●",
	texthl = "DapBreakpointSign",
	linehl = "",
	numhl = "",
})

local sev = vim.diagnostic.severity

vim.diagnostic.config({
	underline = true,
	severity_sort = true,
	update_in_insert = false,
	float = {
		border = "rounded",
		source = true,
	},
	signs = {
		text = {
			[sev.ERROR] = "󰅚 ", -- nf-md-close_circle
			[sev.WARN]  = "󰀪 ", -- nf-md-alert
			[sev.INFO]  = "󰋽 ", -- nf-md-information_outline
			[sev.HINT]  = "󰌵 ", -- nf-md-lightbulb (already working)
		},
	},
	virtual_text = false,
})

-- diagnostic keymaps
local diagnostic_goto = function(next, severity)
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		vim.diagnostic.jump({ count = next and 1 or -1, float = false, severity = severity })
	end
end

map("n", "<leader>ce", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "T", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })
