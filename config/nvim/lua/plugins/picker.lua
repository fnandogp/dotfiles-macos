return {
  "nvim-mini/mini.pick",
  lazy = false,
  version = "*",
  dependencies = {
    { "nvim-mini/mini.extra", version = false, opts = {} },
  },
  opts = {
    mappings = {
      caret_left = "<M-h>",
      caret_right = "<M-l>",
      move_down = "<C-j>",
      move_up = "<C-k>",
      scroll_down = "<C-d>",
      scroll_up = "<C-u>",
    },
    window = { config = { width = vim.o.columns } },
  },
  config = function(_, opts)
    local MiniPick = require("mini.pick")
    MiniPick.setup(opts)
    vim.ui.select = MiniPick.ui_select

    -- LSP default mappings are conflicting with this so we remove them
    vim.keymap.del("n", "grn")
    vim.keymap.del("n", "grr")
    vim.keymap.del({ "n", "x" }, "gra")
    vim.keymap.del("n", "grt")
    vim.keymap.del("n", "gri")

    local original_paste = vim.paste
    vim.paste = function(...)
      if not MiniPick.is_picker_active() then return original_paste(...) end
      -- Encountered inconsistent register values after copying from host machine
      -- Could add more, please check `Pick registers` on strategic times to inspect state
      for _, reg in ipairs({ "+", ".", "*" }) do
        local content = vim.fn.getreg(reg) or ""
        if content ~= "" then return MiniPick.set_picker_query({ content }) end
      end
      -- Yes, I know about <C-r>, will suppress that message, but show \something\ for feedback reasons
      vim.notify("No content to paste", vim.log.levels.WARN)
    end
  end,
  keys = {
    { "<leader>p", "<cmd>Pick files<CR>", desc = "Files picker" },
    { "<leader>P", "<cmd>Pick visit_paths<CR>", desc = "Visited paths" },
    { "<leader>f", "<cmd>Pick grep_live<CR>", desc = "Grep live" },
    -- LSP
    { "gd", "<cmd>Pick lsp scope='definition'<CR>", desc = "Go to definition" },
    { "gD", "<cmd>Pick lsp scope='declaration'<CR>", desc = "Go to declaration" },
    { "gr", "<cmd>Pick lsp scope='references'<CR>", desc = "Go to references", { nowait = true } },
    { "go", function() require("mini.extra").pickers.lsp({ scope = "document_symbol" }) end, desc = "Go to document symbol" },
    -- { "gO", "<cmd>Pick lsp scope='document_symbol'<CR>", desc = "Go to document symbol" },
    { "gw", function() require("mini.extra").pickers.lsp({ scope = "workspace_symbol" }) end, desc = "Go to document symbol" },
    -- { "gW", "<cmd>Pick lsp scope='workspace_symbol'<CR>", desc = "Go to workspace symbol" },
    { "gi", "<cmd>Pick lsp scope='implementation'<CR>", desc = "Go to implementation" },
    { "gt", "<cmd>Pick lsp scope='type_definition'<CR>", desc = "Go to type definition" },
    { "gL", "<cmd>Pick diagnostic<cr>", desc = "List diagnostics" },
    { "<command-v>", "<C-r>*<C-r>+", desc = "Paste from clipboard", ft = "minipick" },
  },
}
