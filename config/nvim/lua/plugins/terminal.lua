-- Integrated terminals via toggleterm.nvim, themed to match rose-pine.
-- <leader>t toggles a side terminal, <leader>T a floating one; tmux nav works inside.
return {
  {
    "akinsho/toggleterm.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local toggleterm = require("toggleterm")
      -- Borrow rose-pine's toggleterm highlight group so terminals match the theme
      local highlights = require("rose-pine.plugins.toggleterm")
      toggleterm.setup({
        highlights = highlights,
        -- Sizing per direction: fixed height horizontal, 40% width vertical
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

      -- Tmux navigation in toggleterm terminals
      { "<c-h>", "<C-\\><C-n>:<C-U>TmuxNavigateLeft<cr>", desc = "Navigate to left tmux pane", mode = "t", ft = "toggleterm" },
      { "<c-j>", "<C-\\><C-n>:<C-U>TmuxNavigateDown<cr>", desc = "Navigate to bottom tmux pane", mode = "t", ft = "toggleterm" },
      { "<c-k>", "<C-\\><C-n>:<C-U>TmuxNavigateUp<cr>", desc = "Navigate to top tmux pane", mode = "t", ft = "toggleterm" },
      { "<c-l>", "<C-\\><C-n>:<C-U>TmuxNavigateRight<cr>", desc = "Navigate to right tmux pane", mode = "t", ft = "toggleterm" },
      { "<c-\\>", "<C-\\><C-n>:<C-U>TmuxNavigatePrevious<cr>", desc = "Navigate to previous tmux pane", mode = "t", ft = "toggleterm" },
    },
  },
}
