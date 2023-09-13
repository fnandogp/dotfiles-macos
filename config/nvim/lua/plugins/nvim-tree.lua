return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    { "nvim-tree/nvim-web-devicons" }
  },
  config = function ()
    require("nvim-tree").setup({
      reload_on_bufenter = true,
      update_focused_file = { enable = true },
      git = { enable = false },
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
    })
  end,
  keys = {
    { "<leader>e", "<Cmd>NvimTreeToggle<CR>", desc= "Explorer" }
  }
}
