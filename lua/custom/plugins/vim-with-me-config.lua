return {
	'ThePrimeagen/vim-with-me',
	lazy = true,
	config = function()
		vim.keymap.set('n', '<leader>vwm', function()
			require('vim-with-me').StartVimWithMe()
		end, { desc = '[V]im [W]ith [M]e' })
		vim.keymap.set('n', '<leader>svwm', function()
			require('vim-with-me').StopVimWithMe()
		end, { desc = '[S]top [V]im [W]ith [M]e' })
	end,
}
