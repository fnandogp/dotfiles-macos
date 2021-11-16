local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap = false

if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local packer = require("packer")

packer.startup({
	function(use)
		use({ "wbthomason/packer.nvim" })

		use({
			"antoinemadec/FixCursorHold.nvim",
			config = function()
				require("plugins.fix_cursor_hold")
			end,
		}) -- Fix CursorHold Performance

		-- icons
		use("kyazdani42/nvim-web-devicons")

		use({ "dracula/vim", as = "dracula" })

		use({
			"goolord/alpha-nvim",
			requires = { "kyazdani42/nvim-web-devicons" },

			config = function()
				require("plugins.alpha_nvim")
			end,
		})
		-- telescope
		use({
			"nvim-telescope/telescope.nvim",
			requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
			config = function()
				require("plugins.telescope")
			end,
		})
		use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

		use({
			"kyazdani42/nvim-tree.lua",
			config = function()
				require("plugins.nvim_tree")
			end,
		})

		-- Language packs
		use({
			"nvim-treesitter/nvim-treesitter",
			config = function()
				require("plugins.treesitter")
			end,
			run = function()
				vim.cmd([[TSUpdate]])
			end,
		})

		use({
			"SmiteshP/nvim-gps",
			config = function()
				require("plugins.nvim_gps")
			end,
		}) -- Simple statusline component that shows what scope you are working inside

		use({
			"folke/twilight.nvim",
			config = function()
				require("plugins.twilight_nvim")
			end,
		})
		-- Autocomplete & Linters
		use("neovim/nvim-lspconfig")
		use("nvim-lua/lsp-status.nvim")
		use("glepnir/lspsaga.nvim")
		use("onsails/lspkind-nvim")
		use("ray-x/lsp_signature.nvim")
		use("jose-elias-alvarez/nvim-lsp-ts-utils")
		use("williamboman/nvim-lsp-installer")

		use({
			"hrsh7th/nvim-cmp",
			requires = {
				{ "hrsh7th/cmp-nvim-lsp" },
				{ "hrsh7th/cmp-buffer", after = "nvim-cmp" },
				{ "hrsh7th/cmp-path", after = "nvim-cmp" },
				{ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
				{ "hrsh7th/cmp-vsnip", after = "nvim-cmp" },
				{ "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
				{ "hrsh7th/vim-vsnip", after = "nvim-cmp" },
				{ "rafamadriz/friendly-snippets" },
			},
			config = function()
				require("plugins.nvim_cmp")
			end,
			event = "InsertEnter *",
		})

		use({
			"jose-elias-alvarez/null-ls.nvim",
			requires = {
				{ "nvim-lua/plenary.nvim" },
				{ "neovim/nvim-lspconfig" },
			},
			config = function()
				require("plugins.null_ls")
			end,
		})

		-- Status line
		use({
			"hoob3rt/lualine.nvim",
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
			config = function()
				require("plugins.lualine_nvim")
			end,
		})

		-- Git
		use({
			"tpope/vim-fugitive",
			config = function()
				require("plugins.fugitive")
			end,
		})
		use({
			"lewis6991/gitsigns.nvim",
			config = function()
				require("plugins.gitsigns_nvim")
			end,
		})

		use({
			"norcalli/nvim-colorizer.lua",
			config = function()
				require("plugins.nvim_colorizer")
			end,
		}) -- preview hex colors

		use({
			"akinsho/toggleterm.nvim",
			config = function()
				require("plugins.toggleterm_nvim")
			end,
		}) -- A neovim lua plugin to help easily manage multiple terminal windows

		use("rrethy/vim-illuminate") -- highlight matching words when cursor on it

		-- Misc
		use("tpope/vim-surround")
		use("tpope/vim-repeat")
		use("tpope/vim-dispatch")
		use("airblade/vim-rooter")
		use("machakann/vim-highlightedyank")

		use({
			"windwp/nvim-autopairs",
			after = "nvim-cmp",
			config = function()
				require("plugins.nvim_autopairs")
			end,
		})

		use("preservim/nerdcommenter")

		use({
			"folke/zen-mode.nvim",
			config = function()
				require("plugins.zen_mode_nvim")
			end,
		}) -- Clean and elegant distraction-free writing for NeoVim

		use("sheerun/vimrc")

		-- Automatically set up your configuration after cloning packer.nvim
		if packer_bootstrap then
			packer.sync()
		end
	end,
	config = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "single" })
			end,
			prompt_border = "single",
		},
	},
})
