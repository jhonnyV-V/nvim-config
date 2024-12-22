return {
	'jhonnyV-V/phoemux-telescope',
	dependencies = {
		'nvim-telescope/telescope.nvim',
	},
	lazy = false,
	keys = {
		{
			'<leader>ms',
			function()
				require('phoemux-telescope').phoemux()
			end,
			desc = 'Phoemux: open phoemux list'
		},
	},
}
