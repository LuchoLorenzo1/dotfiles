local refactoring_status, refactoring = pcall(require, "refactoring")
if not refactoring_status then
	return
end
--
-- refactoring.setup({
-- 	prompt_func_return_type = {
-- 		go = false,
-- 		java = false,
-- 		cpp = false,
-- 		c = false,
-- 		h = false,
-- 		hpp = false,
-- 		cxx = false,
-- 	},
-- 	prompt_func_param_type = {
-- 		go = false,
-- 		java = false,
-- 		cpp = false,
-- 		c = false,
-- 		h = false,
-- 		hpp = false,
-- 		cxx = false,
-- 	},
-- 	printf_statements = {},
-- 	print_var_statements = {
-- 		-- add a custom print var statement for cpp
-- 		-- cpp = {
-- 		-- 	'printf("a custom statement %%s %s", %s)'
-- 		-- }
-- 	}
-- })
--
-- local opts = { noremap = true, silent = true }
--
--
-- vim.api.nvim_set_keymap("v", "<leader>re", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
-- 	{ noremap = true, silent = true, expr = false })
-- vim.api.nvim_set_keymap("v", "<leader>rf",
-- 	[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
-- 	{ noremap = true, silent = true, expr = false })
-- vim.api.nvim_set_keymap("v", "<leader>rv", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
-- 	{ noremap = true, silent = true, expr = false })
-- vim.api.nvim_set_keymap("v", "<leader>ri", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
-- 	{ noremap = true, silent = true, expr = false })
--
-- -- Extract block doesn't need visual mode
-- vim.api.nvim_set_keymap("n", "<leader>rb", [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]], opts)
-- vim.api.nvim_set_keymap("n", "<leader>rbf", [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]],
-- 	{ noremap = true, silent = true, expr = false })
--
-- -- Inline variable can also pick up the identifier currently under the cursor without visual mode
-- vim.api.nvim_set_keymap("n", "<leader>ri", [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], { noremap = true, silent = true, expr = false })
--
-- -- You can also use below = true here to to change the position of the printf
-- -- statement (or set two remaps for either one). This remap must be made in normal mode.
-- vim.api.nvim_set_keymap("n", "<leader>df", ":lua require('refactoring').debug.printf({below = false})<CR>", opts)
--
-- -- Print var
-- -- Remap in normal mode and passing { normal = true } will automatically find the variable under the cursor and print it
-- vim.api.nvim_set_keymap("n", "<leader>dv", ":lua require('refactoring').debug.print_var({ normal = true })<CR>", opts)
--
-- -- Remap in visual mode will print whatever is in the visual selection
-- vim.api.nvim_set_keymap("v", "<leader>dv", ":lua require('refactoring').debug.print_var({})<CR>", opts)
--
-- -- Cleanup function: this remap should be made in normal mode
-- vim.api.nvim_set_keymap("n", "<leader>dc", ":lua require('refactoring').debug.cleanup({})<CR>", opts)
