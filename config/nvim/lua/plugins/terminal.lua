return {
  {
    "akinsho/toggleterm.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local toggleterm = require("toggleterm")

      toggleterm.setup({
        size = function(term)
          if term.direction == "horizontal" then
            return 10
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
      })
      local Terminal = require("toggleterm.terminal").Terminal
      local lazygit = Terminal:new({
        cmd = "lazygit",
        dir = "git_dir",
        direction = "float",
        float_opts = {
          border = "double",
        },
        -- function to run on opening the terminal
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
        end,
        -- function to run on closing the terminal
        on_close = function(term)
          vim.cmd("startinsert!")
        end,
      })

      function _lazygit_toggle()
        lazygit:toggle()
      end
    end,
    keys = {
      { "<leader>t", "<cmd>1ToggleTerm size=70 direction=vertical<CR>", desc = "Side Terminal (1)" },
      { "<leader>T", "<cmd>2ToggleTerm direction=float<CR>", desc = "Floating Terminal (2)" },
      { "<leader>t", "<cmd>ToggleTerm<CR>", desc = "Close terminals", mode = "t" },
      { "<leader>G", "<cmd>lua _lazygit_toggle()<CR>", desc = "Lazygit" },
    },
  },
}
