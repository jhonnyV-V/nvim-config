-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

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

		-- Add your own debuggers here
		'leoluz/nvim-dap-go',
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
		dap.adapters.godot = {
			type = 'server',
			host = '127.0.0.1',
			port = 6005,
		}
		dap.configurations.gdscript = {
			{
				type = 'godot',
				name = 'Launch Main Scene',
				request = 'launch',
				project = '${workspaceFolder}',
			},
		}
	end,
}
