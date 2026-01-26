local options = {
	clipboard = "unnamedplus",
	cmdheight = 1,
	completeopt = { "menuone", "noselect" },
	conceallevel = 0,
	fileencoding = "utf-8",
	hlsearch = false,
	ignorecase = true,
	mouse = "a",
	pumheight = 10,
	showmode = false,
	showtabline = 1,
	smartcase = true,
	smartindent = true,
	splitbelow = true,
	splitright = true,
	termguicolors = true,
	timeoutlen = 1000,
	backup = false,
	swapfile = false,
	writebackup = false,
	undodir = vim.fn.expand("~/.vim/undodir"),
	undofile = true,
	updatetime = 300,
	shiftwidth = 4,
	tabstop = 4,
	cursorline = true,
	number = true,
	relativenumber = true,
	numberwidth = 1,
	signcolumn = "yes",
	wrap = false,
	scrolloff = 8,
	sidescrolloff = 8,
	incsearch = true,
	guicursor = "",
	laststatus = 2,
	nuw = 1,
	linespace = 0,
	spelllang = "en",
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.api.nvim_create_user_command("Vimwiki2PDF", ":!pandoc -f vimwiki -t pdf % -o ~/vimwiki/pdf/<f-args>.pdf -V geometry:margin=1in", { nargs = 1 })
vim.api.nvim_create_user_command("W", ":w", { nargs = 0 })
vim.api.nvim_create_user_command("Q", ":q", { nargs = 0 })

vim.cmd [[
match Bold /dem:\|obs:\|def:/
hi! link Bold GruvboxAquaBold
]]

vim.cmd [[
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

augroup markdown
    au FileType markdown inoremap ]a á
    au FileType markdown inoremap ]e é
    au FileType markdown inoremap ]o ó
    au FileType markdown inoremap ]i í
    au FileType markdown inoremap ]u ú
    au FileType markdown inoremap ]A Á
    au FileType markdown inoremap ]n ñ
augroup END

set foldmethod=manual
set foldexpr=nvim_treesitter#foldexpr()

augroup AutoSaveFolds
  autocmd!
  autocmd BufWinLeave ?* mkview 1
  autocmd BufWinEnter ?* silent! loadview 1
augroup END

au FileType * set fo-=c fo-=r fo-=o

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

vim.api.nvim_create_user_command("Clear", function()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local config = vim.api.nvim_win_get_config(win);
		if config.relative ~= "" then vim.api.nvim_win_close(win, false) end
	end
end, {})

local copilot_on = true;
vim.api.nvim_create_user_command('CopilotToggle', function()
	if copilot_on then
		vim.cmd('Copilot disable')
		print("Copilot OFF")
	else
		vim.cmd('Copilot enable')
		print("Copilot ON")
	end
	copilot_on = not copilot_on
end, { nargs = 0 })
vim.keymap.set('', '<leader>sc', ':CopilotToggle<CR>', { noremap = true, silent = true })

vim.cmd([[
	set listchars=tab:→\ ,space:·,nbsp:␣,trail:.,eol:¶,precedes:«,extends:»
]])

-- Toggle between Angular component files (.ts, .html, .css)
local function toggle_angular_extension()
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
		print("No valid Angular component file found!")
	end
end

vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = { "*.ts", "*.html", "*.css" },
	callback = function()
		vim.keymap.set('n', '<c-t>', toggle_angular_extension, { buffer = true, noremap = true, silent = true })
	end
})

vim.keymap.set("v", "<leader>rp", ":!python3 -c \"import sys; print(eval(sys.stdin.read()))\"<CR>", { desc = "Eval Python selection and replace" })
