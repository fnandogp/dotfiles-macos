return {
  { "preservim/nerdcommenter" },
  { "echasnovski/mini.pairs", opts = {} },
  { "echasnovski/mini.surround", opts = {} },
  { "echasnovski/mini.bufremove", version = false, opts = {} },
  { "echasnovski/mini.move", version = false, opts = {} },
  { "echasnovski/mini.ai", version = false, opts = {} },
  { "tpope/vim-fugitive" },
  {
    "sindrets/diffview.nvim",
    opts = {},
  },
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
