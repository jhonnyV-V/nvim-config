return {
	'tpope/vim-fugitive',
	lazy = true,
	config = function()
		vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = 'Git Fugitive' })
	end,
}
