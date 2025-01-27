return {
	'saghen/blink.cmp',
	dependencies = {
		'rafamadriz/friendly-snippets',
		{
			'L3MON4D3/LuaSnip',
			version = 'v2.*',
			dependencies = 'rafamadriz/friendly-snippets',
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
			build = "make install_jsregexp"
		},
		{
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					{ path = "lazy.nvim",          words = { "Lazy" } },
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		}
	},

	build = "cargo build --release",
	version = "*",
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
			nerd_font_variant = 'mono'
		},

		completion = {
			-- menu = {
			-- 	draw = {
			-- 		treesitter = { 'lsp' },
			-- 	},
			-- },
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
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 100,
				},
				-- dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
			},
		},

		-- experimental signature help support
		signature = { enabled = true }
	},
	-- allows extending the providers array elsewhere in your config
	-- without having to redefine it
	opts_extend = { "sources.default" },
}
