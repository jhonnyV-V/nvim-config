return {
	'Exafunction/codeium.vim',
	event = 'BufEnter',
	-- cmd = { 'codeium#Chat', 'codeium#GetStatusString', 'Codeium Auth' },
	cmd = { 'Codeium Auth', 'CodeiumToggle' },
	-- this is for the nvim version requires = { 'nvim-lua/plenary.nvim', 'hrsh7th/nvim-cmp', },
	config = function()
		vim.g.codeium_disable_bindings = 1
		vim.g.codeium_enabled = false
		vim.keymap.set('i', '<C-g>', function()
			return vim.fn['codeium#Accept']()
		end, { expr = true, silent = true, desc = 'Codeium: Accept suggestion' })
		vim.keymap.set('i', '<C-n>', function()
			return vim.fn['codeium#CycleCompletions'](1)
		end, { expr = true, silent = true, desc = 'Codeium: Next suggestion' })
		vim.keymap.set('i', '<C-p>', function()
			return vim.fn['codeium#CycleCompletions'](-1)
		end, { expr = true, silent = true, desc = 'Codeium: Previus suggestion' })
		vim.keymap.set('i', '<C-x>', function()
			return vim.fn['codeium#Clear']()
		end, { expr = true, silent = true, desc = 'Codeium: Clear' })
	end,
}
