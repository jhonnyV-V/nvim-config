return {
  'saghen/blink.cmp',
  dependencies = {
		'rafamadriz/friendly-snippets',
		{
			'L3MON4D3/LuaSnip',
			build = (function()
				-- Build Step is needed for regex support in snippets
				-- This step is not supported in many windows environments
				-- Remove the below condition to re-enable on windows
				if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
					return
				end
				return 'make install_jsregexp'
			end)(),
			dependencies = 'rafamadriz/friendly-snippets',
		},
	},
  version = 'v0.*',
  opts = {
    keymap = { preset = 'default' },

    appearance = {
      -- will be removed in a future release
      use_nvim_cmp_as_default = true,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      nerd_font_variant = 'mono'
    },

		snippets = {
			expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
      active = function(filter)
        if filter and filter.direction then
          return require('luasnip').jumpable(filter.direction)
        end
        return require('luasnip').in_snippet()
      end,
      jump = function(direction) require('luasnip').jump(direction) end,
		},

    -- default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, via `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'luasnip', 'snippets', 'buffer' },
      -- optionally disable cmdline completions
      -- cmdline = {},
    },

    -- experimental signature help support
    signature = { enabled = true }
  },
  -- allows extending the providers array elsewhere in your config
  -- without having to redefine it
  opts_extend = { "sources.default" }
}
