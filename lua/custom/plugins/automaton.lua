return {
	'eandrju/cellular-automaton.nvim',
	lazy = true,
	config = function()
		vim.keymap.set('n', '<leader>mr', '<cmd>CellularAutomaton make_it_rain<CR>', { desc = 'CellularAutomaton Make It Rain' })
		vim.keymap.set('n', '<leader>ml', '<cmd>CellularAutomaton game_of_life<CR>', { desc = 'CellularAutomaton Game Of Life' })
	end,
}
