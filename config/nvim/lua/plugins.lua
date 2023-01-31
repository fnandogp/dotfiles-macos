local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	use({ "lewis6991/impatient.nvim" })

	use({
		"morhetz/gruvbox",
		config = function()
			vim.cmd("colorscheme gruvbox")
		end,
	})

	use("tpope/vim-fugitive")
	use("tpope/vim-surround")
	use("tpope/vim-sensible")
	use({ "andymass/vim-matchup", event = "VimEnter" })

	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
		},
	})

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		requires = {
			"JoosepAlviste/nvim-ts-context-commentstring",
			"windwp/nvim-ts-autotag",
		},
	})

	use({
		"nvim-tree/nvim-tree.lua",
		requires = { "nvim-tree/nvim-web-devicons" },
	})

	use({
		"VonHeikemen/lsp-zero.nvim",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },
			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
			-- linter and formatters
			{ "jose-elias-alvarez/null-ls.nvim" },
			{ "lukas-reineke/lsp-format.nvim" },
		},
	})

	use({ "RRethy/vim-illuminate" })

	use({ "folke/trouble.nvim", requires = {
		"kyazdani42/nvim-web-devicons",
	} })

	use({ "akinsho/toggleterm.nvim" })

	use({ "preservim/nerdcommenter" })

	use({ "machakann/vim-highlightedyank" })

	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
	})

	use({
		"mg979/vim-visual-multi",
	})

	if packer_bootstrap then
		require("packer").sync()
	end
end)
