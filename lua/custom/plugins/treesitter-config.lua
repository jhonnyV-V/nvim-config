return { -- Highlight, edit, and navigate code
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',
	dependencies = {
		{
			'nvim-treesitter/nvim-treesitter-context',
			opts = {
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				max_lines = 3, -- How many lines the window should span. Values <= 0 mean no limit.
				min_window_height = 1, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
				line_numbers = true,
				multiline_threshold = 1, -- Maximum number of lines to show for a single context
				trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
				mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
				-- Separator between context and content. Should be a single character string, like '-'.
				-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
				separator = nil,
				zindex = 20, -- The Z-index of the context window
				on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
			},
			cmd = { 'TSContextEnable', 'TSContextDisable', 'TSContextToggle' },
			keys = {
				{
					']c',
					function()
						-- require('treesitter-context').go_to_context(vim.v.count1)
						-- require('treesitter-context').go_to_context()
						vim.schedule(function()
							require('treesitter-context').go_to_context()
						end)
						return '<Ignore>'
					end,
					desc = 'Jump to upper context',
					expr = true,
				},
			},
			config = function()
				vim.cmd.hi 'TreesitterContextLineNumber guifg=Orange'
				vim.cmd.hi 'TreesitterContextBottom gui=underline guisp=Grey'
			end,
		},
	},
	config = function()
		-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
		---@diagnostic disable-next-line: missing-fields
		require('nvim-treesitter.configs').setup {
			ensure_installed = {
				'bash',
				'c',
				'html',
				'lua',
				'markdown',
				'markdown_inline',
				'vim',
				'vimdoc',
				'javascript',
				'go',
				'typescript',
				'python',
				'c',
				'cpp',
				'tsx',
				'lua',
				'vim',
				'vimdoc',
				'query',
				'templ',
			},
			-- Autoinstall languages that are not installed
			auto_install = true,
			highlight = {
				enable = true,
				-- additional_vim_regex_highlighting = false,
			},
			indent = { enable = true },
		}

		-- There are additional nvim-treesitter modules that you can use to interact
		-- with nvim-treesitter. You should go explore a few and see what interests you:
		--
		--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
		--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
		--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects

		vim.filetype.add { extension = { templ = 'templ' } }
	end,
}
