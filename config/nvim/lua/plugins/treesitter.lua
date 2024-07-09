return {
  "nvim-treesitter/nvim-treesitter",
  run = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-context",
    { "windwp/nvim-ts-autotag", opts = {} },
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = "all",
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      context = { enable = true },
      indent = { enable = true },
      --incremental_selection = { enable = true },
      textobjects = { enable = true },
    })
    vim.w.foldexpr = "expr"
    vim.w.foldmethod = "nvim_treesitter#foldexpr()"
    vim.w.nofoldenable = true
  end,
}
