--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not sure exactly what you're looking for.

--]]

require 'custom.options'
require 'custom.remaps'

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
	vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins, you can run
--    :Lazy update
--
require('lazy').setup {
	'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
	-- "gc" to comment visual regions/lines
	{ 'numToStr/Comment.nvim', opts = {} },
	-- See `:help gitsigns` to understand what the configuration keys do
	{ -- Adds git related signs to the gutter, as well as utilities for managing changes
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
	{ -- Highlight todo, notes, etc in comments
		'folke/todo-comments.nvim',
		event = 'VimEnter',
		dependencies = { 'nvim-lua/plenary.nvim' },
		opts = { signs = false },
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
		},
	},
	{
		-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`
		'folke/tokyonight.nvim',
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
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
	require 'custom.plugins.codeium-config',
	require 'custom.plugins.color-picker-config',
	require 'custom.plugins.conform-config',
	require 'custom.plugins.fugitive',
	require 'custom.plugins.harpoon-config',
	require 'custom.plugins.lazygit-config',
	require 'custom.plugins.lsp',
	require 'custom.plugins.markdown',
	require 'custom.plugins.mini-config',
	-- require 'custom.plugins.needs-key',
	require 'custom.plugins.oil-config',
	require 'custom.plugins.pets-config',
	require 'custom.plugins.telescope-config',
	require 'custom.plugins.treesitter-config',
	require 'custom.plugins.trouble-config',
	require 'custom.plugins.undootree-config',
	require 'custom.plugins.vim-good',
	require 'custom.plugins.vim-with-me-config',
	require 'custom.plugins.which-key-config',
	-- require('custom.plugins.'),

	-- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
	--    This is the easiest way to modularize your config.
	--
	--  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
	--    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
	-- { import = 'custom.plugins' },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
