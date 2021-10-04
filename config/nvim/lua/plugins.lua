vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require("packer").startup({
	function(use)
		-- Packer can manage itself
		use("wbthomason/packer.nvim")
		-- Deps
		use("kyazdani42/nvim-web-devicons")
		use("nvim-lua/popup.nvim")
		use("nvim-lua/plenary.nvim")
		use({ "antoinemadec/FixCursorHold.nvim" }) -- Needed while https://github.com/neovim/neovim/issues/12587 is open
		-- Color scheme
		use({ "dracula/vim", as = "dracula" })
		use("morhetz/gruvbox")
		--
		-- LSP
		use({
			"neovim/nvim-lspconfig",
			requires = {
				"kabouzeid/nvim-lspinstall",
				"onsails/lspkind-nvim",
				"jose-elias-alvarez/null-ls.nvim",
			},
			config = function()
				require("plugins.lsp").config()
			end,
		})
		--use({
		--"jose-elias-alvarez/null-ls.nvim",
		--requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		--config = function()
		--require("plugins.null-ls").config()
		--end,
		--})
		-- Cmp
		use({
			"hrsh7th/nvim-cmp",
			requires = {
				{ "hrsh7th/cmp-nvim-lsp" },
				{ "hrsh7th/cmp-buffer", after = "nvim-cmp" },
				{ "hrsh7th/cmp-path", after = "nvim-cmp" },
				{ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
				{ "hrsh7th/cmp-vsnip", after = "nvim-cmp" },
				{ "hrsh7th/vim-vsnip", after = "nvim-cmp" },
				{ "rafamadriz/friendly-snippets" },
			},
			config = function()
				require("plugins.cmp").config()
			end,
			event = "InsertEnter *",
		})
		use({
			"folke/trouble.nvim",
			requires = "kyazdani42/nvim-web-devicons",
			config = function()
				require("trouble").setup({})
			end,
		})
		-- Treesitter
		use({
			"nvim-treesitter/nvim-treesitter",
			requires = {
				"nvim-treesitter/nvim-treesitter-refactor",
				"nvim-treesitter/nvim-treesitter-textobjects",
			},
			config = function()
				require("plugins.treesitter").config()
			end,
			run = ":TSUpdate",
		})
		-- LSP diagnostics highlight
		use({
			"folke/lsp-colors.nvim",
			config = function()
				require("lsp-colors").setup({
					Error = "#db4b4b",
					Warning = "#e0af68",
					Information = "#0db9d7",
					Hint = "#10B981",
				})
			end,
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
		-- Statusline
		use({
			"hoob3rt/lualine.nvim",
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
			config = function()
				require("lualine").setup({ options = { theme = "dracula" } })
			end,
		})
		-- git signs
		--use({
		--"lewis6991/gitsigns.nvim",
		--requires = { "nvim-lua/plenary.nvim" },
		--config = function()
		--require("gitsigns").setup()
		--end,
		--})
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
		use({
			"windwp/nvim-autopairs",
			config = function()
				require("nvim-autopairs").setup()
			end,
		})
		-- Git integration
		use("tpope/vim-fugitive")
		-- Vim plugin for intensely nerdy commenting powers
		use("preservim/nerdcommenter")
		use({
			"itchyny/vim-cursorword",
			event = { "BufEnter", "BufNewFile" },
			config = function()
				require("plugins.vim-cursorword").config()
			end,
		})
		-- Surround stuff with delimiters
		use("tpope/vim-surround")
		-- Make the yanked region apparent!
		use("machakann/vim-highlightedyank")
		-- Which key
		use({
			"folke/which-key.nvim",
			config = function()
				require("plugins.which-key").config()
			end,
			event = "BufWinEnter",
		})
		use({
			"akinsho/toggleterm.nvim",
			event = "BufWinEnter",
			config = function()
				require("plugins.terminal").config()
			end,
		})
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
