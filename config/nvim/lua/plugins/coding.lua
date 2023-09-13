return {
  { "preservim/nerdcommenter" },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
        },
      })
    end,
  },
  { "echasnovski/mini.pairs", opts = {} },
  { "echasnovski/mini.surround", opts = {} },
  { "tpope/vim-fugitive" },
}
