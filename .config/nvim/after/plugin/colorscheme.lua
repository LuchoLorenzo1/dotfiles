local nobg = { bg = "none", fg = "none"}

local function Color(c)
	vim.cmd.colorscheme(c)
	local hl_transparent = { "WinSeparator", "Normal", "NormalNC", "LineNr", "StatusLine", "Column", "ColorColumn",
		"SignColumn", "EndOfBuffer" }

	-- local hl_lsp = { "LspDiagnosticsSignWarning", "LspDiagnosticsDefaultWarning", "LspDiagnosticsSignError",
	-- 	"LspDiagnosticsSignHint", "LspDiagnosticsSignInformation", "LspDiagnosticsVirtualTextError", "LspDiagnosticsVirtualSignWarning", "LspDiagnosticsVirtualTextHint"}

	for _, highlight in pairs(hl_transparent) do
		vim.api.nvim_set_hl(0, highlight, nobg)
	end

	if c == 'gruvbox' then
		vim.cmd([[
			hi GitSignsAdd guibg=NONE ctermfg=142 guifg=#b8bb26 guibg=NONE
			hi GitSignsChange guibg=NONE ctermfg=108 guifg=#8ec07c guibg=NONE
			hi GitSignsDelete guibg=NONE ctermfg=167 guifg=#fb4934 guibg=NONE
			hi GruvboxYellowSign ctermfg=214 ctermbg=NONE guifg=#fabd2f guibg=NONE
			hi GruvboxRedSign ctermfg=167 ctermbg=NONE guifg=#fb4934 guibg=NONE
			hi GruvboxAquaSign ctermfg=108 ctermbg=NONE guifg=#8ec07c guibg=NONE
			hi GruvboxBlueSign ctermfg=109 ctermbg=NONE guifg=#83a598 guibg=NONE

			hi LspDiagnosticsSignWarning ctermfg=214 ctermbg=NONE guifg=#fabd2f guibg=NONE cterm=NONE gui=NONE
			hi LspDiagnosticsDefaultWarning ctermfg=214 ctermbg=NONE guifg=#fabd2f guibg=NONE cterm=NONE gui=NONE
			hi LspDiagnosticsSignError ctermfg=167 ctermbg=NONE guifg=#fb4934 guibg=NONE
			hi LspDiagnosticsSignHint ctermfg=108 ctermbg=NONE guifg=#8ec07c guibg=NONE
			hi LspDiagnosticsSignInformation ctermfg=109 ctermbg=NONE guifg=#83a598 guibg=NONE

		]])
	end
end

vim.api.nvim_create_user_command("Color", function()
	local colorscheme = vim.fn.input("Colorscheme: ")
	Color(colorscheme)
end, {})

Color('darkplus')

-- vim.cmd([[

-- "" GRUVBOX WITH OPACITY :
-- hi GitSignsAdd guibg=NONE ctermfg=142 guifg=#b8bb26 guibg=NONE
-- hi GitSignsChange guibg=NONE ctermfg=108 guifg=#8ec07c guibg=NONE
-- hi GitSignsDelete guibg=NONE ctermfg=167 guifg=#fb4934 guibg=NONE
--
-- hi GruvboxYellowSign ctermfg=214 ctermbg=NONE guifg=#fabd2f guibg=NONE
-- hi GruvboxRedSign ctermfg=167 ctermbg=NONE guifg=#fb4934 guibg=NONE
-- hi GruvboxAquaSign ctermfg=108 ctermbg=NONE guifg=#8ec07c guibg=NONE
-- hi GruvboxBlueSign ctermfg=109 ctermbg=NONE guifg=#83a598 guibg=NONE
-- ]])
