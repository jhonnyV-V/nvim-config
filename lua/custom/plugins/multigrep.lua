--make a tmux session switcher using this
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local make_entry = require('telescope.make_entry')
local conf = require('telescope.config').values

local M = {}

local multigrep = function(opts)
	opts = opts or {}
	opts.cwd = opts.cwd or vim.uv.cwd()


	local finder = finders.new_async_job({
		command_generator = function(propmt)
			if not propmt or propmt == "" then
				return nil
			end

			local piecies = vim.split(propmt, "  ")
			local args = { "rg" }
			if piecies[1] then
				table.insert(args, "-e")
				table.insert(args, piecies[1])
			end
			if piecies[2] then
				table.insert(args, "-g")
				table.insert(args, piecies[2])
			end

			---@diagnostic disable-next-line: deprecated
			return vim.tbl_flatten({
				args,
				{ "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" }
			})
		end,
		cwd = opts.cwd,
		entry_maker = make_entry.gen_from_vimgrep(opts),
	})

	pickers.new(opts, {
		finder = finder,
		prompt_title = "MultiGrep",
		debounce = 100,
		previewer = conf.grep_previewer(opts),
		sorter = require("telescope.sorters").empty(),
	}):find()
end

M.setup = function()
	--multigrep()
end

M.live_multigrep = multigrep

multigrep()

return M
