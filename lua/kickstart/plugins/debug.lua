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
	local root = vim.env.MASON or (vim.fn.stdpath 'data' .. '/mason')
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

		-- 'leoluz/nvim-dap-go',
	},
	lazy = true,
	keys = {
		-- Basic debugging keymaps, feel free to change to your liking!
		{
			'<F5>',
			function()
				require('dap').continue()
			end,
			desc = 'Debug: Start/Continue',
		},
		{
			'<F1>',
			function()
				require('dap').step_into()
			end,
			desc = 'Debug: Step Into',
		},
		{
			'<F2>',
			function()
				require('dap').step_over()
			end,
			desc = 'Debug: Step Over',
		},
		{
			'<F3>',
			function()
				require('dap').step_out()
			end,
			desc = 'Debug: Step Out',
		},
		{
			'<leader>td',
			function()
				require('dap').terminate()
			end,
			desc = 'Debug: Terminate',
		},
		{
			'<leader>b',
			function()
				require('dap').toggle_breakpoint()
			end,
			desc = 'Debug: Toggle Breakpoint',
		},
		{
			'<leader>B',
			function()
				require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
			end,
			desc = 'Debug: Set Breakpoint',
		},
		{
			'<space>?',
			function()
				require('dapui').eval(nil, { enter = true })
			end,
			desc = 'Debug: Evaluate Var Under Cursor',
		},
		-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
		{
			'<F7>',
			function()
				require('dapui').toggle()
			end,
			{ desc = 'Debug: See last session result.' },
		},
	},
	config = function()
		local dap = require 'dap'
		local dapui = require 'dapui'
		local mason_nvim_dap = require 'mason-nvim-dap'

		mason_nvim_dap.setup {
			-- Makes a best effort to setup the various debuggers with
			-- reasonable debug configurations
			automatic_setup = true,
			automatic_installation = true,

			-- You can provide additional configuration to the handlers,
			-- see mason-nvim-dap README for more information
			handlers = {
				function(config)
					mason_nvim_dap.default_setup(config)
				end,
			},

			-- You'll need to check that you have the required things installed
			-- online, please don't ask me how to install them :)
			ensure_installed = {
				-- Update this to ensure that you have the debuggers for the langs you want
				'delve',
				'codelldb',
			},
		}

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

		dap.listeners.after.event_initialized['dapui_config'] = dapui.open
		dap.listeners.before.event_terminated['dapui_config'] = dapui.close
		dap.listeners.before.event_exited['dapui_config'] = dapui.close

		-- local dap_go = require 'dap-go'
		-- -- WARNING: set dlv in path or it will not work
		-- dap_go.setup {
		-- 	dap_configurations = {
		-- 		{
		-- 			type = 'go',
		-- 			name = 'Debug',
		-- 			request = 'launch',
		-- 			program = '${file}',
		-- 		},
		-- 	},
		-- }

		dap.configurations.go = {
			{
				type = 'delve',
				name = 'Debug',
				request = 'launch',
				program = '${file}',
			},
			{
				type = 'delve',
				name = 'Debug test', -- configuration for debugging test files
				request = 'launch',
				mode = 'test',
				program = '${file}',
			},
			-- works with go.mod packages and sub packages
			{
				type = 'delve',
				name = 'Debug test (go.mod)',
				request = 'launch',
				mode = 'test',
				program = './${relativeFileDirname}',
			},
		}

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

		dap.configurations.odin = {
			{
				type = 'codelldb',
				host = '127.0.0.1',
				port = 13500,
				name = 'Debug Odin',
				request = 'launch',
				project = '${workspaceFolder}',
				program = function()
					local path = vim.fn.input {
						prompt = 'Path to executable: ',
						default = vim.fn.getcwd() .. '/',
						completion = 'file',
					}
					return (path and path ~= '') and path or dap.ABORT
				end,
			},
		}

		dap.adapters.codelldb = {
			type = 'server',
			host = '127.0.0.1',
			port = '${port}',
			executable = {
				command = 'codelldb',
				args = {
					'--port',
					'${port}',
				},
			},
		}

		local js_langs = { 'javascript', 'typescript', 'typescriptreact', 'javascriptreact' }

		dap.adapters['pwa-node'] = {
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
					resolveSourceMapLocations = { '${workspaceFolder}/**', '!**/node_modules/**' },
					-- path to src in vite based projects (and most other projects as well)
					-- cwd = "${workspaceFolder}/src",
					-- we don't want to debug code inside node_modules, so skip it!
					skipFiles = { '${workspaceFolder}/node_modules/**/*.js' },
				},
				{
					type = 'pwa-node',
					-- type = 'node2',
					request = 'attach',
					name = 'Attach to Node app',
					--- address = '127.0.0.1',
					-- port = 9229,
					cwd = '${workspaceFolder}',
					restart = true,
					sourceMaps = true,
					resolveSourceMapLocations = { '${workspaceFolder}/**', '!**/node_modules/**' },
					processId = require('dap.utils').pick_process,
					-- path to src in vite based projects (and most other projects as well)
					-- cwd = "${workspaceFolder}/src",
					-- we don't want to debug code inside node_modules, so skip it!
					skipFiles = { '${workspaceFolder}/node_modules/**/*.js' },
				},
				{
					-- use nvim-dap-vscode-js's pwa-chrome debug adapter
					type = 'pwa-chrome',
					request = 'launch',
					-- name of the debug action
					name = 'Launch Chrome to debug client side code',
					-- default vite dev server url
					url = 'http://localhost:5173',
					-- for TypeScript/Svelte
					sourceMaps = true,
					webRoot = '${workspaceFolder}/src',
					protocol = 'inspector',
					port = 9222,
					-- skip files from vite's hmr
					skipFiles = { '**/node_modules/**/*', '**/@vite/*', '**/src/client/*', '**/src/*' },
				},
				-- only if language is javascript, offer this debug action
				lang == 'javascript'
						and {
							-- use nvim-dap-vscode-js's pwa-node debug adapter
							type = 'pwa-node',
							-- launch a new process to attach the debugger to
							request = 'launch',
							-- name of the debug action you have to select for this config
							name = 'Launch file in new node process',
							-- launch current file
							program = '${file}',
							cwd = '${workspaceFolder}',
						}
					or nil,
			}
		end
	end,
}
