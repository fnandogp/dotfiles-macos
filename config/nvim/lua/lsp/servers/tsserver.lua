local ts_utils = require("nvim-lsp-ts-utils")

local function set_typescript(client, bufnr)
	-- defaults
	ts_utils.setup({})

	-- required to fix code action ranges and filter diagnostics
	ts_utils.setup_client(client)

	local opts = { silent = true }
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", opts)
end

return function(on_attach)
	return {
		on_attach = function(client, bufnr)
			on_attach(client, bufnr)

			set_typescript(client, bufnr)

			-- tsserver, stop messing with prettier da fuck!
			client.resolved_capabilities.document_formatting = false
			client.resolved_capabilities.document_range_formatting = false
		end,
	}
end
