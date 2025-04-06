return {
  {
    "echasnovski/mini.comment",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring", opts = { enable_autocmd = false } },
    version = false,
    opts = {
      options = {
        custom_commentstring = function() return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring end,
      },
    },
  },
  { "echasnovski/mini.pairs", version = false, opts = {} },
  { "echasnovski/mini.surround", version = false, opts = {} },
  { "echasnovski/mini.bufremove", version = false, opts = {} },
  { "echasnovski/mini.move", version = false, opts = {} },
  { "echasnovski/mini.ai", version = false, opts = {} },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    keys = {
      { "<enter>", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
  { "lewis6991/gitsigns.nvim", opts = {} },
  { "sindrets/diffview.nvim", opts = {}, keys = {
    { "q", "<cmd>DiffviewClose<CR>", desc = "Close Diffview", mode = "n", ft = "DiffviewFiles" },
  } },
  { "tpope/vim-fugitive" },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "echasnovski/mini.pick",
    },
    opts = {
      kind = "auto",
      signs = {
        --{ CLOSED, OPENED }
        hunk = { "", "" },
        item = { "▸", "▾" },
        section = { "▸", "▾" },
      },
      integrations = {
        telescope = false,
        diffview = true,
        mini_pick = true,
      },
    },
    keys = {
      { "<leader>g", "<Cmd>Neogit<CR>", desc = "Open Neogit", mode = "n" },
    },
  },
  {
    "lewis6991/hover.nvim",
    opts = {
      init = function()
        -- Require providers
        require("hover.providers.lsp")
        -- require('hover.providers.gh')
        -- require('hover.providers.gh_user')
        require("hover.providers.jira")
        -- require('hover.providers.dap')
        require("hover.providers.fold_preview")
        require("hover.providers.diagnostic")
        require("hover.providers.man")
        -- require("hover.providers.dictionary")
      end,
      preview_opts = { border = "single" },
      preview_window = false,
      title = true,
      mouse_providers = { "LSP" },
      mouse_delay = 1000,
    },
    keys = {
      { "K", function() require("hover").hover({ desc = "hover.nvim" }) end, mode = "n" },
    },
  },
}
