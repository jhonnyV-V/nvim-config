return {
	'nvim-treesitter/nvim-treesitter-context',
	dependencies = { 'nvim-treesitter/nvim-treesitter' },
	cmd = { 'TSContextEnable', 'TSContextDisable', 'TSContextToggle' },
	config = function()
		local context = require 'treesitter-context'
		context.setup {
			enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
			max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
			min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
			line_numbers = true,
			multiline_threshold = 20, -- Maximum number of lines to show for a single context
			trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
			mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
			-- Separator between context and content. Should be a single character string, like '-'.
			-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
			separator = nil,
			zindex = 20, -- The Z-index of the context window
			on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
		}
		vim.keymap.set('n', ']c', function()
			context.go_to_context(vim.v.count1)
		end, {
			silent = true,
			desc = 'treesitter: Jump to Context',
		})
	end,
}
