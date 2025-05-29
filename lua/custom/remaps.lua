vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Save File' })
vim.keymap.set('n', '<leader><leader>', ':so<CR>', { desc = 'Source lua file' })

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move Selected Down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move Selected Up' })

vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Stack next line on current' })

vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Jump half page down' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Jump half page up' })

vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result' })

vim.keymap.set('x', '<leader>p', [["_dP]], { desc = 'Paste without yanking' })

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Yank to the + register' })

vim.keymap.set('n', '<leader>Y', [["+Y]], { desc = 'Yank line to the + register' })

vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]], { desc = 'Delete to the void' })
vim.keymap.set('n', '<leader>D', [["_D]], { desc = 'Delete line to the void (_ register)' })

-- vim.keymap.set('n', '<leader>tm', '<cmd>silent !tmux neww tmux-sessionizer<CR>', { desc = 'Open Tmux-sessionizer' })

-- Quick fix navigation
vim.keymap.set('n', '<C-j>', '<cmd>cnext<CR>zz', { desc = 'Next QuickFix Item' })
vim.keymap.set('n', '<C-k>', '<cmd>cprev<CR>zz', { desc = 'Previous QuickFix Item' })
--not sure what it does yet
vim.keymap.set('n', '<leader>j', '<cmd>lnext<CR>zz')
vim.keymap.set('n', '<leader>k', '<cmd>lprev<CR>zz')

vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Replace word in file' })

vim.keymap.set('n', '<leader>ex', '<cmd>!chmod +x %<CR>', {
	silent = true,
	desc = 'Make current file an executable (chmod)',
})

-- Diagnostic keymaps
-- TODO: check for duplication
vim.keymap.set('n', ']d', function()
	vim.diagnostic.jump { count = -1, float = true }
end, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', '[d', function()
	vim.diagnostic.jump { count = 1, float = true }
end, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})
