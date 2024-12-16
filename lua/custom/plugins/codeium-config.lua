return {
	'Exafunction/codeium.vim',
	event = 'BufEnter',
	-- cmd = { 'codeium#Chat', 'codeium#GetStatusString', 'Codeium Auth' },
	cmd = { 'Codeium Auth', 'CodeiumToggle' },
	-- this is for the nvim version requires = { 'nvim-lua/plenary.nvim', 'hrsh7th/nvim-cmp', },
	lazy = true,
	config = function()
		vim.g.codeium_disable_bindings = 1
		vim.g.codeium_enabled = false
	end,
	keys = {
		{ '<C-g>', function() return vim.fn['codeium#Accept']() end,             expr = true, silent = true, desc = 'Codeium: Accept suggestion', mode='i' },
		{ '<C-n>', function() return vim.fn['codeium#CycleCompletions'](1) end,  expr = true, silent = true, desc = 'Codeium: Next suggestion', mode='i' },
		{ '<C-p>', function() return vim.fn['codeium#CycleCompletions'](-1) end, expr = true, silent = true, desc = 'Codeium: Previus suggestion', mode='i' },
		{ '<C-x>', function() return vim.fn['codeium#Clear']() end,              expr = true, silent = true, desc = 'Codeium: Clear', mode='i' },
	},
}
