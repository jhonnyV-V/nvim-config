---@type LazyPluginSpec
return {
	'ThePrimeagen/vim-with-me',
	lazy = true,
	keys = {
		{
			'<leader>vwm',
			function()
				require('vim-with-me').StartVimWithMe()
			end,
			desc = '[V]im [W]ith [M]e',
		},
		{
			'<leader>svwm',
			function()
				require('vim-with-me').StopVimWithMe()
			end,
			desc = '[S]top [V]im [W]ith [M]e',
		},
	},
}
