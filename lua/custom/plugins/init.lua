return {
	'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
	-- "gc" to comment visual regions/lines
	{ 'numToStr/Comment.nvim', opts = {}, lazy = true },
	{
		'lewis6991/gitsigns.nvim',
		opts = {
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
			},
		},
	},
	{
		-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`
		'folke/tokyonight.nvim',
		lazy = false,  -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		opts = {
			transparent = vim.g.transparent_enabled
		},
		config = function()
			vim.cmd.colorscheme 'tokyonight-storm'
			-- You can configure highlights by doing something like
			vim.cmd.hi 'Comment gui=none'
		end,
	},
	{
		'wakatime/vim-wakatime',
		lazy = false,
		cmd = { 'WakaTimeToday', 'WakaTimeApiKey' },
	},
	require 'kickstart.plugins.debug',
	require 'kickstart.plugins.indent_line',

	require 'custom.plugins.autocompletion',
	require 'custom.plugins.automaton',
	require 'custom.plugins.blackjack-game',
	require 'custom.plugins.cloak-config',
	require 'custom.plugins.codeium-config',
	require 'custom.plugins.codesnaps-config',
	require 'custom.plugins.color-picker-config',
	require 'custom.plugins.conform-config',
	require 'custom.plugins.dabbod-ui-config',
	require 'custom.plugins.present-nvim-config',
	require 'custom.plugins.fugitive',
	require 'custom.plugins.harpoon-config',
	require 'custom.plugins.image-config',
	require 'custom.plugins.lazygit-config',
	require 'custom.plugins.lsp',
	require 'custom.plugins.markdown-live',
	require 'custom.plugins.markdown',
	require 'custom.plugins.mini-config',
	-- require 'custom.plugins.needs-key',
	require 'custom.plugins.oil-config',
	-- require 'custom.plugins.pets-config',
	require 'custom.plugins.phoemux-telescope',
	require 'custom.plugins.telescope-config',
	require 'custom.plugins.todo-config',
	require 'custom.plugins.transparent-config',
	require 'custom.plugins.treesitter-config',
	require 'custom.plugins.trouble-config',
	require 'custom.plugins.undootree-config',
	require 'custom.plugins.vim-good',
	require 'custom.plugins.vim-with-me-config',
	-- require 'custom.plugins.which-key-config',
}
