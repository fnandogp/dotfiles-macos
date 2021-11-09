local ts_utils = require("nvim-lsp-ts-utils")

local function set_typescript(client, bufnr)
	local function buf_set_keymap(...)
		bufnoremap(bufnr, ...)
	end
	-- defaults
	ts_utils.setup({})

	-- required to fix code action ranges and filter diagnostics
	ts_utils.setup_client(client)

	buf_set_keymap("n", "<leader>loi", ":TSLspOrganize<CR>", "lsp", "lsp_typescript_organize", "Organize imports")
	buf_set_keymap("n", "<leader>lfc", ":TSLspFixCurrent<CR>", "lsp", "lsp_typescript_fix_current", "Fix current")
	-- buf_set_keymap("n", "gr", ":TSLspRenameFile<CR>", 'lsp', 'lsp_', '')
	buf_set_keymap("n", "<leader>lia", ":TSLspImportAll<CR>", "lsp", "lsp_typescript_import_all", "Import all")
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
