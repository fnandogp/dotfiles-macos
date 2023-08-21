return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      keys = {

        { "<leader>fe", false },
        { "<leader>fE", false },
        {
          "<leader>fer",
          function()
            require("neo-tree.command").execute({ toggle = true, dir = require("lazyvim.util").get_root() })
          end,
          desc = "Explorer NeoTree (root dir)",
        },
        {
          "<leader>fec",
          function()
            require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
          end,
          desc = "Explorer NeoTree (cwd)",
        },
        { "<leader>e", "<leader>fec", desc = "Explorer NeoTree (cwd)", remap = true },
        { "<leader>E", "<leader>fer", desc = "Explorer NeoTree (root dir)", remap = true },
      },
      filesystem = {
        follow_current_file = { enabled = true },
        filtered_items = {
          visible = false,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
        },
      },
      event_handlers = {
        {
          event = "file_opened",
          handler = function()
            require("neo-tree.command").execute({ action = "close" })
          end,
        },
      },
    },
  },
}
