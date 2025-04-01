local opts = { noremap = true, silent = true }

local opts1 = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
-- keymap("n", "<C-h>", "<C-w>h", opts)
-- keymap("n", "<C-j>", "<C-w>j", opts)
-- keymap("n", "<C-k>", "<C-w>k", opts)
-- keymap("n", "<C-l>", "<C-w>l", opts)

-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", opts1)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", opts1)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", opts1)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", opts1)

-- keymap("n", "<c-m>", "<c-w>|", opts) -- expand current split

keymap("n", "<c-n>", ":NvimTreeToggle<CR>", opts)
-- keymap("n", "<c-n>", ":Lexplore 20<CR>", opts)

-- Resize with c-arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

keymap("n", "<leader>sw", ":set wrap!<cr>", opts)
keymap("n", "<leader>sl", ":set spell!<cr>", opts)
keymap("n", "<leader>sh", ":set list!<CR>", opts)
keymap("n", "<leader>cj", ":clearjumps<cr>", opts)

keymap("n", "<C-d>", "<c-d>zz", opts)
keymap("n", "<C-u>", "<c-u>zz", opts)
keymap("n", "J", "mzJ`z", opts) -- keep cursor where it is when J

keymap("n", "n", "nzzzv", opts) --  center the cursor while searching
keymap("n", "N", "Nzzzv", opts)

keymap("x", "<leader>p", "\"_dP", opts)

-- yank paragraph and stay in the same place
keymap("n", "yip", "m`yip``", { silent = true, noremap = true })

--buffer navigation
keymap("n", "]b", ":bnext<CR>", opts)
keymap("n", "[b", ":bprev<CR>", opts)

--tab navigation
keymap("n", "]t", ":tabnext<CR>", opts)
keymap("n", "[t", ":tabprev<CR>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts1)
keymap("v", ">", ">gv", opts1)

keymap("i", "<C-d>", "<Del>", opts1)
-- keymap("n", "<leader>T", ":vsp <cr>:let $VIM_DIR=expand('%:p:h')<CR>:terminal<CR>icd $VIM_DIR<CR>", opts1)

keymap("n", "<leader>o", "o<Esc>", opts1)
keymap("n", "<leader>O", "O<Esc>", opts1)


-- QUICKFIX LISTS --
keymap("n", "<leader>k", ":cp<CR>", opts1)
keymap("n", "<leader>j", ":cn<CR>", opts1)
keymap("n", "<leader>c", ":ccl<CR>", opts1)

-- VIMWIKI --
-- keymap("n", "<Tab>", "/[[<CR>", opts1)

-- keymap("n", "<leader>hm", ":GitMessenger<CR>", opts1)
keymap("n", "gF", ":e <cfile><CR>", opts1)


keymap("n", "<leader>x", ":!chmod +x %<CR><Esc>", opts1)

keymap("n", "<leader>na", ":NodeAction<CR>", opts1)
