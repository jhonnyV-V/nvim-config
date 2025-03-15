---@type lazydev.Library.spec
return {
	'jhonnyV-V/phoemux-telescope',
	-- name = "phoemux-telescope",
	-- dev = true,
	-- dir = "~/Code/lua/phoemux-telescope",
	dependencies = {
		'nvim-telescope/telescope.nvim',
	},
	lazy = false,
	keys = {
		{
			'<leader>ms',
			function()
				---@type Phoemux
				local phoemux = require('phoemux-telescope')
				phoemux.phoemux()
			end,
			desc = 'Phoemux: open phoemux list'
		},
		---@type LazyKeysSpec
		{
			'<leader>pt',
			function()
				---@type Phoemux
				local phoemux = require('phoemux-telescope')
				phoemux.switch_tmux_session()
			end,
			desc = 'Phoemux: switch Tmux session'
		},
		{
			'<leader>mk',
			function()
				---@type Phoemux
				local phoemux = require('phoemux-telescope')
				phoemux.kill_and_switch_session()
			end,
			desc = 'Phoemux: switch Tmux session and kill current one'

		},
		{
			'<leader>pk',
			function()
				---@type Phoemux
				local phoemux = require('phoemux-telescope')
				phoemux.kill_session()
			end,
			desc = 'Phoemux: select a Tmux session to kill it'

		},
		{
			'<leader>mt',
			function()
				---@type Phoemux
				local phoemux = require('phoemux-telescope')
				phoemux.kill_current_session()
			end,
			desc = 'Phoemux: kill current tmux session'

		},
	},
}
