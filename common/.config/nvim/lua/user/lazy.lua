local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("lazy").setup({
	spec = {
		{ "nvim-lua/popup.nvim" },
		{ "nvim-lua/plenary.nvim" },
		{ "gruvbox-community/gruvbox" },
		{ "github/copilot.vim" },
		{ "hrsh7th/nvim-cmp" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "hrsh7th/cmp-cmdline" },
		{ "saadparwaiz1/cmp_luasnip" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-nvim-lua" },
		{ "L3MON4D3/LuaSnip" },
		{ "rafamadriz/friendly-snippets" },
		{ "neovim/nvim-lspconfig" },
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },
		{ "nvim-telescope/telescope.nvim" },
		{ "nvim-treesitter/nvim-treesitter" },
		{ "nvim-treesitter/playground" },
		{ "nvim-treesitter/nvim-treesitter-textobjects" },
		{ 'nvim-treesitter/nvim-treesitter-context' },
		{ "machakann/vim-sandwich" },
		{ "matze/vim-move" },
		{ "tpope/vim-repeat" },
		{ "lewis6991/gitsigns.nvim" },
		{ "tpope/vim-fugitive" },
		{ "tpope/vim-rhubarb" },
		{ "junegunn/gv.vim" },
		{ "unblevable/quick-scope" },
		{ "mbbill/undotree" },
		{ "nvim-lualine/lualine.nvim" },
		{ "ThePrimeagen/harpoon" },
		{ 'nvim-tree/nvim-tree.lua' },
		{ 'nvim-tree/nvim-web-devicons' },
		{
			'RaafatTurki/hex.nvim',
			config = function()
				require('hex').setup()
			end
		},
		{
			"windwp/nvim-autopairs",
			config = function()
				require("nvim-autopairs").setup {}
			end
		},
		{
			'numToStr/Comment.nvim',
			config = function() require('Comment').setup() end
		},
		{
			'ckolkey/ts-node-action',
			requires = { 'nvim-treesitter' },
			config = function()
				require("ts-node-action").setup({})
			end
		},
		{
			'MeanderingProgrammer/render-markdown.nvim',
			dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
			-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
			-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
			---@module 'render-markdown'
			---@type render.md.UserConfig
			opts = {},
		},
		-- {
		-- 	dir = "~/workspace/caido.nvim",
		-- 	config = function()
		-- 		require("caido").setup()
		-- 	end,
		-- },
	}
})
