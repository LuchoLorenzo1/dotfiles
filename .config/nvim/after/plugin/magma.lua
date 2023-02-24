local magma = vim.api.nvim_create_augroup("magma", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = magma,
	pattern = {"python", "vimwiki", "markdown", ""},
	callback = function(a)
		vim.api.nvim_set_keymap('n', '<F5>', ':lua require("user.autosave")[1]("'.. a.file .. '")<CR>', {noremap=true})

		vim.api.nvim_set_keymap('x', 'gm', ':<C-u>MagmaEvaluateVisual<CR>', {noremap=true, silent=true})
		vim.api.nvim_set_keymap('n', 'gm', ':MagmaEvaluateLine<CR>', {noremap=true, silent=true})
		vim.api.nvim_set_keymap('n', 'go', ':MagmaShowOutput<CR>', {noremap=true, silent=true})
		vim.api.nvim_set_keymap('n', 'gb', ':MagmaDelete<CR>:Clear<CR>', {noremap=true, silent=true})
		vim.api.nvim_set_keymap('n', 'gM', ':MagmaReevaluateCell<CR>', {noremap=true, silent=true})

		-- vim.cmd([[autocmd CursorHold * :MagmaShowOutput]])
		vim.g.magma_automatically_open_output = false
		vim.g.magma_image_provider = "ueberzug"
	end,
})
