local has_dap, dap = pcall(require, "dap")
local has_dapui, dapui = pcall(require, "dapui")
if not has_dap or not has_dapui then
	return
end

local opts = { silent = true }

vim.keymap.set("n", "<F1>", require("dap").step_back, opts)
vim.keymap.set("n", "<F2>", require("dap").step_into, opts)
vim.keymap.set("n", "<F3>", require("dap").step_over, opts)
vim.keymap.set("n", "<F4>", require("dap").step_out, opts)
vim.keymap.set("n", "<F5>", require("dap").continue, opts)

require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')

vim.api.nvim_create_user_command("Debug", function()
	dapui.open()
end, {})

dapui.setup()
