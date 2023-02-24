local nobg = { bg = "none", fg = "none"}

local function transparent(c)
    	local hl_transparent = { "WinSeparator", "Normal", "NormalNC", "LineNr", "StatusLine", "Column", "ColorColumn",
    		"SignColumn", "EndOfBuffer" }

    	-- local hl_lsp = { "LspDiagnosticsSignWarning", "LspDiagnosticsDefaultWarning", "LspDiagnosticsSignError",
    	-- 	"LspDiagnosticsSignHint", "LspDiagnosticsSignInformation", "LspDiagnosticsVirtualTextError", "LspDiagnosticsVirtualSignWarning", "LspDiagnosticsVirtualTextHint"}

    	for _, highlight in pairs(hl_transparent) do
    		vim.api.nvim_set_hl(0, highlight, nobg)
    	end

    	if c == 'gruvbox' then
    		vim.api.nvim_set_hl(0, "GitSignsAdd", {guibg="none", ctermfg="142", guifg="#b8bb26"})
    		vim.api.nvim_set_hl(0, "GitSignsChange", {guibg="none", ctermfg=108, guifg="#8ec07c"})
    		vim.api.nvim_set_hl(0, "GitSignsDelete", {guibg="none", ctermfg=167, guifg="#fb4934"})
    		vim.api.nvim_set_hl(0, "GruvboxYellowSign", {ctermfg=214, ctermbg="none", guifg="#fabd2f"})
    		vim.api.nvim_set_hl(0, "GruvboxRedSign", {ctermfg=167, ctermbg="none", guifg="#fb4934"})
    		vim.api.nvim_set_hl(0, "GruvboxAquaSign", {ctermfg=108, ctermbg="none", guifg="#8ec07c"})
    		vim.api.nvim_set_hl(0, "GruvboxBlueSign", {ctermfg=109, ctermbg="none", guifg="#83a598"})

    		vim.api.nvim_set_hl(0, "LspDiagnosticsSignWarning", {ctermfg=214, ctermbg="none", guifg="#fabd2f", guibg="none", cterm="none", gui="none"})
    		vim.api.nvim_set_hl(0, "LspDiagnosticsDefaultWarning", {ctermfg=214, ctermbg="none", guifg="#fabd2f", guibg="none", cterm="none", gui="none"})
    		vim.api.nvim_set_hl(0, "LspDiagnosticsSignError", {ctermfg=167, ctermbg="none", guifg="#fb4934", guibg="none"})
    		vim.api.nvim_set_hl(0, "LspDiagnosticsSignHint", {ctermfg=108, ctermbg="none", guifg="#8ec07c", guibg="none"})
    		vim.api.nvim_set_hl(0, "LspDiagnosticsSignInformation", {ctermfg=109, ctermbg="none", guifg="#83a598", guibg="none"})
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

require('noirbuddy').setup {
  preset = 'slate',
}
-- transparent('noirbuddy')

vim.api.nvim_set_hl(0, "VimwikiLink", {link="@variable.builtin"})

