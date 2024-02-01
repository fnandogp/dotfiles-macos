return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "smartpde/telescope-recent-files",
    "keyvchan/telescope-find-pickers.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ["<esc>"] = actions.close,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,
          },
          n = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
        },
      },
      extensions = {
        recent_files = {
          only_cwd = true,
          show_current_file = false,
        },
      },
    })

    require("telescope").load_extension("recent_files")
    require("telescope").load_extension("find_pickers")
  end,
  keys = {
    { "<leader>p", "<Cmd>Telescope find_files hidden=true<CR>", desc = "Find file" },
    { "<leader>P", "<Cmd>lua require('telescope').extensions.recent_files.pick()<CR>", desc = "Recent files" },
    { "<leader>sw", "<Cmd>Telescope live_grep<CR>", desc = "Search word" },
    { "<leader>sr", "<Cmd>Telescope resume<CR>", desc = "Resume search" },
    { "<leader>sc", "<Cmd>Telescope commands<CR>", desc = "Commands" },
    { "<leader>sh", "<Cmd>Telescope harpoon marks<CR>", desc = "Harpoon marks" },
    { "<leader>sh", "<Cmd>Telescope harpoon marks<CR>", desc = "Harpoon marks" },
    { "<leader>st", "<Cmd>Telescope find_pickers<CR>", desc = "Find Telescope pickers" },
    --LSP
    { "<Leader>gr", "<Cmd>Telescope lsp_references<CR>" },
    { "<Leader>go", "<Cmd>Telescope lsp_document_symbols<CR>" },
    { "<Leader>gO", "<Cmd>Telescope lsp_dynamic_workspace_symbols<CR>" },
    { "<Leader>gd", "<Cmd>Telescope lsp_definitions<CR>" },
    { "<Leader>gi", "<Cmd>Telescope lsp_implementations<CR>" },
    { "<Leader>gt", "<Cmd>Telescope lsp_type_definitions<CR>" },
  },
}
