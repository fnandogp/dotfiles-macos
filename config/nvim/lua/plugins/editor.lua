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
      { "<leader>ss", "<cmd>GrugFar<CR>", desc = "Open GrugFar", mode = "n" },
      { "q", "<cmd>q<CR>", desc = "Close GrugFar", mode = "n", ft = "grug-far" },
      {
        "<leader>sf",
        "<cmd>lua require('grug-far').open({ prefills = { paths = vim.fn.expand('%')}})<CR>",
        desc = "Open GrugFar limiting search/replace to current file",
        mode = "n",
      },
      {
        "<leader>sw",
        "<cmd>lua require('grug-far').open({ prefills = { search = vim.fn.expand('<cword>')}})<CR>",
        desc = "Open GrugFar with the current visual selection, searching only current file ",
        mode = "x",
      },
      {
        "<leader>sW",
        "<cmd>lua require('grug-far').with_visual_selection({ prefills = { paths = vim.fn.expand('%')}})<CR>",
        desc = "Open GrugFar with the current visual selection, searching only current file ",
        mode = "x",
      },
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
