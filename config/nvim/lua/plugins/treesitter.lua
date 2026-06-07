-- Treesitter syntax highlighting/indent (nvim 0.12 `main` branch API).
-- Adds sticky context window and auto close/rename of HTML/JSX tags.
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-context", -- pins the enclosing scope to the top of the window
    { "windwp/nvim-ts-autotag", opts = {} }, -- auto close/rename paired tags
  },
  init = function()
    -- main branch no longer auto-enables: start highlighting + wire indent per buffer
    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        pcall(vim.treesitter.start)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })

    -- Install all maintained parsers
    require("nvim-treesitter").install("all")
  end,
}
