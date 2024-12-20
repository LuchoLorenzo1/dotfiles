local options = {
	clipboard = "unnamedplus",            -- allows neovim to access the system clipboard
	cmdheight = 1,                        -- more space in the neovim command line for displaying messages
	completeopt = { "menuone", "noselect" }, -- mostly just for cmp
	conceallevel = 0,                     -- so that `` is visible in markdown files
	fileencoding = "utf-8",               -- the encoding written to a file
	hlsearch = false,                     -- highlight all matches on previous search pattern
	ignorecase = true,                    -- ignore case in search patterns
	mouse = "a",                          -- allow the mouse to be used in neovim
	pumheight = 10,                       -- pop up menu height
	showmode = false,                     -- we don't need to see things like -- INSERT -- anymore
	showtabline = 1,                      -- always show tabs
	smartcase = true,                     -- smart case
	smartindent = true,                   -- make indenting smarter again
	splitbelow = true,                    -- force all horizontal splits to go below current window
	splitright = true,                    -- force all vertical splits to go to the right of current window
	termguicolors = true,                 -- set term gui colors (most terminals support this)
	timeoutlen = 1000,                    -- time to wait for a mapped sequence to complete (in milliseconds)
	backup = false,                       -- creates a backup file
	swapfile = false,                     -- creates a swapfile
	writebackup = false,                  -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
	undodir = os.getenv("HOME") .. "/.vim/undodir",
	undofile = true,                      -- enable persistent undo
	updatetime = 300,                     -- faster completion (4000ms default)
	-- expandtab = true,                        -- convert tabs to spaces
	shiftwidth = 4,                       -- the number of spaces inserted for each indentation
	tabstop = 4,                          -- insert 4 spaces for a tab
	cursorline = true,                    -- highlight the current line
	number = true,                        -- set numbered lines
	relativenumber = true,                -- set relative numbered lines
	numberwidth = 1,
	signcolumn = "yes",                   -- always show the sign column, otherwise it would shift the text each time
	wrap = false,                         -- display lines as one long line
	scrolloff = 8,
	sidescrolloff = 8,
	incsearch = true, -- incremental search
	guicursor = "",
	laststatus = 0,
	nuw = 1,
	linespace = 0,
	spelllang = "en",
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.api.nvim_create_user_command("Vimwiki2PDF", ":!pandoc -f vimwiki -t pdf % -o ~/vimwiki/pdf/<f-args>.pdf",
	{ nargs = 1 })
vim.api.nvim_create_user_command("W", ":w", { nargs = 0 })
vim.api.nvim_create_user_command("Q", ":q", { nargs = 0 })


vim.cmd [[
match Bold /dem:\|obs:\|def:/
hi! link Bold GruvboxAquaBold
]]

vim.cmd [[
" let g:copilot_proxy = 'http://localhost:8080'

" let g:netrw_banner=0
" let g:netrw_liststyle=3
" let g:netrw_keepdir=0

augroup vimrc_c
    au FileType c nnoremap <leader>x :!gcc % && ./a.out <CR>
    au FileType c set tabstop=8
    au FileType c set softtabstop=8
    au FileType c set shiftwidth=8
augroup END

augroup vimrc_javascript
    au FileType javascript nnoremap <leader>x :!node %<CR>
    au FileType javascript set tabstop=2
    au FileType javascript set softtabstop=2
    au FileType javascript set shiftwidth=2
augroup END

" VimWiki
let g:vimwiki_list = [{
  \ 'path': '$HOME/vimwiki/vimwiki',
  \ 'template_path': '$HOME/vimwiki/vimwiki/templates',
  \ 'template_default': 'default',
  \ 'template_ext': '.html'}]

augroup vimrc_vimwiki
    au FileType vimwiki nnoremap <F4> :Vimwiki2HTMLBrowse <cr>
    au FileType vimwiki nnoremap <leader> :Vimwiki2HTMLBrowse  <cr>
    au FileType vimwiki nnoremap <leader>* m`0i* <Esc>``
    au FileType vimwiki inoremap ]a á
    au FileType vimwiki inoremap ]e é
    au FileType vimwiki inoremap ]o ó
    au FileType vimwiki inoremap ]i í
    au FileType vimwiki inoremap ]u ú
    au FileType vimwiki inoremap ]A Á
    au FileType vimwiki inoremap ]n ñ
	au filetype vimwiki silent! iunmap <buffer> <Tab>
augroup END

" set statusline=
" set statusline=
" set statusline+=%#PmenuSel#
" set statusline+=%1*\ %{fugitive#statusline()}
" set statusline+=%#LineNr#
" set statusline+=\ %1*\%f
" set statusline+=%=
" set statusline+=%#CursorColumn#
" set statusline+=%1*\%m
" set statusline+=\ %1*\%y
" set statusline+=\ %1*\[%{&fileformat}\]
" set statusline+=\ %1*\%{&fileencoding?&fileencoding:&encoding}
" set statusline+=\ %p%%
" set statusline+=\ %l:%c
" hi User1 guifg=#ffffff guibg=NONE gui=bold

" inoremap <expr> <Tab> search('\%#[]>())}''"`]', 'n') ? '<Right>' : '<Tab>'


" resize window when vim is resized
" autocmd VimResized * wincmd =

" remove trailing spaces in all the file when saving
" autocmd BufWritePre * %s/\s\+$//e

set foldmethod=manual
set foldexpr=nvim_treesitter#foldexpr()

augroup AutoSaveFolds
  autocmd!
  autocmd BufWinLeave ?* mkview 1
  autocmd BufWinEnter ?* silent! loadview 1
augroup END

au FileType * set fo-=c fo-=r fo-=o

source $HOME/.local/share/nvim/site/pack/packer/start/vim-sandwich/macros/sandwich/keymap/surround.vim

let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

let g:git_messenger_no_default_mappings = v:true
let g:vimwiki_table_mappings = 0
]]

vim.api.nvim_create_autocmd('TextYankPost', {
	group = vim.api.nvim_create_augroup('yank_highlight', {}),
	pattern = '*',
	callback = function()
		vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 200 })
	end
})

vim.api.nvim_create_autocmd('BufWritePost', {
	group = vim.api.nvim_create_augroup('nginx-conf', {}),
	pattern = '*.conf',
	callback = function()
		vim.cmd("silent !docker exec $(docker ps -aqf 'name=nginx-playground') nginx -s reload")
	end
})

-- vim.cmd([[
-- function Tildes()
-- 	:%s/ ́o/ó/g
-- 	:%s/ ́a/á/g
-- 	:%s/ ̃n/ñ/g
-- 	:%s/ ́ı/í/g
-- endfunction
-- command tildes exec Tildes()
-- ]])

vim.api.nvim_create_user_command("Clear", function()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local config = vim.api.nvim_win_get_config(win);
		if config.relative ~= "" then vim.api.nvim_win_close(win, false) end
	end
end, {})

local copilot_on = true;
vim.api.nvim_create_user_command('CopilotToggle', function ()
	if copilot_on then
		vim.cmd('Copilot disable')
		print("Copilot OFF")
	else
		vim.cmd('Copilot enable')
		print("Copilot ON")
	end
	copilot_on = not copilot_on
end, {nargs = 0})
vim.keymap.set('', '<leader>sc', ':CopilotToggle<CR>', { noremap = true, silent = true })


vim.cmd([[
	" set listchars=nbsp:☠,tab:▸␣
	set listchars=tab:→\ ,space:·,nbsp:␣,trail:.,eol:¶,precedes:«,extends:»
]])

-- Function to toggle between .html and .ts files
function ToggleExtension()
    local filepath = vim.fn.expand('%:p')

    if filepath:match('%.html$') then
        local newfile = filepath:gsub('%.html$', '.ts')
        vim.cmd('edit ' .. newfile)
    elseif filepath:match('%.ts$') then
        local newfile = filepath:gsub('%.ts$', '.html')
        vim.cmd('edit ' .. newfile)
    elseif filepath:match('%.css$') then
        local newfile = filepath:gsub('%.css$', '.html')
        vim.cmd('edit ' .. newfile)
    else
        print("No valid Angular component file found!", filepath, vim.fn.expand('%:p'))
    end
end

-- Create an augroup for Angular component files
vim.cmd([[
augroup AngularComponent
  autocmd!
  autocmd BufReadPost *.ts,*.html,*.css lua vim.api.nvim_set_keymap('n', '<c-t>', ':lua ToggleExtension()<CR>', { noremap = true, silent = true })
augroup END
]])
