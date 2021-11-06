local present, packer = pcall(require, 'packer_init')

if not present then return false end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return packer.startup({
	function(use)
    use({'wbthomason/packer.nvim', event = 'VimEnter'})

    use {
      'antoinemadec/FixCursorHold.nvim',
      config = function() require 'plugins.fix_cursor_hold' end
    } -- Fix CursorHold Performance

    use 'MunifTanjim/nui.nvim' -- ui library

    -- icons
    use 'kyazdani42/nvim-web-devicons'

    use { 'dracula/vim', as = "dracula" }

    use {
      'lazytanuki/nvim-mapper',
      config = function() require 'plugins.nvim_mapper' end,
      before = 'telescope.nvim'
    }

    -- telescope
    use {
      'nvim-telescope/telescope.nvim',
      requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
      config = function() require 'plugins.telescope' end
    }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}

    use {
      'kyazdani42/nvim-tree.lua',
      config = function() require 'plugins.nvim_tree' end
    }

    -- Language packs
    use {
      'nvim-treesitter/nvim-treesitter',
      config = function() require 'plugins.treesitter' end,
      run = function() vim.cmd [[TSUpdate]] end
    }

    -- Autocomplete & Linters
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/lsp-status.nvim'
    use 'tjdevries/lsp_extensions.nvim'
    use 'glepnir/lspsaga.nvim'
    use 'onsails/lspkind-nvim'
    use 'ray-x/lsp_signature.nvim'
    use 'jose-elias-alvarez/nvim-lsp-ts-utils'
    use 'williamboman/nvim-lsp-installer'

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
        config = function() require("plugins.nvim_cmp") end,
        event = "InsertEnter *",
      })

    use({
			"hoob3rt/lualine.nvim",
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
			config = function() require 'plugins.lualine' end,
		})

    use 'sheerun/vimrc'
  end
})
