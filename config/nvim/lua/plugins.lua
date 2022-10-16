local packer = require("packer")

packer.startup({
  function(use)
    -- Plugin manager
    use({ "wbthomason/packer.nvim" })

    -- Optimiser
    use({ "lewis6991/impatient.nvim" })

    -- Lua functions
    use({ "nvim-lua/plenary.nvim" })

    -- Popup API
    use({ "nvim-lua/popup.nvim" })

    -- Cursorhold fix
    use({
      "antoinemadec/FixCursorHold.nvim",
      event = "BufRead",
      config = function()
        vim.g.cursorhold_updatetime = 100
      end,
    })

    -- Icons
    use("kyazdani42/nvim-web-devicons")

    -- Status line
    use({
      "nvim-lualine/lualine.nvim",
      config = function()
        require("plugins.lualine_nvim")
      end,
    })

    -- Syntax highlighting
    use({
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = function()
        require("plugins.treesitter")
      end,
      requires = {
        -- Parenthesis highlighting
        { "p00f/nvim-ts-rainbow", after = "nvim-treesitter" },
        -- Autoclose tags
        { "windwp/nvim-ts-autotag", after = "nvim-treesitter" },
        -- Context based commenting
        { "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter" },
      },
    })

    -- File Explorer
    use({
      "kyazdani42/nvim-tree.lua",
      requires = { "kyazdani42/nvim-web-devicons" },
      config = function()
        require("plugins.nvim_tree")
      end,
    })

    -- Telescope
    use({
      "nvim-telescope/telescope.nvim",
      requires = { { "nvim-lua/plenary.nvim" } },
      config = function()
        require("plugins.telescope")
      end,
    })
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

    use({
      "glepnir/dashboard-nvim",
      config = function()
        require("plugins.dashboard_nvim")
      end,
    })

    -- Color Schema
    use({ "dracula/vim", as = "dracula" })
    use({ "shaunsingh/nord.nvim" })
    use({ "folke/tokyonight.nvim" })
    use({ "morhetz/gruvbox" })

    -- Snippets Engine
    use({
      "hrsh7th/vim-vsnip",
      requires = {
        -- snippets collection
        "rafamadriz/friendly-snippets",
      },
    })

    use({
      "hrsh7th/nvim-cmp",
      config = function()
        require("plugins.nvim_cmp")
      end,
      event = "InsertEnter",
    })
    -- LSP completion source
    use({ "hrsh7th/cmp-nvim-lsp" })
    -- Buffer completion source
    use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" })
    -- Path completion source
    use({ "hrsh7th/cmp-path", after = "nvim-cmp" })

    use({ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" })
    -- Command line completion source
    use({ "hrsh7th/cmp-cmdline", after = "nvim-cmp" })
    -- Snippet completion source
    use({ "hrsh7th/cmp-vsnip", after = "nvim-cmp" })

    -- Autocomplete & Linters
    use("williamboman/nvim-lsp-installer")
    use({
      "neovim/nvim-lspconfig",
      config = function()
        require("plugins.lsp")
      end,
    })
    use("onsails/lspkind-nvim")
    --use("ray-x/lsp_signature.nvim")
    use("jose-elias-alvarez/nvim-lsp-ts-utils")

    -- Formatting and Linting
    use({
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
        require("plugins.null_ls")
      end,
    })

    use({
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("plugins.trouble_nvim")
      end,
    })

    -- Git
    use({ "tpope/vim-fugitive", cmd = { "G" } })

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
    })

    -- Terminal
    use({
      "akinsho/toggleterm.nvim",
      config = function()
        require("plugins.toggleterm_nvim")
      end,
    })

    use("rrethy/vim-illuminate")

    -- Misc
    use("tpope/vim-surround")
    use("tpope/vim-repeat")
    use("airblade/vim-rooter")
    use("machakann/vim-highlightedyank")

    use({
      "windwp/nvim-spectre",
      config = function()
        require("plugins.nvim_spectre")
      end,
    })

    use({
      "windwp/nvim-autopairs",
      after = "nvim-cmp",
      config = function()
        require("plugins.nvim_autopairs")
      end,
    })

    use("preservim/nerdcommenter")

    use({
      "folke/twilight.nvim",
      config = function()
        require("plugins.twilight_nvim")
      end,
    })

    use({
      "folke/zen-mode.nvim",
      config = function()
        require("plugins.zen_mode_nvim")
      end,
    })

    use({
      "mg979/vim-visual-multi",
    })

    --use({ "unblevable/quick-scope" })

    --use({
    --"folke/which-key.nvim",
    --config = function()
    --require("plugins.which_key_nvim")
    --end,
    --})

    use({ "andymass/vim-matchup", event = "VimEnter" })

    use({
      "lukas-reineke/indent-blankline.nvim",
      event = "BufRead",
      config = function()
        require("plugins.blankline")
      end,
    })

    use({
      "rmagatti/auto-session",
      config = function()
        require("auto-session").setup()
      end,
    })

    use({
      "chrisbra/csv.vim",
      ft = { "csv" },
    })

    use({
      "pantharshit00/vim-prisma",
    })
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
