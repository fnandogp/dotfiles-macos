return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-context",
    { "windwp/nvim-ts-autotag", opts = {} },
  },
  init = function()
    -- Enable highlighting via FileType autocmd
    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        pcall(vim.treesitter.start)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })

    -- Install all maintained parsers
    require("nvim-treesitter").install("all")

    -- Folding
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.opt.foldenable = false
  end,
}
