return {
  { "echasnovski/mini.hipatterns", version = false, opts = {} },
  {
    "echasnovski/mini.animate",
    version = false,
    opts = { scroll = { enable = false } },
  },
  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    config = function()
      require("grug-far").setup({})
    end,
    keys = {
      { "<leader>s", "<cmd>GrugFar<CR>", desc = "Open GrugFar", mode = "n" },
      { "q", "<cmd>q<CR>", desc = "Close GrugFar", mode = "n", ft = "grug-far" },
    },
  },
  {
    "hedyhli/outline.nvim",
    cmd = { "Outline", "OutlineOpen" },
    opts = {
      symbols = { icon_source = "lspkind" },
      symbol_folding = { auto_unfold = { only = 2 } },
    },
    keys = {
      { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle Outline", mode = "n" },
    },
  },
}
