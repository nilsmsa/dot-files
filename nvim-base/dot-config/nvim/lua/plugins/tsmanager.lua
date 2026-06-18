vim.pack.add({ "https://github.com/romus204/tree-sitter-manager.nvim" })

require("tree-sitter-manager").setup({
  languages = {
    avdl = {
      install_info = {
        url = "https://github.com/victorhqc/tree-sitter-apache-avro",
        --files = { "src/parser.c" },
        --queries = "queries/subdir", -- override the default "queries" source directory
        use_repo_queries = true, -- copy queries/ from the cloned repo
      },
    },
  },
  ensure_installed = {
    "avdl",
    "kotlin",
    "java",
    "yaml",
    "dockerfile",
    "toml",
  },
  highlight = true,
})

-- The parser's grammar name is "apache_avro", not "avdl", so we must register
-- the mapping explicitly so nvim finds the correct symbol in avdl.so.
vim.treesitter.language.add("avdl", {
  path = vim.fn.stdpath("data") .. "/site/parser/avdl.so",
  symbol_name = "apache_avro",
})

vim.filetype.add({
  extension = {
    avdl = "avdl",
  },
})
