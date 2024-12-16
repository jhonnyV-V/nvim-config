return {
	-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`
	'alanfortlink/blackjack.nvim',
	dependencies = { 'nvim-lua/plenary.nvim' },
	lazy = true,
	opts = {
		-- :BlackJackNewGame
		-- :BlackJackQuit
		-- :BlackJackResetScores
		card_style = 'large', -- Can be "mini" or "large".
		suit_style = 'black', -- Can be "black" or "white".
		keybindings = {
			['next'] = 'j',
			['finish'] = 'k',
			['quit'] = 'q',
		},
	},
	config = function()
	end,
	keys = {
		{'<leader>bj', '<CMD>BlackJackNewGame<CR>', desc = 'BlackJackNewGame'},
	}
}
