vim.cmd.colorscheme('gruvbox')


vim.cmd([[
set background=dark
hi WinSeparator guibg=NONE "dejar siempre, separador entre panes

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

hi Cursor guibg=red guifg=pink
hi iCursor guibg=red guifg=pink
hi lCursor guibg=red guifg=pink
hi multiple_cursors_cursor guibg=red guifg=pink
]])
