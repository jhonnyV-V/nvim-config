return {
	-- "ggml-org/llama.vim",
	"jhonnyV-V/llama.vim",
	branch = "chore_configurable_keymaps",
	init = function()
		vim.g.llama_config = {
			accept_full_keymap = "<C-g>",
			accept_line_keymap = "<C-S-g>",
		}
	end,
	config = function()
		vim.api.nvim_set_hl(0, "llama_hl_hint", { fg = "#f8732e", ctermfg = 209 })
		vim.api.nvim_set_hl(0, "llama_hl_info", { fg = "#50fa7b", ctermfg = 119 })
	end,
	cmd = {
		"LlamaDisable",
		"LlamaEnable",
		"LlamaToggle"
	},
}
