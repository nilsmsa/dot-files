vim.pack.add({
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/sindrets/diffview.nvim",
})

-- Setup gitsigns.nvim
require("gitsigns").setup({
	current_line_blame = true,
	signs = {
		add = { text = "▎" },
		change = { text = "▎" },
		delete = { text = "" },
		topdelete = { text = "" },
		changedelete = { text = "▎" },
		untracked = { text = "▎" },
	},
	signs_staged = {
		add = { text = "▎" },
		change = { text = "▎" },
		delete = { text = "" },
		topdelete = { text = "" },
		changedelete = { text = "▎" },
	},
	on_attach = function(buffer)
		local gs = package.loaded.gitsigns

		local function map(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = buffer, desc = desc })
		end

		-- Navigation: Hunk navigation
		map("n", "]h", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gs.nav_hunk("next")
			end
		end, "Next Hunk")

		map("n", "[h", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gs.nav_hunk("prev")
			end
		end, "Prev Hunk")

		map("n", "]H", function()
			gs.nav_hunk("last")
		end, "Last Hunk")
		map("n", "[H", function()
			gs.nav_hunk("first")
		end, "First Hunk")

		-- Context helpers: Blame and diff preview
		-- Note: Staging/resetting is handled via terminal (git add, git reset)
		map("n", "<leader>vhp", gs.preview_hunk_inline, "Preview Hunk Inline")
		map("n", "<leader>vhb", function()
			gs.blame_line({ full = true })
		end, "Blame Line")
		map("n", "<leader>vhB", function()
			gs.blame()
		end, "Blame Buffer")
		map("n", "<leader>vhd", gs.diffthis, "Diff This")
		map("n", "<leader>vhD", function()
			gs.diffthis("~")
		end, "Diff This ~")

		map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
	end,
})

-- Setup diffview.nvim
local actions = require("diffview.actions")

require("diffview").setup({
	diff_binaries = false,
	enhanced_diff_hl = true, -- Better diff highlighting
	use_icons = true,
	show_help_hints = true,
	watch_index = true,
	icons = {
		folder_closed = "",
		folder_open = "",
	},
	signs = {
		fold_closed = "",
		fold_open = "",
		done = "✓",
	},
	view = {
		default = {
			layout = "diff2_horizontal",
			disable_diagnostics = true, -- Cleaner view
			winbar_info = true,
		},
		merge_tool = {
			layout = "diff3_horizontal", -- diff3_horizontal | diff3_vertical | diff3_mixed | diff4_mixed
			disable_diagnostics = true,
			winbar_info = true,
		},
		file_history = {
			layout = "diff2_horizontal",
			disable_diagnostics = true,
			winbar_info = true,
		},
	},
	file_panel = {
		listing_style = "tree",
		tree_options = {
			flatten_dirs = true,
			folder_statuses = "only_folded",
		},
		win_config = {
			position = "left",
			width = 40,
		},
	},
	file_history_panel = {
		log_options = {
			git = {
				single_file = {
					diff_merges = "combined",
				},
				multi_file = {
					diff_merges = "first-parent",
				},
			},
		},
		win_config = {
			position = "bottom",
			height = 15,
		},
	},
	keymaps = {
		disable_defaults = false,
		view = {
			{ "n", "q", "<Cmd>DiffviewClose<CR>", { desc = "Close diff view" } },

			-- Navigation
			{ "n", "]c", actions.select_next_entry, { desc = "Next file" } },
			{ "n", "[c", actions.select_prev_entry, { desc = "Previous file" } },
			{ "n", "]f", actions.select_next_entry, { desc = "Next file" } },
			{ "n", "[f", actions.select_prev_entry, { desc = "Previous file" } },
			-- more easy in macos
			{ "n", "<C-n>", actions.select_next_entry, { desc = "Next file" } },
			{ "n", "<C-p>", actions.select_prev_entry, { desc = "Previous file" } },

			-- Toggle file panel
			{ "n", "<leader>b", actions.toggle_files, { desc = "Toggle file panel" } },

			-- Conflict resolution
			{ "n", "<leader>co", actions.conflict_choose("ours"), { desc = "Choose OURS" } },
			{ "n", "<leader>ct", actions.conflict_choose("theirs"), { desc = "Choose THEIRS" } },
			{ "n", "<leader>cb", actions.conflict_choose("all"), { desc = "Choose BOTH" } },
			{ "n", "<leader>cx", actions.conflict_choose("none"), { desc = "Delete conflict" } },
			{ "n", "]x", actions.next_conflict, { desc = "Next conflict" } },
			{ "n", "[x", actions.prev_conflict, { desc = "Previous conflict" } },
			{ "n", "<C-j>", actions.next_conflict, { desc = "Next conflict" } },
			{ "n", "<C-k>", actions.prev_conflict, { desc = "Previous conflict" } },

			-- Keep useful defaults
			{ "n", "<tab>", actions.select_next_entry, { desc = "Next file" } },
			{ "n", "<s-tab>", actions.select_prev_entry, { desc = "Previous file" } },
			{ "n", "gf", actions.goto_file_edit, { desc = "Go to file" } },
		},
		diff3 = {
			-- Conflict resolution in 3-way diff
			{ { "n", "x" }, "2do", actions.diffget("ours"), { desc = "Get from OURS" } },
			{ { "n", "x" }, "3do", actions.diffget("theirs"), { desc = "Get from THEIRS" } },
		},
		file_panel = {
			{ "n", "q", "<Cmd>DiffviewClose<CR>", { desc = "Close diff view" } },
			{ "n", "<cr>", actions.select_entry, { desc = "Open diff" } },
			{ "n", "o", actions.select_entry, { desc = "Open diff" } },
			{ "n", "l", actions.select_entry, { desc = "Open diff" } },
			{ "n", "R", actions.refresh_files, { desc = "Refresh" } },
			{ "n", "<leader>b", actions.toggle_files, { desc = "Toggle file panel" } },
			{ "n", "i", actions.listing_style, { desc = "Toggle list/tree" } },
			-- Note: Staging handled via terminal (git add, git reset)
			{ "n", "]c", actions.next_entry, { desc = "Next entry" } },
			{ "n", "[c", actions.prev_entry, { desc = "Previous entry" } },
		},
		file_history_panel = {
			{ "n", "q", "<Cmd>DiffviewClose<CR>", { desc = "Close" } },
			{ "n", "<cr>", actions.select_entry, { desc = "Open diff" } },
			{ "n", "o", actions.select_entry, { desc = "Open diff" } },
			{ "n", "l", actions.select_entry, { desc = "Open diff" } },
			{ "n", "y", actions.copy_hash, { desc = "Copy commit hash" } },
			{ "n", "L", actions.open_commit_log, { desc = "Show commit details" } },
			{ "n", "<leader>b", actions.toggle_files, { desc = "Toggle file panel" } },
		},
	},
})

-- Simplified keybinds for focused git workflow
-- Terminal: git add, git commit, git push, git rebase
-- Nvim: Conflict resolution + file history browsing

-- Git status / changed files view (for conflict resolution)
vim.keymap.set("n", "<leader>vd", "<Cmd>DiffviewOpen<CR>", { desc = "Diff: git status / conflicts" })

