
vim.api.nvim_set_keymap('n', "<Leader>p", "<cmd>Telescope find_files<cr>", {silent = true})
vim.api.nvim_set_keymap('n', "<Leader>fg", "<cmd>Telescope live_grep<cr>", {silent = true})
vim.api.nvim_set_keymap('n', "<Leader>fb", "<cmd>Telescope buffers<cr>", {silent = true})

local actions = require "telescope.actions"
require("telescope").setup {
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
  },
}
