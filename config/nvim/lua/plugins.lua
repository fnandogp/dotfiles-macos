local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	execute("packadd packer.nvim")
	fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
end

return require("packer").startup({
	function(use)
		-- Packer can manage itself
		use("wbthomason/packer.nvim")
		-- Deps
		use("bfredl/nvim-luadev")
		use("kyazdani42/nvim-web-devicons")
		use("nvim-lua/popup.nvim")
		use("nvim-lua/plenary.nvim")
		use({ "antoinemadec/FixCursorHold.nvim" }) -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
		-- Color scheme
		use({ "dracula/vim", as = "dracula" })
		use("morhetz/gruvbox")
		-- LSP
		use({
			"neovim/nvim-lspconfig",
			requires = {
				"kabouzeid/nvim-lspinstall",
				-- "glepnir/lspsaga.nvim",
				"onsails/lspkind-nvim",
				"nvim-lua/completion-nvim",
			},
			config = function()
				print("config plugins lsp")
				require("plugins.lsp").config()
			end,
		})
		-- Cmp

		-- use({
		-- 	"hrsh7th/cmp-nvim-lsp",
		-- 	requires = {
		-- 		{ "hrsh7th/cmp-buffer" },
		-- 		{ "hrsh7th/nvim-cmp" },
		-- 		{ "onsails/lspkind-nvim" },
		-- 		{ "hrsh7th/cmp-vsnip" },
		-- 		{ "hrsh7th/vim-vsnip" },
		-- 		{ "hrsh7th/cmp-buffer" },
		-- 		{ "hrsh7th/cmp-path" },
		-- 		{ "rafamadriz/friendly-snippets" },
		-- 	},
		-- })
		-- formatting
		-- use({
		-- 	"jose-elias-alvarez/null-ls.nvim",
		-- 	requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		-- })
		-- Treesitter
		use({
			"nvim-treesitter/nvim-treesitter",
			config = function()
				require("plugins.treesitter").config()
			end,
			run = ":TSUpdate",
		})
		-- Telescope nonsense
		use({
			"nvim-telescope/telescope.nvim",
			requires = { { "nvim-lua/plenary.nvim" } },
			config = function()
				require("plugins.telescope").config()
			end,
		})
		use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
		-- ?
		use({
			"folke/trouble.nvim",
			requires = "kyazdani42/nvim-web-devicons",
			config = function()
				require("trouble").setup({})
			end,
		})
		-- Statusline
		use({
			"hoob3rt/lualine.nvim",
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
			config = function()
				require("lualine").setup({ options = { theme = "dracula" } })
			end,
		})
		-- git signs
		use({
			"lewis6991/gitsigns.nvim",
			requires = { "nvim-lua/plenary.nvim" },
			config = function()
				require("gitsigns").setup()
			end,
		})
		-- File explorer
		use({
			"kyazdani42/nvim-tree.lua",
			requires = "kyazdani42/nvim-web-devicons",
			config = function()
				require("plugins.nvimtree").config()
			end,
		})
		-- Highlight hex codes
		use({
			"norcalli/nvim-colorizer.lua",
			config = function()
				require("colorizer").setup()
			end,
		})
		-- Automatically insert pairs (for delimiters)
		use("windwp/nvim-autopairs")
		-- Git integration
		use("tpope/vim-fugitive")
		-- Universal way to add comments
		use({
			"b3nj5m1n/kommentary",
			config = function()
				require("kommentary.config").use_extended_mappings()
			end,
		})
		-- Surround stuff with delimiters
		use("tpope/vim-surround")

		use("sheerun/vimrc")
	end,
	config = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "rounded" })
			end,
		},
	},
})
