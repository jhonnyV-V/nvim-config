local function getSavePath()
	if vim.fn.has 'wsl' then
		return '/mnt/c/Users/jhonny/Pictures/codesnapshots/'
	else
		return '~/Pictures/'
	end
end
return {
	'mistricky/codesnap.nvim',
	build = 'make build_generator',
	cmd = {
		'CodeSnap', --Take a snapshot of the currently selected code and copy the snapshot into the clipboard
		'CodeSnapSave', --Save the snapshot of the currently selected code and save it on the disk
		'CodeSnapHighlight', -- Take code snapshot with highlights code blocks and copy it into the clipboard
		'CodeSnapSaveHighlight', -- Take code snapshot with highlights code blocks and save it somewhere
		'CodeSnapASCII', --Take a snapshot of the currently selected code as ascii and copy the snapshot into the clipboard
	},
	lazy = true,
	opts = {
		mac_window_bar = false,
		title = 'CodeSnap.nvim',
		code_font_family = 'CaskaydiaCove Nerd Font',
		watermark_font_family = 'Pacifico',
		watermark = "", --(vim.fn.getcwd():gsub(os.getenv 'HOME', '~')), -- (Optional) you can custom your own watermark, but if you don't like it, just set it to ""
		bg_theme = 'default', -- (optional) bamboo, sea, peach, grape, dusk, summer, default, or #RRGGBB
		breadcrumbs_separator = '/',
		has_breadcrumbs = false,
		has_line_number = true,
		-- The save_path must be ends with .png, unless when you specified a directory path,
		-- CodeSnap will append an auto-generated filename to the specified directory path
		-- For example:
		-- save_path = "~/Pictures"
		-- parsed: "~/Pictures/CodeSnap_y-m-d_at_h:m:s.png"
		-- save_path = "~/Pictures/foo.png"
		-- parsed: "~/Pictures/foo.png
		save_path = getSavePath(),
	},
}
