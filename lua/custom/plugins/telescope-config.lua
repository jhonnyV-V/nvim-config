return { -- Fuzzy Finder (files, lsp, etc)
	'nvim-telescope/telescope.nvim',
	event = 'VimEnter',
	branch = '0.1.x',
	lazy = true,
	dependencies = {
		'nvim-lua/plenary.nvim',
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			build = 'make',
			cond = function()
				return vim.fn.executable 'make' == 1
			end,
		},
		{ 'nvim-telescope/telescope-ui-select.nvim' },
		--  If you already have a Nerd Font, or terminal set up with fallback fonts
		--  you can enable this
		{ 'nvim-tree/nvim-web-devicons' },
	},

	-- The easiest way to use telescope, is to start by doing something like:
	--  :Telescope help_tags
	--
	-- Two important keymaps to use while in telescope are:
	--  - Insert mode: <c-/>
	--  - Normal mode: ?
	--
	-- This opens a window that shows you all of the keymaps for the current
	-- telescope picker. This is really useful to discover what Telescope can
	-- do as well as how to actually do it!

	-- [[ Configure Telescope ]]
	-- See `:help telescope` and `:help telescope.setup()`
	opts = {
		-- You can put your default mappings / updates / etc. in here
		--  All the info you're looking for is in `:help telescope.setup()`
		--
		-- defaults = {
		--   mappings = {
		--     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
		--   },
		-- },
		-- pickers = {}
		extensions = {
			['ui-select'] = {
				function()
					require('telescope.themes').get_dropdown()
				end,
			},
		},
	},
	config = function()
		-- Enable telescope extensions, if they are installed
		pcall(require('telescope').load_extension, 'fzf')
		pcall(require('telescope').load_extension, 'ui-select')
	end,
	keys = {
		{
			'<leader>ps',
			function()
				require('telescope.builtin').grep_string {
					search = vim.fn.input 'Grep > '
				}
			end,
			desc = 'Grep Word'
		},
		{ '<leader>gf', function() require('telescope.builtin').git_files() end,   desc = 'Telescope: Search [G]it [F]iles' },
		{ '<leader>pf', function() require('telescope.builtin').find_files() end,  desc = 'Telescope: [S]earch [F]iles' },
		{ '<leader>sb', function() require('telescope.builtin').buffers() end,     desc = 'Telescope: [S]earch [B]uffer' },
		{ '<leader>qf', function() require('telescope.builtin').quickfix() end,    desc = 'Telescope: [Q]uick [F]ix list' },
		{ '<leader>sh', function() require('telescope.builtin').help_tags() end,   desc = 'Telescope: [S]earch [H]elp' },
		{ '<leader>sk', function() require('telescope.builtin').keymaps() end,     desc = 'Telescope: [S]earch [K]eymaps' },
		{ '<leader>ss', function() require('telescope.builtin').builtin() end,     desc = 'Telescope: [S]earch [S]elect Telescope' },
		{ '<leader>sw', function() require('telescope.builtin').grep_string() end, desc = 'Telescope: [S]earch current [W]ord' },
		{ '<leader>sg', function() require('telescope.builtin').live_grep() end,   desc = 'Telescope: [S]earch by [G]rep' },
		{ '<leader>sd', function() require('telescope.builtin').diagnostics() end, desc = 'Telescope: [S]earch [D]iagnostics' },
		{ '<leader>sr', function() require('telescope.builtin').resume() end,      desc = 'Telescope: [S]earch [R]esume' },
		{ '<leader>s.', function() require('telescope.builtin').oldfiles() end,    desc = 'Telescope: [S]earch Recent Files ("." for repeat)' },
		-- Slightly advanced example of overriding default behavior and theme
		{
			'<leader>/',
			function()
				-- You can pass additional configuration to telescope to change theme, layout, etc.
				require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
					winblend = 10,
					previewer = false,
				})
			end,
			desc = 'Telescope: [/] Fuzzily search in current buffer'
		},
		{
			'<leader>s/',
			function()
				require('telescope.builtin').live_grep {
					grep_open_files = true,
					prompt_title = 'Live Grep in Open Files',
				}
			end,
			desc = 'Telescope: [S]earch [/] in Open Files'
		},
		-- Shortcut for searching your neovim configuration files
		{
			'<leader>sn',
			function()
				require('telescope.builtin').find_files {
					cwd = vim.fn.stdpath 'config'
				}
			end,
			desc = 'Telescope: [S]earch [N]eovim files'
		},
	}
}
