return {
	'iamcco/markdown-preview.nvim',
	cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
	ft = { 'markdown' },
	lazy = true,
	build = function()
		vim.fn['mkdp#util#install']()
	end,
	config = function()
		vim.keymap.set('n', '<leader>m', '<CMD>MarkdownPreview<CR>', { desc = 'MarkdownPreview Start' })
		vim.keymap.set('n', '<leader>mn', '<CMD>MarkdownPreviewStop<CR>', { desc = 'MarkdownPreview Stop' })
	end,
}
