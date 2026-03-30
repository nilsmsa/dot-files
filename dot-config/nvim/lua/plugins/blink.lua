vim.pack.add({
	{
		src = "https://github.com/saghen/blink.cmp",
		version = vim.version.range("^1"),
	},
	"https://github.com/giuxtaposition/blink-cmp-copilot",
})

local group = vim.api.nvim_create_augroup("BlinkCmpLazyLoad", { clear = true })

-- State for word-by-word ghost text acceptance.
-- Snapshots the remaining suggestion text on the first <M-w> press so that
-- subsequent presses consume a consistent sequence even if blink re-triggers
-- and Copilot returns a different completion in the meantime.
local _ww_state = nil -- { remaining: string, row: number, col: number }

vim.api.nvim_create_autocmd("InsertLeave", {
	group = group,
	callback = function()
		_ww_state = nil
	end,
})

vim.api.nvim_create_autocmd("InsertEnter", {
	pattern = "*",
	group = group,
	once = true,
	callback = function()
		require("blink.cmp").setup({
			keymap = {
				preset = "super-tab",
				-- Accept the next word of the ghost text suggestion
				["<M-w>"] = {
					function()
						local cursor = vim.api.nvim_win_get_cursor(0)
						local cursor_row, cursor_col = cursor[1], cursor[2]

						-- Invalidate cached state if cursor moved since the last accepted word
						-- (user typed something or moved manually).
						if _ww_state and (_ww_state.row ~= cursor_row or _ww_state.col ~= cursor_col) then
							_ww_state = nil
						end

						-- On first press (or after a reset) snapshot the full remaining
						-- suggestion so subsequent presses are not affected by blink
						-- re-triggering with a potentially different Copilot response.
						if not _ww_state then
							local gt = require("blink.cmp.completion.windows.ghost_text")
							local item = gt.selected_item
							if not item or not gt.context then
								return false
							end
							local text_edit = require("blink.cmp.lib.text_edits").get_from_item(item)
							-- Use the live cursor/line, not gt.context which is frozen at
							-- trigger time and would make typed_len always 0 (→ infinite loop).
							local line = vim.api.nvim_get_current_line()
							local typed_text = line:sub(text_edit.range.start.character + 1, cursor_col)
							local typed_len = math.max(
								0,
								math.min(vim.fn.strchars(typed_text), vim.fn.strchars(text_edit.newText))
							)
							local remaining = vim.fn.strcharpart(text_edit.newText, typed_len)
							if remaining == "" then
								return false
							end
							_ww_state = { remaining = remaining, row = cursor_row, col = cursor_col }
						end

						-- Tokenization rules (in priority order):
						-- 1. Word chars (identifiers/numbers): "foo", "bar2"
						-- 2. Non-word non-newline chars + optional following word chars:
						--    "(arg", ", baz", "-> " — cursor always lands after a word char
						--    or on a punctuation char, never on bare whitespace.
						-- 3. Newline + leading whitespace on the new line: "\n    "
						local word = _ww_state.remaining:match("^[%w_]+")
							or _ww_state.remaining:match("^[^%w_\n]+[%w_]*")
							or _ww_state.remaining:match("^\n[ \t]*")
							or _ww_state.remaining

						-- Advance the snapshot and predict where the cursor will land.
						local after = vim.fn.strcharpart(_ww_state.remaining, vim.fn.strchars(word))
						local nl = word:find("\n", 1, true)
						local new_row, new_col
						if not nl then
							new_row = cursor_row
							new_col = cursor_col + #word -- byte offset, same line
						else
							local segs = vim.split(word, "\n", { plain = true })
							new_row = cursor_row + #segs - 1
							new_col = #segs[#segs] -- byte offset of last segment
						end
						_ww_state = after ~= "" and { remaining = after, row = new_row, col = new_col }
							or nil

						if nl then
							-- Insert via the buffer API (scheduled to escape the textlock) so
							-- that autoindent/indentexpr cannot corrupt the indentation that is
							-- already encoded in the suggestion text.
							local word_lines = vim.split(word, "\n", { plain = true })
							vim.schedule(function()
								vim.api.nvim_buf_set_text(
									0,
									cursor_row - 1,
									cursor_col,
									cursor_row - 1,
									cursor_col,
									word_lines
								)
								vim.api.nvim_win_set_cursor(0, { new_row, new_col })
							end)
						else
							-- Feed as keystrokes: blink keeps ghost text visible and
							-- Tab/Enter full-accept continues to work after partial accepts.
							vim.api.nvim_feedkeys(
								vim.api.nvim_replace_termcodes(word, true, false, true),
								"i",
								false
							)
						end
						return true
					end,
				},
			},
			signature = {
				enabled = true,
				-- Optional: show automatically when entering a function
				trigger = {
					show_on_insert = false,
				},
				-- Optional: customize the window appearance
				window = { border = "rounded" },
			},
			appearance = {
				nerd_font_variant = "mono",
				use_nvim_cmp_as_default = true,
			},
			completion = {
				documentation = { auto_show = false },
				trigger = { show_on_insert = false },
				menu = { auto_show = false },
				ghost_text = {
					enabled = true,
					-- Show the top suggestion even without opening the menu
					show_without_selection = true,
					-- Hide ghost text when the menu is open to avoid double rendering
					show_with_menu = false,
				},
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer", "copilot" },
				providers = {
					copilot = {
						name = "copilot",
						module = "blink-cmp-copilot",
						score_offset = 100,
						async = true,
					},
				},
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		})
	end,
})
