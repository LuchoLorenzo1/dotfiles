-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
-- vim.opt.termguicolors = true

require("nvim-tree").setup({
	-- sort_by = "case_sensitive",
	hijack_netrw = true,
	disable_netrw = false,
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = false,
	},
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
})

local function open_nvim_tree(data)
	-- local no_name = data.file == "" and vim.bo[data.buf].buftype == ""
	local directory = vim.fn.isdirectory(data.file) == 1

	-- if not no_name and not directory then
	-- 	return
	-- end

	if not directory then
		return
	end

	if directory then
		vim.cmd.cd(data.file)
	end

	require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
