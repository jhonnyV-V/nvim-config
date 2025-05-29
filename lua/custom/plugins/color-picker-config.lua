---@type LazyPluginSpec
return {
	'ziontee113/color-picker.nvim',
	lazy = true,
	opts = { -- for changing icons & mappings
		-- ["icons"] = { "ﱢ", "" },
		-- ["icons"] = { "ﮊ", "" },
		-- ["icons"] = { "", "ﰕ" },
		-- ["icons"] = { "", "" },
		-- ["icons"] = { "", "" },
		['icons'] = { 'ﱢ', '' },
		['border'] = 'rounded', -- none | single | double | rounded | solid | shadow
		['keymap'] = { -- mapping example:
			['U'] = '<Plug>ColorPickerSlider5Decrease',
			['O'] = '<Plug>ColorPickerSlider5Increase',
		},
		['background_highlight_group'] = 'Normal', -- default
		['border_highlight_group'] = 'FloatBorder', -- default
		['text_highlight_group'] = 'Normal', --default
	},
	cmd = {
		'PickColor',
	},
	config = function()
		-- vim.keymap.set("i", "<C-c>", "<cmd>PickColorInsert<cr>", opts)

		-- vim.keymap.set("n", "your_keymap", "<cmd>ConvertHEXandRGB<cr>", opts)
		-- vim.keymap.set("n", "your_keymap", "<cmd>ConvertHEXandHSL<cr>", opts)
		vim.cmd [[hi FloatBorder guibg=NONE]] -- if you don't want weird border background colors around the popup.
	end,
	keys = {
		{ '<leader>pc', '<cmd>PickColor<cr>', noremap = true, silent = true, desc = 'Color Picker: Open ColorPicker' },
	},
}
