--vim.opt.background = "light"
vim.opt.background = "dark"

-- require('onedark').setup {
-- 	-- Main options --
-- 	style = 'dark', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
-- 	transparent = false, -- Show/hide background
-- 	term_colors = true, -- Change terminal color as per the selected theme style
-- 	ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
-- 	cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
-- 	-- toggle theme style ---
-- 	toggle_style_key = '<F-7>', -- Default keybinding to toggle
-- 	toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' }, -- List of styles to toggle between
-- 	-- Change code style ---
-- 	-- Options are italic, bold, underline, none
-- 	-- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
-- 	code_style = {
-- 		comments = 'italic',
-- 		keywords = 'none',
-- 		functions = 'none',
-- 		strings = 'none',
-- 		variables = 'none'
-- 	},
-- 	-- Custom Highlights --
-- 	colors = {}, -- Override default colors
-- 	highlights = {}, -- Override highlight groups
-- 	-- Plugins Config --
-- 	diagnostics = {
-- 		darker = true, -- darker colors for diagnostic
-- 		undercurl = true, -- use undercurl instead of underline for diagnostics
-- 		background = true, -- use background color for virtual text
-- 	},
-- }

-- require('onedark').load()

vim.cmd([[
colorscheme gruvbox

hi WinSeparator guibg=NONE "dejar siempre, separador entre panes

" :set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
"   \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
"   \,sm:block-blinkwait175-blinkoff150-blinkon175

set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50

hi Normal guibg=NONE guifg=NONE
hi LineNr guibg=NONE guifg=NONE ctermbg=NONE
hi StatusLine guifg=NONE guibg=NONE
hi EndOfBuffer guibg=NONE ctermbg=NONE

" hi BufferInactive guibg=red ctermbg=red
" hi BufferInactiveSign guibg=red ctermbg=red
" hi BufferInactiveMod guibg=red ctermbg=red
" hi BufferInactiveIndex guibg=red ctermbg=red
" hi BufferInactiveTarget guibg=red ctermbg=red
" hi BufferCurrent guibg=red ctermbg=red

hi Cursor guibg=gray guifg=reverted cterm=NONE gui=NONE
" hi Cursor guibg=gray ctermfg=2 ctermbg=15 guifg=black cterm=NONE gui=NONE
" hi CursorLine guibg=blue guifg=black
" hi CursorColumn guibg=black guifg=black


hi Column guibg=NONE guifg=NONE
hi ColorColumn guibg=NONE guifg=NONE
hi SignColumn guibg=NONE guifg=NONE

"" GRUVBOX WITH OPACITY :
hi GitSignsAdd guibg=NONE ctermfg=142 guifg=#b8bb26 guibg=NONE
hi GitSignsChange guibg=NONE ctermfg=108 guifg=#8ec07c guibg=NONE
hi GitSignsDelete guibg=NONE ctermfg=167 guifg=#fb4934 guibg=NONE

hi GruvboxYellowSign ctermfg=214 ctermbg=NONE guifg=#fabd2f guibg=NONE
hi GruvboxRedSign ctermfg=167 ctermbg=NONE guifg=#fb4934 guibg=NONE
hi GruvboxAquaSign ctermfg=108 ctermbg=NONE guifg=#8ec07c guibg=NONE
hi GruvboxBlueSign ctermfg=109 ctermbg=NONE guifg=#83a598 guibg=NONE

" hi LspDiagnosticsSignWarning ctermfg=214 ctermbg=NONE guifg=#fabd2f guibg=NONE cterm=NONE gui=NONE
" hi LspDiagnosticsDefaultWarning ctermfg=214 ctermbg=NONE guifg=#fabd2f guibg=NONE cterm=NONE gui=NONE
" hi LspDiagnosticsSignError ctermfg=167 ctermbg=NONE guifg=#fb4934 guibg=NONE
" hi LspDiagnosticsSignHint ctermfg=108 ctermbg=NONE guifg=#8ec07c guibg=NONE
" hi LspDiagnosticsSignInformation ctermfg=109 ctermbg=NONE guifg=#83a598 guibg=NONE

]])
