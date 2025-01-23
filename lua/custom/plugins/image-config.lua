return {
	"3rd/image.nvim",
	config = {
		backend = "ueberzug",
		processor = "magick_cli",              -- "magick_rock",
		editor_only_render_when_focused = true, -- auto show/hide images when the editor gains/looses focus
		tmux_show_only_in_active_window = true, -- auto show/hide images in the correct Tmux window
	}
}
