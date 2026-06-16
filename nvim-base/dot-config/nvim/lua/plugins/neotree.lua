vim.pack.add({
  {
    src = 'https://github.com/nvim-neo-tree/neo-tree.nvim',
    version = vim.version.range('3')
  },
  -- dependencies
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  -- optional, but recommended
  "https://github.com/nvim-tree/nvim-web-devicons",
})

-- 3. Configure Neo-tree
require("neo-tree").setup({
  -- Add this line:
  popup_border_style = "rounded", -- Options: "rounded", "single", "solid"
  window = {
    position = "right",           -- Places the explorer on the right
    width = 40,                   -- Adjust to your preferred width
  },
  filesystem = {
    -- Replaces Neovim's native netrw explorer with Neo-tree
    hijack_netrw_behavior = "open_default",
    group_empty_dirs = true, -- Compact empty directories into one node
    scan_mode = "deep",
  }
})

-- 4. Map the toggle key
vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", {
  noremap = true,
  silent = true,
  desc = "Toggle Neo-tree"
})
