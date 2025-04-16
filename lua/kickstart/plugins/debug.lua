-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

--- Gets a path to a package in the Mason registry.
--- Prefer this to `get_package`, since the package might not always be
--- available yet and trigger errors.
---@param pkg string
---@param path? string
local function get_pkg_path(pkg, path)
	pcall(require, 'mason')
	local root = vim.env.MASON or (vim.fn.stdpath('data') .. '/mason')
	path = path or ''
	local ret = root .. '/packages/' .. pkg .. '/' .. path
	return ret
end

return {
	'mfussenegger/nvim-dap',
	dependencies = {
		-- Creates a beautiful debugger UI
		'rcarriga/nvim-dap-ui',
		'nvim-neotest/nvim-nio',
		'theHamsta/nvim-dap-virtual-text',

		-- Installs the debug adapters for you
		'williamboman/mason.nvim',
		'jay-babu/mason-nvim-dap.nvim',

		'leoluz/nvim-dap-go',

		{
			'microsoft/vscode-js-debug',
			version = "1.x",
			build = "npm i && npm run compile vsDebugServerBundle && mv dist out"
		},
	},
	config = function()
		local dap = require 'dap'
		local dapui = require 'dapui'

		require('mason-nvim-dap').setup {
			-- Makes a best effort to setup the various debuggers with
			-- reasonable debug configurations
			automatic_setup = true,

			-- You can provide additional configuration to the handlers,
			-- see mason-nvim-dap README for more information
			handlers = {},

			-- You'll need to check that you have the required things installed
			-- online, please don't ask me how to install them :)
			ensure_installed = {
				-- Update this to ensure that you have the debuggers for the langs you want
				'delve',
			},
		}

		-- Basic debugging keymaps, feel free to change to your liking!
		vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
		vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
		vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
		vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
		vim.keymap.set('n', '<leader>td', dap.terminate, { desc = 'Debug: Terminate' })
		vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
		vim.keymap.set('n', '<leader>B', function()
			dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
		end, { desc = 'Debug: Set Breakpoint' })
		vim.keymap.set('n', '<space>?', function()
			dapui.eval(nil, { enter = true })
		end, { desc = 'Debug: Evaluate Var Under Cursor' })

		-- Dap UI setup
		-- For more information, see |:help nvim-dap-ui|
		dapui.setup {
			-- Set icons to characters that are more likely to work in every terminal.
			icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
			controls = {
				icons = {
					pause = '⏸',
					play = '▶',
					step_into = '⏎',
					step_over = '⏭',
					step_out = '⏮',
					step_back = 'b',
					run_last = '▶▶',
					terminate = '⏹',
					disconnect = '⏏',
				},
			},
		}

		require('nvim-dap-virtual-text').setup {
			enable_commands = true,
			show_stop_reason = true,
		}

		-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
		vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

		dap.listeners.after.event_initialized['dapui_config'] = dapui.open
		dap.listeners.before.event_terminated['dapui_config'] = dapui.close
		dap.listeners.before.event_exited['dapui_config'] = dapui.close

		local dap_go = require 'dap-go'
		-- WARNING: set dlv in path or it will not work
		dap_go.setup({
			dap_configurations = {
				{
					type = "go",
					name = "Debug",
					request = "launch",
					program = "${file}",
				},
			},
		})

		-- WARNING: this is not working for some reason

		-- dap.adapters.godot = {
		-- }
		dap.configurations.gdscript = {
			{
				type = 'server',
				host = '127.0.0.1',
				port = 6005,
				-- type = 'godot',
				name = 'Launch Main Scene',
				request = 'launch',
				project = '${workspaceFolder}',
			},
		}

		local js_langs = { 'javascript', 'typescript', 'typescriptreact', 'javascriptreact' }

		require('dap').adapters['pwa-node'] = {
			type = 'server',
			host = 'localhost',
			port = '${port}',
			executable = {
				command = 'node',
				args = {
					get_pkg_path('js-debug-adapter', '/js-debug/src/dapDebugServer.js'),
					'${port}',
				},
			},
		}

		for _, lang in ipairs(js_langs) do
			dap.configurations[lang] = {
				{
					type = 'pwa-node',
					-- type = 'node2',
					request = 'launch',
					program = '${file}',
					name = 'Launch to Node app',
					cwd = '${workspaceFolder}',
					restart = true,
					sourceMaps = true,
					port = 9222,
					resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
					-- path to src in vite based projects (and most other projects as well)
					-- cwd = "${workspaceFolder}/src",
					-- we don't want to debug code inside node_modules, so skip it!
					skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
				},
				{
					type = 'pwa-node',
					-- type = 'node2',
					request = 'attach',
					name = 'Attach to Node app',
					address = '127.0.0.1',
					port = 9229,
					cwd = '${workspaceFolder}',
					restart = true,
					sourceMaps = true,
					resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
					-- processId = require 'dap.utils'.pick_process,
					-- path to src in vite based projects (and most other projects as well)
					-- cwd = "${workspaceFolder}/src",
					-- we don't want to debug code inside node_modules, so skip it!
					skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },

				},
				{
					-- use nvim-dap-vscode-js's pwa-chrome debug adapter
					type = "pwa-chrome",
					request = "launch",
					-- name of the debug action
					name = "Launch Chrome to debug client side code",
					-- default vite dev server url
					url = "http://localhost:5173",
					-- for TypeScript/Svelte
					sourceMaps = true,
					webRoot = "${workspaceFolder}/src",
					protocol = "inspector",
					port = 9222,
					-- skip files from vite's hmr
					skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
				},
				-- only if language is javascript, offer this debug action
				lang == "javascript" and {
					-- use nvim-dap-vscode-js's pwa-node debug adapter
					type = "pwa-node",
					-- launch a new process to attach the debugger to
					request = "launch",
					-- name of the debug action you have to select for this config
					name = "Launch file in new node process",
					-- launch current file
					program = "${file}",
					cwd = "${workspaceFolder}",
				} or nil,
			}
		end
	end,
}
