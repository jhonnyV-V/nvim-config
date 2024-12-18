return { -- Highlight todo, notes, etc in comments
	'folke/todo-comments.nvim',
	event = 'VimEnter',
	dependencies = { 'nvim-lua/plenary.nvim' },
	opts = { signs = false },
	lazy = true,
	keys = {
		{
			'[t',
			function()
				require('todo-comments').jump_next()
			end,
			desc = 'Next todo comment',
		},
		{
			']t',
			function()
				require('todo-comments').jump_prev()
			end,
			desc = 'Previous todo comment',
		},
		{
			'<leader>st',
			"<cmd>TodoTelescope<CR>",
			desc = 'Telescope: TODO comments',
		},
	},
}
