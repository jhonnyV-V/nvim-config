---@type LazyPluginSpec
return {
	'tpope/vim-fugitive',
	lazy = true,
	cmd = {
		'Git blame',
		'Git difftool',
		'Git mergetool',
		'Git diff',
	},
	keys = {
		{ '<leader>gs', vim.cmd.Git, desc = 'Git Fugitive' },
	},
}
