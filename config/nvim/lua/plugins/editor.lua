return {
  { "echasnovski/mini.hipatterns", version = false, opts = {} },
  { "echasnovski/mini.animate", version = false, opts = { scroll = { enable = false } } },
  { "chrisgrieser/nvim-origami", event = "VeryLazy", opts = {} },
  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    opts = {},
    keys = {
      { "q", "<cmd>q<CR>", desc = "Close GrugFar", mode = "n", ft = "grug-far" },
      { "<leader>ss", "<cmd>GrugFar<CR>", desc = "Open GrugFar", mode = "n" },
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
  { "arnamak/stay-centered.nvim", opts = {
    skip_filetypes = { "toggleterm", "minifiles" },
  } },
  {
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvimtools/hydra.nvim",
    },
    opts = {},
    cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
    keys = {
      {
        mode = { "v", "n" },
        "<Leader>m",
        "<cmd>MCstart<cr>",
        desc = "Create a selection for selected text or word under the cursor",
      },
    },
  },
  {
    "ThePrimeagen/harpoon",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {},
    keys = {
      { "<leader>ha", '<cmd>lua require("harpoon.mark").add_file()<cr>', { desc = "Add harpoon mark" } },
      { "<leader>hj", '<cmd>lua require("harpoon.ui").nav_next()<cr>', { desc = "Nav to next harpoon mark" } },
      { "<leader>hk", '<cmd>lua require("harpoon.ui").nav_prev()<cr>', { desc = "Nav to prev harpoon mark" } },
      { "<leader>hh", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', { desc = "Open harpoon quick menu" } },
    },
  },
}
