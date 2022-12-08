local options = {
	backup = false, -- creates a backup file
	clipboard = "unnamedplus", -- allows neovim to access the system clipboard
	cmdheight = 1, -- more space in the neovim command line for displaying messages
	completeopt = { "menuone", "noselect" }, -- mostly just for cmp
	conceallevel = 0, -- so that `` is visible in markdown files
	fileencoding = "utf-8", -- the encoding written to a file
	hlsearch = false, -- highlight all matches on previous search pattern
	ignorecase = true, -- ignore case in search patterns
	mouse = "a", -- allow the mouse to be used in neovim
	pumheight = 10, -- pop up menu height
	showmode = false, -- we don't need to see things like -- INSERT -- anymore
	showtabline = 1, -- always show tabs
	smartcase = true, -- smart case
	smartindent = true, -- make indenting smarter again
	splitbelow = true, -- force all horizontal splits to go below current window
	splitright = true, -- force all vertical splits to go to the right of current window
	swapfile = false, -- creates a swapfile
	termguicolors = true, -- set term gui colors (most terminals support this)
	timeoutlen = 1000, -- time to wait for a mapped sequence to complete (in milliseconds)
	undofile = true, -- enable persistent undo
	updatetime = 300, -- faster completion (4000ms default)
	writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
	--expandtab = true,                        -- convert tabs to spaces
	shiftwidth = 4, -- the number of spaces inserted for each indentation
	tabstop = 4, -- insert 4 spaces for a tab
	cursorline = true, -- highlight the current line
	number = true, -- set numbered lines
	relativenumber = true, -- set relative numbered lines
	numberwidth = 1,
	signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
	wrap = false, -- display lines as one long line
	scrolloff = 8,
	sidescrolloff = 8,
	guifont = "monospace:h17", -- the font used in graphical neovim applicationguicursor
	incsearch = true,
	-- guicursor = "",
	laststatus = 0,
	nuw = 1,
	linespace = 0,
	spelllang = "es",
}

vim.cmd [[
:set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
  \,sm:block-blinkwait175-blinkoff150-blinkon175
]]

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.cmd "autocmd VimResized * wincmd ="

vim.api.nvim_create_user_command("Vimwiki2PDF", ":!pandoc -f vimwiki -t pdf % -o ~/vimwiki/pdf/<f-args>.pdf",
	{ nargs = 1 })
vim.api.nvim_create_user_command("W", ":w", { nargs = 0 })
vim.api.nvim_create_user_command("Q", ":q", { nargs = 0 })

vim.cmd [[
match Bold /dem:\|obs:\|def:/
hi! link Bold GruvboxAquaBold
]]


vim.cmd [[

let g:netrw_banner=0
let g:netrw_liststyle=3

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

augroup vimrc_python
    au FileType python nnoremap <leader>x :!python3 % <CR>
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
augroup END


set statusline=
" set statusline+=%#PmenuSel#
set statusline+=%1*\ %{fugitive#statusline()}
" set statusline+=%#LineNr#
set statusline+=\ %1*\%f
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=%1*\%m
set statusline+=\ %1*\%y
set statusline+=\ %1*\[%{&fileformat}\]
set statusline+=\ %1*\%{&fileencoding?&fileencoding:&encoding}
set statusline+=\ %p%%
set statusline+=\ %l:%c

hi User1 guifg=#ffffff guibg=NONE gui=bold

inoremap <expr> <Tab> search('\%#[]>())}''"`]', 'n') ? '<Right>' : '<Tab>'

autocmd VimResized * wincmd =
autocmd BufWritePre * %s/\s\+$//e


" set foldmethod=manual
"set foldexpr=nvim_treesitter#foldexpr()

" augroup AutoSaveFolds
"   autocmd!
"   autocmd BufWinLeave * mkview
"   autocmd BufWinEnter * silent! loadview
" augroup END

au FileType * set fo-=c fo-=r fo-=o


source $HOME/.local/share/nvim/site/pack/packer/start/vim-sandwich/macros/sandwich/keymap/surround.vim

let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
]]

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<C-c>", "<cmd>PickColor<cr>", opts)
vim.keymap.set("i", "<C-c>", "<cmd>PickColorInsert<cr>", opts)

-- vim.keymap.set("n", "your_keymap", "<cmd>ConvertHEXandRGB<cr>", opts)
-- vim.keymap.set("n", "your_keymap", "<cmd>ConvertHEXandHSL<cr>", opts)

require("color-picker").setup({ -- for changing icons & mappings
	-- ["icons"] = { "ﱢ", "" },
	-- ["icons"] = { "ﮊ", "" },
	-- ["icons"] = { "", "ﰕ" },
	-- ["icons"] = { "", "" },
	-- ["icons"] = { "", "" },
	["icons"] = { "ﱢ", "" },
	["border"] = "rounded", -- none | single | double | rounded | solid | shadow
	["keymap"] = { -- mapping example:
		["U"] = "<Plug>ColorPickerSlider5Decrease",
		["O"] = "<Plug>ColorPickerSlider5Increase",
	},
	["background_highlight_group"] = "Normal", -- default
	["border_highlight_group"] = "FloatBorder", -- default
	["text_highlight_group"] = "Normal", --default
})
vim.cmd([[hi FloatBorder guibg=NONE]]) -- if you don't want weird border background colors around the popup.

vim.cmd([[
function Tildes()
	:%s/ ́o/ó/g
	:%s/ ́a/á/g
	:%s/ ̃n/ñ/g
	:%s/ ́ı/í/g
endfunction

command Tildes exec Tildes()
]])


require('refactoring').setup({
	prompt_func_return_type = {
		go = false,
		java = false,
		cpp = false,
		c = false,
		h = false,
		hpp = false,
		cxx = false,
	},
	prompt_func_param_type = {
		go = false,
		java = false,
		cpp = false,
		c = false,
		h = false,
		hpp = false,
		cxx = false,
	},
	printf_statements = {},
	print_var_statements = {
		-- add a custom print var statement for cpp
		-- cpp = {
		-- 	'printf("a custom statement %%s %s", %s)'
		-- }
	}
})

-- Remaps for the refactoring operations currently offered by the plugin
vim.api.nvim_set_keymap("v", "<leader>re", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], { noremap = true, silent = true, expr = false })
vim.api.nvim_set_keymap("v", "<leader>rf", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]], { noremap = true, silent = true, expr = false })
vim.api.nvim_set_keymap("v", "<leader>rv", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]], { noremap = true, silent = true, expr = false })
vim.api.nvim_set_keymap("v", "<leader>ri", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], { noremap = true, silent = true, expr = false })

-- Extract block doesn't need visual mode
vim.api.nvim_set_keymap("n", "<leader>rb", [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]],
	{ noremap = true, silent = true, expr = false })
vim.api.nvim_set_keymap("n", "<leader>rbf", [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]],
	{ noremap = true, silent = true, expr = false })

-- Inline variable can also pick up the identifier currently under the cursor without visual mode
vim.api.nvim_set_keymap("n", "<leader>ri", [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
	{ noremap = true, silent = true, expr = false })

-- You can also use below = true here to to change the position of the printf
-- statement (or set two remaps for either one). This remap must be made in normal mode.
vim.api.nvim_set_keymap( "n", "<leader>df", ":lua require('refactoring').debug.printf({below = false})<CR>", { noremap = true })

-- Print var
-- Remap in normal mode and passing { normal = true } will automatically find the variable under the cursor and print it
vim.api.nvim_set_keymap("n", "<leader>dv", ":lua require('refactoring').debug.print_var({ normal = true })<CR>",
	{ noremap = true, silent = true})

-- Remap in visual mode will print whatever is in the visual selection
vim.api.nvim_set_keymap("v", "<leader>dv", ":lua require('refactoring').debug.print_var({})<CR>", { noremap = true })

-- Cleanup function: this remap should be made in normal mode
vim.api.nvim_set_keymap("n", "<leader>dc", ":lua require('refactoring').debug.cleanup({})<CR>", { noremap = true })
