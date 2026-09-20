-- Fuzzy finder: mini.pick (+ mini.extra pickers, mini.visits for frecency).
-- Wires vim.ui.select to MiniPick so all selection prompts use the picker.
local later = MiniDeps.later

later(function()
  require("mini.extra").setup()

  local MiniPick = require("mini.pick")
  MiniPick.setup({
    mappings = {
      -- Move caret within the query; <M-h>/<M-l> instead of arrows
      caret_left = "<M-h>",
      caret_right = "<M-l>",
      scroll_down = "<C-d>",
      scroll_up = "<C-u>",
      delete_left = "", -- Disabled: default <C-u> collides with scroll_up; <BS>/<C-w> cover deletion
    },
    -- Full-width picker window; callable so it tracks terminal resizes
    window = { config = function() return { width = vim.o.columns } end },
  })
  -- Route every vim.ui.select prompt (code actions, etc.) through mini.pick
  vim.ui.select = MiniPick.ui_select

  -- Override vim.paste so OS paste inside the picker fills the query.
  -- Falls back to the original paste handler when no picker is open.
  local original_paste = vim.paste
  vim.paste = function(...)
    if not MiniPick.is_picker_active() then return original_paste(...) end
    -- Register contents can be inconsistent after copying from the host machine, so try several
    for _, reg in ipairs({ "+", ".", "*" }) do
      local content = vim.fn.getreg(reg) or ""
      if content ~= "" then return MiniPick.set_picker_query({ content }) end
    end
    vim.notify("No content to paste", vim.log.levels.WARN)
  end

  local map = vim.keymap.set
  map("n", "<leader>p", "<cmd>Pick files<CR>", { desc = "Files picker" })
  -- visit_paths: frecency-ranked recent files (via mini.visits)
  map("n", "<leader>P", "<cmd>Pick visit_paths<CR>", { desc = "Visited paths" })
  map("n", "<leader>f", "<cmd>Pick grep_live<CR>", { desc = "Grep live" })
  -- LSP (override defaults with picker)
  map("n", "gd", "<cmd>Pick lsp scope='definition'<CR>", { desc = "Go to definition" })
  map("n", "gD", "<cmd>Pick lsp scope='declaration'<CR>", { desc = "Go to declaration" })
  map("n", "grr", "<cmd>Pick lsp scope='references'<CR>", { desc = "Go to references" })
  map("n", "gri", "<cmd>Pick lsp scope='implementation'<CR>", { desc = "Go to implementation" })
  map("n", "grt", "<cmd>Pick lsp scope='type_definition'<CR>", { desc = "Go to type definition" })
  map("n", "gO", function() require("mini.extra").pickers.lsp({ scope = "document_symbol" }) end, { desc = "Go to document symbol" })
  -- Extra (no default equivalent)
  map("n", "gw", function() require("mini.extra").pickers.lsp({ scope = "workspace_symbol" }) end, { desc = "Go to workspace symbol" })
  map("n", "gL", "<cmd>Pick diagnostic<cr>", { desc = "List diagnostics" })
end)
