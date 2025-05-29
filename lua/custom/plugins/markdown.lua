---@type LazyPluginSpec
return {
	'OXY2DEV/markview.nvim',
	cmd = { 'Markview' },
	dependencies = {
		-- You may not need this if you don't lazy load
		-- Or if the parsers are in your $RUNTIMEPATH
		'nvim-treesitter/nvim-treesitter',

		'nvim-tree/nvim-web-devicons',
	},
	ft = { 'markdown' },
	lazy = true,
	keys = {
		{ '<leader>m', '<CMD>Markview<CR>', desc = 'MarkView Toggle' },
	},
}
