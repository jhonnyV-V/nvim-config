return {
	'Exafunction/codeium.vim',
	event = 'BufEnter',
	-- cmd = { 'codeium#Chat', 'codeium#GetStatusString', 'Codeium Auth' },
	config = function()
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
