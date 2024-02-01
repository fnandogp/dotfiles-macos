return {
  "nvim-pack/nvim-spectre",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {},
  keys = {
    { "<leader>sss", '<cmd>lua require("spectre").toggle()<CR>', desc = "Toggle Spectre", mode = "n" },
    { "<leader>ssw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', desc = "Search current word", mode = "n" },
    { "<leader>ssw", '<esc><cmd>lua require("spectre").open_visual()<CR>', desc = "Search current word", mode = "v" },
    { "<leader>ssp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', desc = "Search on current file", mode = "n" },
  },
}
