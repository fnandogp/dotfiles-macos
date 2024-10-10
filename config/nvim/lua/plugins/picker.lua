return {
  "echasnovski/mini.pick",
  version = "*",
  dependencies = {
    { "echasnovski/mini.extra", version = false, opts = {} },
    { "echasnovski/mini.visits", version = false, opts = {} },
  },
  config = function()
    require("mini.pick").setup({
      mappings = {
        move_down = "<C-j>",
        move_up = "<C-k>",
      },
    })
  end,
  keys = {
    { "<leader>p", "<cmd>Pick files<cr>", desc = "Files picker" },
  },
}
