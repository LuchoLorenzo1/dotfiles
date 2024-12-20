-- nvim_get_current_buf()
-- :source %

local attach_to_buffer = function(output_bufnr, pattern, command)
	vim.api.nvim_create_autocmd("BufWritePost", {
		group = vim.api.nvim_create_augroup("run", { clear = true }),
		pattern = pattern,
		callback = function()
			vim.api.nvim_buf_set_lines(output_bufnr, 0, -1, false, { 'output: ' })
			local append_data = function(_, data)
				if data then
					vim.api.nvim_buf_set_lines(output_bufnr, -1, -1, false, data)
				end
			end
			vim.fn.jobstart(command, {
				stdout_buffered = true,
				on_stdout = append_data,
				on_stderr = append_data,
			})
		end,
	})
end

vim.api.nvim_create_user_command("AutoRun", function()
	vim.cmd('vsplit')
	local win = vim.api.nvim_get_current_win()
	local bufnr = vim.api.nvim_create_buf(true, true)
	vim.api.nvim_win_set_buf(win, bufnr)
	-- local pattern = vim.fn.input("Pattern: ")
	local command = vim.split(vim.fn.input("Command: "), " ")
	attach_to_buffer(bufnr, '', command)
end, {})

vim.api.nvim_set_keymap('n', "<leader>x", ":AutoRun<CR>", {})

local menem = vim.api.nvim_create_namespace('menem')

local testing = function()
	local bufnr = 0
	-- vim.api.nvim_buf_set_extmark(bufnr, menem, 64, 0, {
	-- virt_text = { { 'Test Passed' } },
	-- })
	local l = function()
		return 0
	end

	vim.fn.jobstart({ 'pytest', 'main.py', '--json-report' }, {
		stdout_buffered = true,
		on_stdout = l,
		on_stderr = l,
	})

	print(vim.json.decode("{}"))

	vim.api.nvim_buf_set_extmark(bufnr, menem, 73, 0, {
		virt_text = { { 'Test Failed' } },
	})
	vim.diagnostic.set(menem, bufnr, { {
		bufnr = 0,
		lnum = 64,
		col = 0,
		severity = vim.diagnostic.severity.ERROR,
		message = "Test Failed",
		source = "menem",
		user_data = {},
	} })
end
