-- Integrated terminals via toggleterm.nvim, themed via catppuccin's toggleterm integration.
-- <leader>t toggles a side terminal, <leader>T a floating one; tmux nav works inside.
local add, later = MiniDeps.add, MiniDeps.later

later(function()
  add("akinsho/toggleterm.nvim")
  -- rose-pine alternative: pass `highlights = require("rose-pine.plugins.toggleterm")`
  require("toggleterm").setup({
    -- Sizing per direction: fixed height horizontal, 40% width vertical
    size = function(term)
      if term.direction == "horizontal" then
        return 10
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
  })

  vim.keymap.set("n", "<leader>t", "<cmd>1ToggleTerm size=100 direction=vertical<CR>", { desc = "Side Terminal (1)" })
  vim.keymap.set("n", "<leader>T", "<cmd>2ToggleTerm direction=float<CR>", { desc = "Floating Terminal (2)" })

  -- Buffer-local keys inside toggleterm buffers: close, and tmux navigation from terminal mode
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "toggleterm",
    callback = function(args)
      local function map(mode, lhs, rhs, desc) vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, desc = desc }) end
      map({ "n", "t" }, "<leader>t", "<cmd>ToggleTerm<CR>", "Close terminals")
      map("n", "q", "<cmd>ToggleTerm close<CR>", "Close Terminal")
      map("t", "<c-h>", "<C-\\><C-n>:<C-U>TmuxNavigateLeft<cr>", "Navigate to left tmux pane")
      map("t", "<c-j>", "<C-\\><C-n>:<C-U>TmuxNavigateDown<cr>", "Navigate to bottom tmux pane")
      map("t", "<c-k>", "<C-\\><C-n>:<C-U>TmuxNavigateUp<cr>", "Navigate to top tmux pane")
      map("t", "<c-l>", "<C-\\><C-n>:<C-U>TmuxNavigateRight<cr>", "Navigate to right tmux pane")
      map("t", "<c-\\>", "<C-\\><C-n>:<C-U>TmuxNavigatePrevious<cr>", "Navigate to previous tmux pane")
    end,
  })
end)
