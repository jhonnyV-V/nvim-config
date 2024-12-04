return {
	'mbbill/undotree',
	lazy = true,
	config = function()
		vim.keymap.set('n', '<leader>i', vim.cmd.UndotreeToggle, { desc = 'Open UndoTree' })
	end,
}
