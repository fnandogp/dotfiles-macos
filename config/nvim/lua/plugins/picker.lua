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
        caret_left = "<M-h>",
        caret_right = "<M-l>",
        move_down = "<C-j>",
        move_up = "<C-k>",
      },
    })
  end,
  keys = {
    { "<leader>p", "<cmd>Pick files<CR>", desc = "Files picker" },
    -- LSP
    { "gd", "<cmd>Pick lsp scope='definition'<CR>", desc = "Go to definition" },
    { "gD", "<cmd>Pick lsp scope='declaration'<CR>", desc = "Go to declaration" },
    { "gr", "<cmd>Pick lsp scope='references'<CR>", desc = "Go to references" },
    { "go", "<cmd>Pick lsp scope='document_symbol'<CR>", desc = "Go to document symbol" },
    { "gO", "<cmd>Pick lsp scope='workspace_symbol'<CR>", desc = "Go to workspace symbol" },
    { "gi", "<cmd>Pick lsp scope='implementation'<CR>", desc = "Go to implementation" },
    { "gt", "<cmd>Pick lsp scope='type_definition'<CR>", desc = "Go to type definition" },
  },
}
