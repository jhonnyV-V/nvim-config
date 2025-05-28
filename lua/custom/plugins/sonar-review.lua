---@type LazyPluginSpec
return {
	"carlbeattie2000/nvim-sonar-review",
	dependencies = { 'nvim-telescope/telescope.nvim' },
	opts = {
		use_telescope = true,
	},
	keys = {
		{
			'<leader>as',
			function()
				local sonar_cmd = require("sonar-review.cmd")
				local sonar = require("sonar-review")
				print("sonar", vim.inspect(sonar))
				print("sonar_cmd", vim.inspect(sonar_cmd))
				sonar_cmd.scan(true)
			end,
			desc = 'Sonar Review: [A]udit [S]can'
		},
		{
			'<leader>ad',
			function()
				local sonar_ui = require("sonar-review.ui")
				print("sonar_ui", vim.inspect(sonar_ui))
				sonar_ui.show_file_reports()
			end,
			desc = 'Sonar Review: [A]udit [D]isplay'
		},
	}
}
