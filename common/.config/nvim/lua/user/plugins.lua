local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system {
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	}
	print "Installing packer close and reopen Neovim..."
	vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init {
	display = {
		open_fn = function()
			return require("packer.util").float { border = "rounded" }
		end,
	},
}

return packer.startup(function(use)
	use "wbthomason/packer.nvim"
	use "nvim-lua/popup.nvim"
	use "nvim-lua/plenary.nvim"
	use "vimwiki/vimwiki"

	-- Colorschemes
	-- use "lunarvim/colorschemes"
	-- use "lunarvim/darkplus.nvim"
	use "gruvbox-community/gruvbox"
	-- use "navarasu/onedark.nvim"
	-- use "ayu-theme/ayu-vim"
	-- use "tjdevries/colorbuddy.vim"
	-- use "tjdevries/gruvbuddy.nvim"
	-- use "tanvirtin/monokai.nvim"
	-- use {
	--   "jesseleite/nvim-noirbuddy",
	--   requires = { "tjdevries/colorbuddy.nvim", branch = "dev" }
	-- }

	use "github/copilot.vim"

	-- cmp plugins
	use "hrsh7th/nvim-cmp"
	use "hrsh7th/cmp-buffer"
	use "hrsh7th/cmp-path"
	use "hrsh7th/cmp-cmdline"
	use "saadparwaiz1/cmp_luasnip"
	use "hrsh7th/cmp-nvim-lsp"
	use "hrsh7th/cmp-nvim-lua"

	-- snippets
	use "L3MON4D3/LuaSnip"
	use "rafamadriz/friendly-snippets"

	-- LSP
	use "neovim/nvim-lspconfig"
	-- use "ray-x/lsp_signature.nvim"
	use "williamboman/mason.nvim"
	use "williamboman/mason-lspconfig.nvim"
	-- use "nvimtools/none-ls.nvim"

	-- Telescope
	use "nvim-telescope/telescope.nvim"

	-- Treesitter
	use {
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	}
	use "nvim-treesitter/playground"
	use "nvim-treesitter/nvim-treesitter-textobjects"
	-- use "p00f/nvim-ts-rainbow"
	use {
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup {}
		end
	}
	use 'nvim-treesitter/nvim-treesitter-context'


	use "machakann/vim-sandwich"
	use "matze/vim-move"
	use "tpope/vim-repeat"

	use {
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	}

	use "lewis6991/gitsigns.nvim"
	use "tpope/vim-fugitive"
	use "tpope/vim-rhubarb"
	use "junegunn/gv.vim"

	use "unblevable/quick-scope"

	use "mbbill/undotree"
	use "nvim-lualine/lualine.nvim"

	-- use "ThePrimeagen/harpoon"

	-- use { 'dccsillag/magma-nvim', run = ':UpdateRemotePlugins' }

	-- use {
	-- 	"ThePrimeagen/refactoring.nvim",
	-- 	requires = {
	-- 		{"nvim-lua/plenary.nvim"},
	-- 		{"nvim-treesitter/nvim-treesitter"}
	-- 	}
	-- }

	-- use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
	-- use 'simrat39/rust-tools.nvim'

	use 'nvim-tree/nvim-tree.lua'
	use 'nvim-tree/nvim-web-devicons'

	use {
		"SmiteshP/nvim-navbuddy",
		requires = {
			"neovim/nvim-lspconfig",
			"SmiteshP/nvim-navic",
			"MunifTanjim/nui.nvim",
			"numToStr/Comment.nvim", -- Optional
			"nvim-telescope/telescope.nvim" -- Optional
		}
	}

	use({
		'ckolkey/ts-node-action',
		 requires = { 'nvim-treesitter' },
		 config = function()
			 require("ts-node-action").setup({})
		 end
	})

	-- use {
	-- 	'CopilotC-Nvim/CopilotChat.nvim',
	-- 	config = require("CopilotChat").setup {
	-- 	  debug = true, -- Enable debugging
	-- 	  -- See Configuration section for rest
	-- 	}
	-- }

	-- use { 'rhysd/git-messenger.vim' } --- lo saco porq gitsigns trae uno

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
