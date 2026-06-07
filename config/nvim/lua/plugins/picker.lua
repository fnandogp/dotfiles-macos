-- Fuzzy finder: mini.pick (+ mini.extra pickers, mini.visits for frecency).
-- Wires vim.ui.select to MiniPick so all selection prompts use the picker.
return {
  {
    "nvim-mini/mini.pick",
    lazy = false,
    version = "*",
    dependencies = {
      { "nvim-mini/mini.visits" },
      { "nvim-mini/mini.extra", version = false, opts = {} },
    },
    opts = {
      mappings = {
        -- Move caret within the query; <M-h>/<M-l> instead of arrows
        caret_left = "<M-h>",
        caret_right = "<M-l>",
        scroll_down = "<C-d>",
        scroll_up = "<C-u>",
      },
      -- Full-width picker window
      window = { config = { width = vim.o.columns } },
    },
    config = function(_, opts)
      local MiniPick = require("mini.pick")
      MiniPick.setup(opts)
      -- Route every vim.ui.select prompt (code actions, etc.) through mini.pick
      vim.ui.select = MiniPick.ui_select

      -- Override vim.paste so OS paste inside the picker fills the query.
      -- Falls back to the original paste handler when no picker is open.
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
      -- visit_paths: frecency-ranked recent files (via mini.visits)
      { "<leader>P", "<cmd>Pick visit_paths<CR>", desc = "Visited paths" },
      { "<leader>f", "<cmd>Pick grep_live<CR>", desc = "Grep live" },
      -- LSP (override defaults with picker)
      { "gd", "<cmd>Pick lsp scope='definition'<CR>", desc = "Go to definition" },
      { "gD", "<cmd>Pick lsp scope='declaration'<CR>", desc = "Go to declaration" },
      { "grr", "<cmd>Pick lsp scope='references'<CR>", desc = "Go to references" },
      { "gri", "<cmd>Pick lsp scope='implementation'<CR>", desc = "Go to implementation" },
      { "grt", "<cmd>Pick lsp scope='type_definition'<CR>", desc = "Go to type definition" },
      { "gO", function() require("mini.extra").pickers.lsp({ scope = "document_symbol" }) end, desc = "Go to document symbol" },
      -- Extra (no default equivalent)
      { "gw", function() require("mini.extra").pickers.lsp({ scope = "workspace_symbol" }) end, desc = "Go to workspace symbol" },
      { "gL", "<cmd>Pick diagnostic<cr>", desc = "List diagnostics" },
      -- Cmd+V inside the picker buffer: insert both * and + registers
      { "<command-v>", "<C-r>*<C-r>+", desc = "Paste from clipboard", ft = "minipick" },
    },
  },
}
