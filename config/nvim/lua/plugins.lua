local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
    execute 'packadd packer.nvim'
end

return require('packer').startup {
  function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    -- Deps
    use 'bfredl/nvim-luadev'
    use 'kyazdani42/nvim-web-devicons'
    use  "nvim-lua/popup.nvim"
    use  "nvim-lua/plenary.nvim"
    -- Color scheme
    use { 'dracula/vim', as = 'dracula' }
    -- LSP and autocomplete
    use 'neovim/nvim-lspconfig'
    use 'kabouzeid/nvim-lspinstall'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/nvim-cmp'
    -- use 'hrsh7th/cmp-vsnip'
    -- use 'hrsh7th/vim-vsnip'
    -- use 'rafamadriz/friendly-snippets'
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use 'L3MON4D3/LuaSnip' -- Snippets plugin
    -- Post-install/update hook with neovim command
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    -- Telescope nonsense
    use { 'nvim-telescope/telescope.nvim', }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    -- Statusline
    use { 'hoob3rt/lualine.nvim' }
    -- File explorer
    use { 'kyazdani42/nvim-tree.lua' }
     -- Highlight hex codes
    use 'norcalli/nvim-colorizer.lua'
    -- Automatically insert pairs (for delimiters)
    --use 'windwp/nvim-autopairs'
    -- Git integration
    --use 'tpope/vim-fugitive'
     -- Universal way to add comments
    use 'b3nj5m1n/kommentary'
    -- Surround stuff with delimiters
    --use 'tpope/vim-surround'
    -- Snippets
    --use 'L3MON4D3/LuaSnip'
    --use 'sirver/ultisnips'
  end
}
