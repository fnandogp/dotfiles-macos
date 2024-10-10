return {
  { "preservim/nerdcommenter" },
  { "echasnovski/mini.pairs", opts = {} },
  { "echasnovski/mini.surround", opts = {} },
  { "echasnovski/mini.bufremove", version = false, opts = {} },
  { "echasnovski/mini.move", version = false, opts = {} },
  { "echasnovski/mini.ai", version = false, opts = {} },
  { "tpope/vim-fugitive" },
  { "sindrets/diffview.nvim", opts = {} },
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
      { "<leader>G", "<Cmd>Neogit<CR>", desc = "Open Neogit", mode = "n" },
    },
  },
  { "lewis6991/gitsigns.nvim", opts = {} },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = { accept = "<M-y>" },
        },
      })
    end,
  },
}
