return {
   {
      "nathom/filetype.nvim",
      config = function()
         vim.g.did_load_filetypes = 1
      end,
   },
   { "williamboman/nvim-lsp-installer" },
   { "tpope/vim-surround" },
   { "tpope/vim-fugitive", cmd = "G" },
   {
      "jose-elias-alvarez/null-ls.nvim",
      after = "nvim-lspconfig",
      config = function()
         require("custom.plugins.null-ls").setup()
      end,
   },
   { "jose-elias-alvarez/nvim-lsp-ts-utils" },
   { "machakann/vim-highlightedyank" },
   { "rrethy/vim-illuminate" }, -- highlight matching words when cursor on it
}
