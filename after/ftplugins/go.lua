local dap_go = require 'dap-go'
vim.keymap.set('n', '<leader>dt', dap_go.debug_test, { desc = 'Debug Go: Debug Test' })
