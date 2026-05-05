vim.pack.add({ "https://github.com/christoomey/vim-tmux-navigator" })

-- Let the plugin manage all C-hjkl mappings (normal + terminal modes).
-- Tmux side must have matching smart bindings (see dot-tmux.conf).
vim.g.tmux_navigator_no_wrap = 1
