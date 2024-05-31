return {
  --{
  --"catppuccin/nvim",
  --lazy = false, -- make sure we load this during startup if it is your main colorscheme
  --priority = 1000, -- make sure to load this before all the other start plugins
  --config = function()
  --vim.cmd([[colorscheme catppuccin-latte]])
  --end,
  --},
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        light_style = "day",
      })
      vim.cmd([[colorscheme tokyonight-day]])
    end,
  },
}
