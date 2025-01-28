return {
  { "preservim/nerdcommenter" },
  { "echasnovski/mini.pairs", version = false, opts = {} },
  { "echasnovski/mini.surround", version = false, opts = {} },
  { "echasnovski/mini.bufremove", version = false, opts = {} },
  { "echasnovski/mini.move", version = false, opts = {} },
  { "echasnovski/mini.ai", version = false, opts = {} },
  { "echasnovski/mini-git", version = false, main = "mini.git", opts = {} },
  { "echasnovski/mini.diff", version = false, opts = {} },
  { "sindrets/diffview.nvim", opts = {}, keys = {
    { "q", "<cmd>DiffviewClose<CR>", desc = "Close Diffview", mode = "n", ft = "DiffviewFiles" },
  } },
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
    "Exafunction/codeium.nvim",
    cmd = "Codeium",
    event = "InsertEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      enable_cmp_source = false,
      virtual_text = {
        enabled = true,
        manual = false,
        key_bindings = {
          -- Accept the current completion.
          accept = "<A-y>",
          -- Dismiss the current completion.
          dismiss = "<A-n>",
        },
      },
    },
  },
}
