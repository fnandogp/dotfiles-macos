local ts_utils = require "nvim-lsp-ts-utils"

local function set_typescript(client, bufnr)
   -- defaults
   ts_utils.setup {}

   -- required to fix code action ranges and filter diagnostics
   ts_utils.setup_client(client)

   local opts = { silent = true }
   vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lo", ":TSLspOrganize<CR>", opts)
   vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>li", ":TSLspImportAll<CR>:TSLspOrganize<CR>", opts)
end

return function(attach)
   return function(client, bufnr)
      attach(client, bufnr)

      set_typescript(client, bufnr)

      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
   end
end
