return {
  "nvim-treesitter/nvim-treesitter",
  run = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-context",
    "JoosepAlviste/nvim-ts-context-commentstring",
    "windwp/nvim-ts-autotag",
  },
  config = function()
    vim.g.skip_ts_context_commentstring_module = true
    require("nvim-treesitter.configs").setup({
      ensure_installed = "all",
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      autotag = { enable = true },
      context = { enable = true },
    })
    require("ts_context_commentstring").setup({ enable_autocmd = false })
  end,
}
