local nobg = { bg = "none", fg = "none" }

local function transparent(c)
	local hl_transparent = {
		"WinSeparator",
		"Normal",
		"NormalNC",
		"LineNr",
		"StatusLine",
		"Column",
		"ColorColumn",
		"SignColumn",
		"EndOfBuffer",
	}

	-- local hl_lsp = { "LspDiagnosticsSignWarning", "LspDiagnosticsDefaultWarning", "LspDiagnosticsSignError",
	-- 	"LspDiagnosticsSignHint", "LspDiagnosticsSignInformation", "LspDiagnosticsVirtualTextError", "LspDiagnosticsVirtualSignWarning", "LspDiagnosticsVirtualTextHint"}

	for _, highlight in pairs(hl_transparent) do
		vim.api.nvim_set_hl(0, highlight, nobg)
	end

	if c == 'gruvbox' then
		vim.api.nvim_set_hl(0, "GitSignsAdd", { bg = "none", ctermfg = 142, fg = "#b8bb26" })
		vim.api.nvim_set_hl(0, "GitSignsChange", { bg = "none", ctermfg = 108, fg = "#8ec07c" })
		vim.api.nvim_set_hl(0, "GitSignsDelete", { bg = "none", ctermfg = 167, fg = "#fb4934" })
		vim.api.nvim_set_hl(0, "GruvboxYellowSign", { ctermfg = 214, ctermbg = "none", fg = "#fabd2f" })
		vim.api.nvim_set_hl(0, "GruvboxRedSign", { ctermfg = 167, ctermbg = "none", fg = "#fb4934" })
		vim.api.nvim_set_hl(0, "GruvboxAquaSign", { ctermfg = 108, ctermbg = "none", fg = "#8ec07c" })
		vim.api.nvim_set_hl(0, "GruvboxBlueSign", { ctermfg = 109, ctermbg = "none", fg = "#83a598" })

		vim.api.nvim_set_hl(0, "LspDiagnosticsSignWarning", { ctermfg = 214, ctermbg = "none", fg = "#fabd2f", bg =
		"none" })
		vim.api.nvim_set_hl(0, "LspDiagnosticsDefaultWarning", { ctermfg = 214, ctermbg = "none", fg = "#fabd2f", bg =
		"none" })
		vim.api.nvim_set_hl(0, "LspDiagnosticsSignError", { ctermfg = 167, ctermbg = "none", fg = "#fb4934", bg = "none" })
		vim.api.nvim_set_hl(0, "LspDiagnosticsSignHint", { ctermfg = 108, ctermbg = "none", fg = "#8ec07c", bg = "none" })
		vim.api.nvim_set_hl(0, "LspDiagnosticsSignInformation", { ctermfg = 109, ctermbg = "none", fg = "#83a598", bg =
		"none" })
	end
end


local function Color(c)
	vim.cmd.colorscheme(c)
	transparent(c)
end

vim.api.nvim_create_user_command("Colorscheme", function()
	local colorscheme = vim.fn.input("Colorscheme: ")
	Color(colorscheme)
end, {})

-- require('noirbuddy').setup {
--   preset = 'slate',
-- }
-- vim.cmd.colorscheme('habamax')
-- vim.cmd.colorscheme('darkplus')
-- transparent('habamax')

-- vim.api.nvim_set_hl(0, "VimwikiLink", {link="@variable.builtin"})

-- GRUVBOX
vim.cmd.colorscheme('gruvbox')
vim.api.nvim_set_hl(0, "SignColumn", { link = "GruvboxBg1" })
vim.api.nvim_set_hl(0, "GitSignsAdd", { bg = "none", ctermfg = 142, fg = "#b8bb26" })
vim.api.nvim_set_hl(0, "GitSignsChange", { bg = "none", ctermfg = 108, fg = "#8ec07c" })
vim.api.nvim_set_hl(0, "GitSignsDelete", { bg = "none", ctermfg = 167, fg = "#fb4934" })
vim.api.nvim_set_hl(0, "GruvboxYellowSign", { ctermfg = 214, ctermbg = "none", fg = "#fabd2f" })
vim.api.nvim_set_hl(0, "GruvboxRedSign", { ctermfg = 167, ctermbg = "none", fg = "#fb4934" })
vim.api.nvim_set_hl(0, "GruvboxAquaSign", { ctermfg = 108, ctermbg = "none", fg = "#8ec07c" })
vim.api.nvim_set_hl(0, "GruvboxBlueSign", { ctermfg = 109, ctermbg = "none", fg = "#83a598" })

vim.api.nvim_set_hl(0, "Visual", { ctermfg = 20, ctermbg = 50, bg = "#665c54" }) -- Porque me canse del reverse de gruvbox

vim.api.nvim_set_hl(0, "NormalFloat",  { fg = "#b8bb26", bg="#202020" } )
vim.api.nvim_set_hl(0, "NormalFloat",  { fg = "#b8bb26", bg="#202020" } )
-- vim.api.nvim_set_hl(0, "FloatBorder", { bg="#ffffff"})

transparent('gruvbox')
