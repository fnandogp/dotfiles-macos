return {
  { "nvim-mini/mini.hipatterns", version = false, opts = {} },
  { "nvim-mini/mini.animate", version = false, opts = { scroll = { enable = false } } },
  {
    "olimorris/persisted.nvim",
    cmd = "SessionSelect",
    event = "VeryLazy",
    opts = {
      use_git_branch = true,
      autoload = true,
      autosave = true,
      allowed_dirs = {
        "~/.dotfiles",
        "~/workspace/",
      },
    },
    keys = { "<leader>S", "<cmd>SessionSelect<CR>", desc = "Select session" },
  },
  {
    "chrisgrieser/nvim-origami",
    event = "VeryLazy",
    init = function()
      vim.opt.foldlevel = 99
      vim.opt.foldlevelstart = 99
    end,
    opts = {},
  },
  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    opts = {},
    keys = {
      { "q", "<cmd>q<CR>", desc = "Close GrugFar", mode = "n", ft = "grug-far" },
      { "<leader>ss", "<cmd>GrugFar<CR>", desc = "Open GrugFar", mode = "n" },
      {
        "<leader>sf",
        function() require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } }) end,
        desc = "Open GrugFar limiting search/replace to current file",
        mode = "n",
      },
      {
        "<leader>sw",
        function() require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } }) end,
        desc = "Open GrugFar with the current visual selection",
        mode = "x",
      },
      {
        "<leader>sf",
        function() require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>"), paths = vim.fn.expand("%") } }) end,
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
    skip_filetypes = { "toggleterm", "minifiles", "codecompanion" },
  } },
  {
    "aaronik/treewalker.nvim",
    opts = {},
    keys = {
      { "<tab>h", "<cmd>Treewalker Left<CR>" },
      { "<tab>j", "<cmd>Treewalker Down<CR>" },
      { "<tab>k", "<cmd>Treewalker Up<CR>" },
      { "<tab>l", "<cmd>Treewalker Right<CR>" },
    },
  },
  {
    "OXY2DEV/helpview.nvim",
    lazy = false,
    opts = {},
  },
  {
    "mistweaverco/kulala.nvim",
    ft = { "http", "rest" },
    opts = {
      global_keymaps = true,
      global_keymaps_prefix = "<leader>r",
      kulala_keymaps_prefix = "",
      environment_scope = "g",
      ui = {
        formatter = true,
        max_response_size = 10 * 1000 * 1000,
      },
    },
  },
  {
    "folke/zen-mode.nvim",
    opts = {
      window = { width = 150 },
    },
    keys = {
      { "<leader>z", "<cmd>ZenMode<CR>", desc = "Toggle Zen Mode", mode = "n" },
    },
  },
}
