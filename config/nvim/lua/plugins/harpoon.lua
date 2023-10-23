return {
  "ThePrimeagen/harpoon",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {},
  keys = {
    { "<leader>ha", '<cmd>lua require("harpoon.mark").add_file()<cr>', { desc = "Add harpoon mark" } },
    { "<leader>hj", '<cmd>lua require("harpoon.ui").nav_next()<cr>', { desc = "Nav to next harpoon mark" } },
    { "<leader>hk", '<cmd>lua require("harpoon.ui").nav_prev()<cr>', { desc = "Nav to prev harpoon mark" } },
    { "<leader>hh", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', { desc = "Open harpoon quick menu" } },
  },
}
