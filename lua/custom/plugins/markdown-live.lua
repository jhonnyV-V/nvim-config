return {
	'MeanderingProgrammer/markdown.nvim',
	name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
	lazy = true,
	dependencies = { 'nvim-treesitter/nvim-treesitter' },
	cmd = { 'RenderMarkdownToggle' },
	opts = {},
}
