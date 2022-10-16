local ts_utils = require("nvim-lsp-ts-utils")

local function set_typescript(client, bufnr)
  -- defaults
  ts_utils.setup({})

  -- required to fix code action ranges and filter diagnostics
  ts_utils.setup_client(client)

  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lo", ":TSLspOrganize<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>li", ":TSLspImportAll<CR>:TSLspOrganize<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lrn", ":TSLspRenameFile<CR>", opts)
end

return function(opts)
  return {
    on_attach = function(client, bufnr)
      opts.on_attach(client, bufnr)

      set_typescript(client, bufnr)

      -- tsserver, stop messing with prettier da fuck!
      client.server_capabilities.document_formatting = false
      client.server_capabilities.document_range_formatting = false
    end,
  }
end
