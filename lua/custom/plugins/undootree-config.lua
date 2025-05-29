---@type LazyPluginSpec
return {
	'mbbill/undotree',
	lazy = true,
	keys = {
		{ '<leader>i', vim.cmd.UndotreeToggle, desc = 'Open UndoTree' },
	},
}
