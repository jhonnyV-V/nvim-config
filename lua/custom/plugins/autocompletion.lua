return {
	'saghen/blink.cmp',
	dependencies = {
		'rafamadriz/friendly-snippets',
		{
			'L3MON4D3/LuaSnip',
			version = 'v2.*',
			dependencies = 'rafamadriz/friendly-snippets',
			config = function()
				require('luasnip.loaders.from_vscode').lazy_load()
			end,
			build = 'make install_jsregexp',
		},
		{
			'folke/lazydev.nvim',
			ft = 'lua',
			opts = {
				library = {
					{ path = 'lazy.nvim', words = { 'Lazy' } },
					{ path = '${3rd}/luv/library', words = { 'vim%.uv' } },
				},
			},
		},
		'onsails/lspkind.nvim',
	},

	build = 'cargo build --release',
	version = '*',
	---@type blink.cmp.Config
	opts = {
		keymap = {
			preset = 'default',
			['<C-l>'] = { 'snippet_forward', 'fallback' },
			['<C-h>'] = { 'snippet_backward', 'fallback' },
			['<Tab>'] = {},
			['<S-Tab>'] = {},
		},

		appearance = {
			-- will be removed in a future release
			use_nvim_cmp_as_default = true,
			-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			nerd_font_variant = 'mono',
		},

		completion = {
			menu = {
				draw = {
					columns = {
						{
							'label',
							'label_description',
							gap = 1,
						},
						{
							gap = 1,
							'kind',
							'kind_icon',
							'source_name',
						},
					},
					components = {
						kind_icon = {
							ellipsis = false,
							text = function(ctx)
								local lspkind = require 'lspkind'
								local icon = ctx.kind_icon
								if vim.tbl_contains({ 'Path' }, ctx.source_name) then
									local dev_icon, _ = require('nvim-web-devicons').get_icon(ctx.label)
									if dev_icon then
										icon = dev_icon
									end
								else
									icon = lspkind.symbol_map[ctx.kind] or ''
								end

								return icon .. ctx.icon_gap
							end,

							-- Optionally, use the highlight groups from nvim-web-devicons
							-- You can also add the same function for `kind.highlight` if you want to
							-- keep the highlight groups in sync with the icons.
							highlight = function(ctx)
								local hl = 'BlinkCmpKind' .. ctx.kind or require('blink.cmp.completion.windows.render.tailwind').get_hl(ctx)
								if vim.tbl_contains({ 'Path' }, ctx.source_name) then
									local dev_icon, dev_hl = require('nvim-web-devicons').get_icon(ctx.label)
									if dev_icon then
										hl = dev_hl
									end
								end
								return hl
							end,
						},
					},
				},
			},
		},

		snippets = {
			-- expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
			-- active = function(filter)
			-- 	if filter and filter.direction then
			-- 		return require('luasnip').jumpable(filter.direction)
			-- 	end
			-- 	return require('luasnip').in_snippet()
			-- end,
			-- jump = function(direction) require('luasnip').jump(direction) end,
			preset = 'luasnip',
		},

		-- default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, via `opts_extend`
		sources = {
			default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
			-- optionally disable cmdline completions
			-- cmdline = {},
			providers = {
				lazydev = {
					name = 'LazyDev',
					module = 'lazydev.integrations.blink',
					score_offset = 100,
				},
				-- dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
			},
		},

		-- experimental signature help support
		signature = { enabled = true },
	},
	-- allows extending the providers array elsewhere in your config
	-- without having to redefine it
	opts_extend = { 'sources.default' },
}
