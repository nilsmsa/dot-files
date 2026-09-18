vim.pack.add({ "https://github.com/nullromo/go-up.nvim" })

require("go-up").setup({
	respectScrolloff = true, -- keep our own scrolloff instead of go-up forcing it to 0
})
