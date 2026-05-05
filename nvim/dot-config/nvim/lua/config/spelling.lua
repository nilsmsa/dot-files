-- Enable spell checking for markdown and text files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { "en", "nb" }  -- English + Norwegian Bokmål
  end,
})
