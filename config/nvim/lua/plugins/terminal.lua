return {
  {
    "akinsho/toggleterm.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local toggleterm = require("toggleterm")
      local highlights = require("rose-pine.plugins.toggleterm")
      toggleterm.setup({
        highlights = highlights,
        size = function(term)
          if term.direction == "horizontal" then
            return 10
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
      })
    end,
    keys = {
      { "<leader>t", "<cmd>1ToggleTerm size=70 direction=vertical<CR>", desc = "Side Terminal (1)" },
      { "<leader>T", "<cmd>2ToggleTerm direction=float<CR>", desc = "Floating Terminal (2)" },
      { "<leader>t", "<cmd>ToggleTerm<CR>", desc = "Close terminals", mode = { "n", "t" }, ft = "toggleterm" },
      { "q", "<cmd>ToggleTerm close<CR>", desc = "Close Terminal", mode = { "n" }, ft = "toggleterm" },
    },
  },
}
