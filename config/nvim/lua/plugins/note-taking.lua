return {
  "epwalsh/obsidian.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "echasnovski/mini.pick",
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/Documents/Vaults/Personal/",
      },
      {
        name = "work",
        path = "~/Documents/Vaults/Work/",
      },
    },
    mappings = {
      -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- Toggle check-boxes.
      ["<leader>ch"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
      -- Smart action depending on context, either follow link or toggle checkbox.
      ["<cr>"] = {
        action = function()
          return require("obsidian").util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      },
    },
  },
  keys = {
    { "<Leader>ns", "<cmd>ObsidianSearch<CR>", desc = "Obsidian search" },
    { "<Leader>nl", "<cmd>ObsidianLinks<CR>", desc = "Obsidian links" },
    { "<Leader>nb", "<cmd>ObsidianBackLinks<CR>", desc = "Obsidian back links" },
  },
}
