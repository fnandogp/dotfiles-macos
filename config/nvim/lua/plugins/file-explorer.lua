return {
  "stevearc/oil.nvim",
  opts = {
    view_options = {
      show_hidden = false,
    },
  },
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>e", "<Cmd>Oil<CR>", desc = "Explorer" },
  },
}
