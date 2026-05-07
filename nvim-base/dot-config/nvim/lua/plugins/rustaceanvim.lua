-- lua/plugins/theme.lua
vim.pack.add({
  'https://github.com/mfussenegger/nvim-dap'
})
vim.pack.add({ { src = "https://github.com/mrcjkb/rustaceanvim", version = vim.version.range("^9") } })

-- Configuration is done via a global variable, NOT a setup function
vim.g.rustaceanvim = {
  server = {
    settings = {
      ["rust-analyzer"] = {
        completion = {
          -- Fill in parameter names as snippet tab stops instead of just adding ()
          callable = { snippets = "fill_arguments" },
        },
        diagnostics = {
          -- Faster diagnostics without waiting for cargo check
          experimental = { enable = true },
        },
      },
    },
    on_attach = function(client, bufnr)
      -- You can also put your general LSP mappings here if you want
      vim.keymap.set(
        "n",
        "<leader>ca",
        function() vim.cmd.RustLsp('codeAction') end,
        { silent = true, buffer = bufnr, desc = "RustLsp Code Action" }
      )

      vim.keymap.set(
        "n",
        "K",
        function() vim.cmd.RustLsp({ 'hover', 'actions' }) end,
        { silent = true, buffer = bufnr, desc = "RustLsp Hover" }
      )

      vim.keymap.set(
        "n",
        "<leader>tr",
        function() vim.cmd.RustLsp('testables') end,
        { silent = true, buffer = bufnr, desc = "Run Rust Tests" }
      )

      vim.keymap.set(
        "n",
        "<leader>tC",
        function() vim.cmd.RustLsp({ 'run', '--nocapture' }) end,
        { silent = true, buffer = bufnr, desc = "Run Test at Cursor (No Capture)" }
      )

      vim.keymap.set(
        "n",
        "<leader>tc", -- e.g., "Test Cursor"
        function() vim.cmd.RustLsp('run') end,
        { silent = true, buffer = bufnr, desc = "Run Test/Target at Cursor" }
      )

      vim.keymap.set(
        "n",
        "<leader>tf",
        function() require('neotest').run.run(vim.fn.expand('%')) end,
        { silent = true, buffer = bufnr, desc = "Run All Tests in File" }
      )
      vim.keymap.set('n', '<leader>td', function()
        require('neotest').run.run({ strategy = 'dap' })
      end, { desc = 'Debug Nearest Test' })
      vim.keymap.set('n', '<leader>tb', function() require('dap').toggle_breakpoint() end, { desc = 'Toggle Breakpoint' })
      vim.keymap.set('n', '<leader>cb', function() require('dap').clear_breakpoints() end,
        { desc = 'Clear All Breakpoints' })
      -- F5: Continue execution until the next breakpoint (or end of program)
      vim.keymap.set('n', '<F5>', function() require('dap').continue() end, { desc = 'DAP Continue' })

      -- F10: Step Over (go to the next line without entering functions)
      vim.keymap.set('n', '<F10>', function() require('dap').step_over() end, { desc = 'DAP Step Over' })

      -- F11: Step Into (enter the function call on the current line)
      vim.keymap.set('n', '<F11>', function() require('dap').step_into() end, { desc = 'DAP Step Into' })

      -- F12: Step Out (run the rest of the current function and pause when returning)
      vim.keymap.set('n', '<F12>', function() require('dap').step_out() end, { desc = 'DAP Step Out' })
      -- K: Show variable state in a floating window
      vim.keymap.set('n', '<Leader>tk', function()
        require('dap.ui.widgets').hover()
      end, { desc = 'DAP Hover Variable' })
    end,
  },
  tools = {
    test_executor = 'background',
    float_win_config = {
      border = "rounded",
    },
  },
}
-- 2. Add ALL plugins to the runtime path together
vim.pack.add({
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-neotest/nvim-nio" },
  { src = "https://github.com/nvim-neotest/neotest" },
})

-- 3. Run neotest setup LAST
-- (Now it can safely find the rustaceanvim adapter)
require("neotest").setup({
  adapters = {
    require("rustaceanvim.neotest")
  },
})
