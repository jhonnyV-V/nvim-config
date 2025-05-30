---@type LazyPluginSpec
return {
	'kdheepak/lazygit.nvim',
	cmd = {
		'LazyGit',
		'LazyGitConfig',
		'LazyGitCurrentFile',
		'LazyGitFilter',
		'LazyGitFilterCurrentFile',
	},
	lazy = true,
	-- optional for floating window border decoration
	dependencies = {
		'nvim-lua/plenary.nvim',
	},
	keys = {
		{ '<leader>lz', '<cmd>LazyGit<CR>', desc = 'Lazygit: Open Lazygit' },
	},
}
