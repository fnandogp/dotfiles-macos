return {
  -- LSP Support
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'dev-v3',
    lazy = true,
    dependencies = {
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},
        {'neovim/nvim-lspconfig',dependencies = {{'hrsh7th/cmp-nvim-lsp'},}},
        {'hrsh7th/nvim-cmp',dependencies = {{'L3MON4D3/LuaSnip'}},},
    },
    config = function()
        local lsp = require('lsp-zero').preset({})

        lsp.extend_cmp()

        lsp.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        lsp.default_keymaps({buffer = bufnr})
        end)

        require('mason').setup({})
        require('mason-lspconfig').setup({
            handlers = {
                lsp.default_setup,
                lua_ls = function()
                -- (Optional) configure lua language server
                require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
                end,
            }
        })
    end,
  },
}