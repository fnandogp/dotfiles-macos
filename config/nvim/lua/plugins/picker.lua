return {
  "echasnovski/mini.pick",
  lazy = false,
  version = "*",
  dependencies = {
    { "echasnovski/mini.extra", version = false, opts = {} },
    { "echasnovski/mini.visits", version = false, opts = {} },
  },
  opts = {
    mappings = {
      caret_left = "<M-h>",
      caret_right = "<M-l>",
      move_down = "<C-j>",
      move_up = "<C-k>",
    },
  },
  config = function(_, opts)
    local MiniPick = require("mini.pick")
    MiniPick.setup(opts)
    vim.ui.select = MiniPick.ui_select

    -- LSP default mappings are conflicting with this so we remove them
    vim.keymap.del("n", "grn")
    vim.keymap.del("n", "grr")
    vim.keymap.del("n", "gra")
    vim.keymap.del("n", "gri")
  end,
  keys = {
    { "<leader>p", "<cmd>Pick files<CR>", desc = "Files picker" },
    { "<leader>P", "<cmd>Pick visit_paths<CR>", desc = "Visited paths" },
    { "<leader>F", "<cmd>Pick grep_live<CR>", desc = "Grep live" },
    -- LSP
    { "gd", "<cmd>Pick lsp scope='definition'<CR>", desc = "Go to definition" },
    { "gD", "<cmd>Pick lsp scope='declaration'<CR>", desc = "Go to declaration" },
    { "gr", "<cmd>Pick lsp scope='references'<CR>", desc = "Go to references", { nowait = true } },
    { "go", "<cmd>Pick lsp scope='document_symbol'<CR>", desc = "Go to document symbol" },
    { "gO", "<cmd>Pick lsp scope='workspace_symbol'<CR>", desc = "Go to workspace symbol" },
    { "gi", "<cmd>Pick lsp scope='implementation'<CR>", desc = "Go to implementation" },
    { "gt", "<cmd>Pick lsp scope='type_definition'<CR>", desc = "Go to type definition" },
    { "gL", "<cmd>Pick diagnostic<cr>", desc = "List diagnostics" },
  },
}
