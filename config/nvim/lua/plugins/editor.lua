-- Editor enhancements: highlighting, animation, sessions, folds, search/replace,
-- code outline, tree navigation, HTTP client, zen mode and tmux pane navigation.
return {
  -- Highlights patterns like hex colours and TODO/FIXME words
  { "nvim-mini/mini.hipatterns", version = false, opts = {} },
  -- Animated cursor/window transitions; scroll animation disabled (jarring with stay-centered)
  { "nvim-mini/mini.animate", version = false, opts = { scroll = { enable = false } } },
  -- Auto save/restore sessions, scoped per git branch and to specific dirs
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
  -- Nicer folding UX; start fully unfolded (foldlevel 99)
  {
    "chrisgrieser/nvim-origami",
    event = "VeryLazy",
    init = function()
      vim.opt.foldlevel = 99
      vim.opt.foldlevelstart = 99
    end,
    opts = {},
  },
  -- Project-wide find & replace UI (buffer-based, ripgrep backed)
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
  -- Symbol/code outline sidebar (LSP symbols)
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
  -- Keeps cursor vertically centred; skipped in terminal/file-tree/chat buffers
  { "arnamak/stay-centered.nvim", opts = {
    skip_filetypes = { "toggleterm", "minifiles", "codecompanion" },
  } },
  -- Move/swap by treesitter nodes; <tab>+hjkl navigates the syntax tree
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
  -- Prettier rendering of :help / vimdoc buffers
  {
    "OXY2DEV/helpview.nvim",
    lazy = false,
    opts = {},
  },
  -- HTTP/REST client for .http files; <leader>r prefix runs requests, env scoped globally
  {
    "mistweaverco/kulala.nvim",
    ft = { "http", "rest" },
    opts = {
      global_keymaps = true,
      global_keymaps_prefix = "<leader>r",
      kulala_keymaps_prefix = "",
      kulala_keymaps = {
        ["Show verbose"] = { "!", function() require("kulala.ui").show_verbose() end },
      },
      environment_scope = "g",
      ui = {
        formatter = true,
        max_response_size = 10 * 1000 * 1000,
      },
    },
  },
  -- Distraction-free centred editing (<leader>z)
  {
    "folke/zen-mode.nvim",
    opts = {
      window = { width = 150 },
    },
    keys = {
      { "<leader>z", "<cmd>ZenMode<CR>", desc = "Toggle Zen Mode", mode = "n" },
    },
  },
  -- Seamless <c-hjkl> movement between nvim splits and tmux panes
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<c-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Navigate to left tmux pane" },
      { "<c-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Navigate to bottom tmux pane" },
      { "<c-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Navigate to top tmux pane" },
      { "<c-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Navigate to right tmux pane" },
      { "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>", desc = "Navigate to previous tmux pane" },
    },
  },
}
