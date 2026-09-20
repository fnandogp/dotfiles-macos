-- Treesitter syntax highlighting/indent (nvim 0.12 `main` branch API).
-- In now() so the FileType autocmd catches the buffer opened from the command line.
-- Parsers: installed once via the post_install hook, updated on every checkout.
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
  add({
    source = "nvim-treesitter/nvim-treesitter",
    checkout = "main",
    monitor = "main",
    hooks = {
      post_install = function()
        vim.cmd("packadd nvim-treesitter")
        require("nvim-treesitter").install("all")
      end,
      post_checkout = function() vim.cmd("TSUpdate") end,
    },
  })

  -- main branch no longer auto-enables: start highlighting + wire indent per buffer
  vim.api.nvim_create_autocmd("FileType", {
    callback = function()
      pcall(vim.treesitter.start)
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })
end)

later(function()
  -- Pins the enclosing scope to the top of the window
  add("nvim-treesitter/nvim-treesitter-context")
  require("treesitter-context").setup()
  -- Auto close/rename paired HTML/JSX tags
  add("windwp/nvim-ts-autotag")
  require("nvim-ts-autotag").setup()
end)
