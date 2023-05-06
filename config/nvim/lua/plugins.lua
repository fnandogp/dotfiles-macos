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
	use("nvim-lua/plenary.nvim")
	use("lewis6991/impatient.nvim")

	use({
		"catppuccin/nvim",
		as = "catppuccin",
		config = function()
			vim.cmd("colorscheme catppuccin-latte")
		end,
	})

	use("tpope/vim-fugitive")
	use("tpope/vim-surround")
	use("tpope/vim-sensible")
	use({ "andymass/vim-matchup", event = "VimEnter" })

	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = { { "nvim-telescope/telescope-fzf-native.nvim", run = "make" } },
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
		branch = "v2.x",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{
				"williamboman/mason.nvim",
				run = function()
					pcall(vim.cmd, "MasonUpdate")
				end,
			},
			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
			{ "jose-elias-alvarez/null-ls.nvim" },
			{ "onsails/lspkind.nvim" },
		},
	})

	use({
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				panel = { auto_refresh = true },
				suggestion = { auto_trigger = true },
			})
		end,
	})

	use({ "RRethy/vim-illuminate" })

	use({
		"folke/trouble.nvim",
		requires = {
			"kyazdani42/nvim-web-devicons",
		},
	})

	use({ "akinsho/toggleterm.nvim" })

	use({ "preservim/nerdcommenter" })

	use({ "machakann/vim-highlightedyank" })

	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
	})

	use({ "mg979/vim-visual-multi" })

	use({ "ThePrimeagen/harpoon" })

	if packer_bootstrap then
		require("packer").sync()
	end
end)
