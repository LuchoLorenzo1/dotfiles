local opts = { noremap = true, silent = true }

vim.keymap.set("", "<Space>", "<Nop>", opts)

vim.keymap.set("n", "<c-n>", ":NvimTreeToggle<CR>", opts)

-- Resize with c-arrows
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

vim.keymap.set("n", "<leader>sw", ":set wrap!<cr>", opts)
vim.keymap.set("n", "<leader>sl", ":set spell!<cr>", opts)
vim.keymap.set("n", "<leader>sh", ":set list!<CR>", opts)
vim.keymap.set("n", "<leader>cj", ":clearjumps<cr>", opts)

vim.keymap.set("n", "<C-d>", "<c-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<c-u>zz", opts)
vim.keymap.set("n", "J", "mzJ`z", opts) -- keep cursor where it is when J

vim.keymap.set("n", "n", "nzzzv", opts) -- center the cursor while searching
vim.keymap.set("n", "N", "Nzzzv", opts)

vim.keymap.set("x", "<leader>p", "\"_dP", opts)

-- yank paragraph and stay in the same place
vim.keymap.set("n", "yip", "m`yip``", opts)

-- buffer navigation
vim.keymap.set("n", "]b", ":bnext<CR>", opts)
vim.keymap.set("n", "[b", ":bprev<CR>", opts)

-- tab navigation
vim.keymap.set("n", "]t", ":tabnext<CR>", opts)
vim.keymap.set("n", "[t", ":tabprev<CR>", opts)

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", { silent = true })
vim.keymap.set("v", ">", ">gv", { silent = true })

vim.keymap.set("i", "<C-d>", "<Del>", { silent = true })

vim.keymap.set("n", "<leader>o", "o<Esc>", { silent = true })
vim.keymap.set("n", "<leader>O", "O<Esc>", { silent = true })

-- Quickfix lists
vim.keymap.set("n", "<leader>k", ":cp<CR>", { silent = true })
vim.keymap.set("n", "<leader>j", ":cn<CR>", { silent = true })
vim.keymap.set("n", "<leader>c", ":ccl<CR>", { silent = true })

vim.keymap.set("n", "gF", ":e <cfile><CR>", { silent = true })

vim.keymap.set("n", "<leader>x", ":!chmod +x %<CR><Esc>", { silent = true })

vim.keymap.set("n", "<leader>na", ":NodeAction<CR>", { silent = true })
