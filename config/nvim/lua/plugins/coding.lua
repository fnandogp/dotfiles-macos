return {
  { "preservim/nerdcommenter" },
  { "echasnovski/mini.pairs", opts = {} },
  { "echasnovski/mini.surround", opts = {} },
  { "echasnovski/mini.bufremove", version = false, opts = {} },
  { "echasnovski/mini.move", version = false, opts = {} },
  { "echasnovski/mini.ai", version = false, opts = {} },
  { "echasnovski/mini.jump", version = "*", opts = {} },
  { "echasnovski/mini.jump2d", version = "*", opts = {} },
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
      { "<leader>g", "<Cmd>Neogit<CR>", desc = "Open Neogit", mode = "n" },
      { "<leader>G", "<Cmd>Neogit<CR>", desc = "Open Neogit", mode = "n" },
    },
  },
  { "lewis6991/gitsigns.nvim", opts = {} },
  { "echasnovski/mini.diff", version = false, opts = {} },
  {
    "Exafunction/codeium.nvim",
    cmd = "Codeium",
    event = "InsertEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("codeium").setup({
        enable_cmp_source = false,
        virtual_text = {
          enabled = true,
          manual = true,
          key_bindings = {
            -- Accept the current completion.
            accept = "<A-y>",
          },
        },
      })
    end,
  },
}
