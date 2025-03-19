return {
  { "echasnovski/mini.comment", version = false, opts = {} },
  { "echasnovski/mini.pairs", version = false, opts = {} },
  { "echasnovski/mini.surround", version = false, opts = {} },
  { "echasnovski/mini.bufremove", version = false, opts = {} },
  { "echasnovski/mini.move", version = false, opts = {} },
  { "echasnovski/mini.ai", version = false, opts = {} },
  { "sindrets/diffview.nvim", opts = {}, keys = {
    { "q", "<cmd>DiffviewClose<CR>", desc = "Close Diffview", mode = "n", ft = "DiffviewFiles" },
  } },
  { "lewis6991/gitsigns.nvim", opts = {} },
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
}
