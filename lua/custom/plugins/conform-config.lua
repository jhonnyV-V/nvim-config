---@type LazyPluginSpec
return { -- Autoformat
	'stevearc/conform.nvim',
	opts = {
		notify_on_error = true,
		default_format_opts = {
			lsp_format = 'fallback',
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
		formatters_by_ft = {
			lua = { 'stylua' },
			go = { 'goimports', 'gofmt' },
			-- python = { "isort", "black" },
			javascript = { 'prettierd', 'eslint_d' },
			html = { 'prettierd', 'prettier' },
			templ = { 'prettierd', 'prettier' },
		},
	},
	keys = {
		{
			'<leader>f',
			function()
				local conf = require 'conform'
				conf.format()
			end,
			desc = 'Lsp Format',
		},
	},
}
