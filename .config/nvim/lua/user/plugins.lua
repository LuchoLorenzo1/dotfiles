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

-- Install your plugins here
return packer.startup(function(use)
	use "vimwiki/vimwiki"

	use "wbthomason/packer.nvim" -- Have packer manage itself
	use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
	use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

	-- Colorschemes
	-- use "lunarvim/colorschemes"
	use "lunarvim/darkplus.nvim"
	use "gruvbox-community/gruvbox"
	-- use "navarasu/onedark.nvim"
	-- use "ayu-theme/ayu-vim"
	-- use "tjdevries/colorbuddy.vim"
	-- use "tjdevries/gruvbuddy.nvim"
	-- use "tanvirtin/monokai.nvim"

	-- use "github/copilot.vim"

	-- cmp plugins
	use "hrsh7th/nvim-cmp" -- The completion plugin
	use "hrsh7th/cmp-buffer" -- buffer completions
	use "hrsh7th/cmp-path" -- path completions
	use "hrsh7th/cmp-cmdline" -- cmdline completions
	use "saadparwaiz1/cmp_luasnip" -- snippet completions
	use "hrsh7th/cmp-nvim-lsp"
	use "hrsh7th/cmp-nvim-lua"

	-- snippets
	use "L3MON4D3/LuaSnip" --snippet engine
	use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

	-- LSP
	use "neovim/nvim-lspconfig" -- enable LSP
	use "williamboman/nvim-lsp-installer" -- simple to use language server installer
	use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
	-- use "glepnir/lspsaga.nvim" -- Ventanitas facheras para lsp
	use "jose-elias-alvarez/null-ls.nvim"

	-- Telescope
	use "nvim-telescope/telescope.nvim"

	-- Treesitter
	use {
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	}
	use "nvim-treesitter/playground"
	use "nvim-treesitter/nvim-treesitter-textobjects"
	use "p00f/nvim-ts-rainbow"
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

	-- use "tpope/vim-commentary"
	use {
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	}

	-- use "norcalli/nvim-colorizer.lua"

	use "lewis6991/gitsigns.nvim"
	use "tpope/vim-fugitive"
	use "tpope/vim-rhubarb"
	use "junegunn/gv.vim"

	use "unblevable/quick-scope"

	use {
		"ThePrimeagen/refactoring.nvim",
		requires = {
			{"nvim-lua/plenary.nvim"},
			{"nvim-treesitter/nvim-treesitter"}
		}
	}

	-- use "dstein64/vim-startuptime"
	-- use "lewis6991/impatient.nvim"
	-- use "Yggdroot/indentLine"

	-- use ({"ziontee113/color-picker.nvim",
	-- 	config = function()
	-- 		require("color-picker")
	-- 	end,
	-- })

	use "mbbill/undotree"
	use {
	  'nvim-lualine/lualine.nvim',
	  -- requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}

	-- use {
	--   'debugloop/telescope-undo.nvim',
	--   requires = { 'nvim-telescope/telescope.nvim' },
	--   config = function()
	-- 	require("telescope").load_extension("undo")
	-- 	-- optional: vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
	--   end,
	-- }



	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
