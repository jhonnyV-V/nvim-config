---@type LazyPluginSpec
return {
	'ThePrimeagen/harpoon',
	keys = {
		{ '<leader>a', function() require('harpoon.mark').add_file() end,         desc = 'Add File to Harpoon' },
		{ '<C-e>',     function() require('harpoon.ui').toggle_quick_menu() end,  desc = 'Open Harpoon Menu' },
		{ '<C-j>',     function() require('harpoon.ui').nav_file(1) end,          desc = 'Harpoon file 1' },
		{ '<C-k>',     function() require('harpoon.ui').nav_file(2) end,          desc = 'Harpoon file 2' },
		{ '<C-h>',     function() require('harpoon.ui').nav_file(3) end,          desc = 'Harpoon file 3' },
		{ '<C-l>',     function() require('harpoon.ui').nav_file(4) end,          desc = 'Harpoon file 4' },
	},
}
