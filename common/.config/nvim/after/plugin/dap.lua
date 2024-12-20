local status_ok_dap, dap = pcall(require, "dap")
if not status_ok_dap then
	return
end

local status_ok_dapui, dapui = pcall(require, "dapui")
if not status_ok_dapui then
	return
end

require("dapui").setup()
local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap("n", "<leader>ds", "<cmd>lua require('dapui').open()<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>dq", "<cmd>lua require('dapui').close()<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>dt", "<cmd>lua require('dapui').toggle()<cr>", opts)

vim.api.nvim_set_keymap("n", "<leader>dc", "<cmd>lua require('dap').continue()<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>dj", "<cmd>lua require('dap').step_over()<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>dl", "<cmd>lua require('dap').step_into()<cr>", opts)

-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
--- LLDB, RUST y C ---
-- paquete en arch: codelldb
dap.adapters.lldb = {
	type = 'executable',
	command = '/usr/bin/lldb-vscode',
	-- command = vim.fn.getenv('HOME') .. '/.local/share/nvim/mason/packages/codelldb/codelldb',
	name = 'lldb'
}

dap.configurations.rust = {
	{
		name = 'Launch',
		type = 'lldb',
		request = 'launch',
		program = function()
			vim.cmd("!cargo build")
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = false,
		args = {},
	},
}

dap.configurations.c = {
	{
		name = 'Launch',
		type = 'lldb',
		request = 'launch',
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = false,
		args = {},
	},
}

dap.configurations.cpp = dap.configurations.c


--- PYTHON ---

-- mkdir .virtualenvs
-- cd .virtualenvs
-- python -m venv debugpy
-- debugpy/bin/python -m pip install debugpy

dap.adapters.python = {
	type = 'executable',
	command = vim.fn.getenv('HOME') .. '/.virtualenvs/debugpy/bin/python3',
	args = { '-m', 'debugpy.adapter' },
}

dap.configurations.python = {
	{
		-- The first three options are required by nvim-dap
		type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
		request = 'launch',
		name = "Launch file",
		-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
		program = "${file}", -- This configuration will launch the current file if used.
		pythonPath = function()
			-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
			-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
			-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
			local cwd = vim.fn.getcwd()
			if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
				return cwd .. '/venv/bin/python'
			elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
				return cwd .. '/.venv/bin/python'
			else
				return '/usr/bin/python'
			end
		end,
	},
}
