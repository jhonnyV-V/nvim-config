return {
	'tpope/vim-fugitive',
	lazy = true,
	keys = {
		{ '<leader>gs', vim.cmd.Git, desc = 'Git Fugitive' },
	}
}
