		lspconfig.diagnosticls.setup({
			on_attach = on_attach,
			filetypes = {
				"javascript",
				"javascriptreact",
				"json",
				"typescript",
				"typescriptreact",
				"css",
				"less",
				"scss",
			},
			init_options = {
				linters = {
					eslint = {
						command = "eslint_d",
						rootPatterns = { ".git" },
						debounce = 100,
						args = { "--stdin", "--stdin-filename", "%filepath", "--format", "json" },
						sourceName = "eslint_d",
						parseJson = {
							errorsRoot = "[0].messages",
							line = "line",
							column = "column",
							endLine = "endLine",
							endColumn = "endColumn",
							message = "[eslint] ${message} [${ruleId}]",
							security = "severity",
						},
						securities = {
							[2] = "error",
							[1] = "warning",
						},
					},
				},
				filetypes = {
					javascript = "eslint",
					javascriptreact = "eslint",
					typescript = "eslint",
					typescriptreact = "eslint",
				},
				formatters = {
					eslint_d = {
						command = "eslint_d",
						args = { "--stdin", "--stdin-filename", "%filename", "--fix-to-stdout" },
						rootPatterns = { ".git" },
					},
					prettier = {
						command = "prettier",
						args = { "--stdin-filepath", "%filename" },
					},
				},
				formatFiletypes = {
					css = "prettier",
					javascript = "eslint_d",
					javascriptreact = "eslint_d",
					json = "prettier",
					scss = "prettier",
					less = "prettier",
					typescript = "eslint_d",
					typescriptreact = "eslint_d",
					json = "prettier",
					markdown = "prettier",
				},
			},
		})

		-- icon
		vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
			underline = true,
			-- This sets the spacing and the prefix, obviously.
			virtual_text = {
				spacing = 4,
				prefix = "",
			},
		})

	u.lua_command("LspFormatting", "vim.lsp.buf.formatting()")
    u.lua_command("LspHover", "vim.lsp.buf.hover()")
    u.lua_command("LspRename", "vim.lsp.buf.rename()")
    u.lua_command("LspDiagPrev", "vim.lsp.diagnostic.goto_prev({ popup_opts = global.lsp.popup_opts })")
    u.lua_command("LspDiagNext", "vim.lsp.diagnostic.goto_next({ popup_opts = global.lsp.popup_opts })")
    u.lua_command("LspDiagLine", "vim.lsp.diagnostic.show_line_diagnostics(global.lsp.popup_opts)")
    u.lua_command("LspSignatureHelp", "vim.lsp.buf.signature_help()")
    u.lua_command("LspTypeDef", "vim.lsp.buf.type_definition()")

    -- bindings
    u.buf_map("n", "gi", ":LspRename<CR>", nil, bufnr)
    u.buf_map("n", "gy", ":LspTypeDef<CR>", nil, bufnr)
    u.buf_map("n", "K", ":LspHover<CR>", nil, bufnr)
    u.buf_map("n", "[a", ":LspDiagPrev<CR>", nil, bufnr)
    u.buf_map("n", "]a", ":LspDiagNext<CR>", nil, bufnr)
    u.buf_map("n", "<Leader>a", ":LspDiagLine<CR>", nil, bufnr)
    u.buf_map("i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>", nil, bufnr)

    -- telescope
    u.buf_map("n", "gr", ":LspRef<CR>", nil, bufnr)
    u.buf_map("n", "gd", ":LspDef<CR>", nil, bufnr)
    u.buf_map("n", "ga", ":LspAct<CR>", nil, bufnr)

    if client.resolved_capabilities.document_formatting then
        u.buf_augroup("LspFormatOnSave", "BufWritePre", "lua vim.lsp.buf.formatting_sync()")
    end
