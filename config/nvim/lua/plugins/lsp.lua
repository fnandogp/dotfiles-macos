local M = {}

local lspconfig = require("lspconfig")
local lspinstall = require("lspinstall")

function M.config()
	local on_attach = function(client, bufnr)
		local function buf_set_keymap(mode, lhs, rhs)
			local opts = { noremap = true, silent = true }
			vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
		end
		local function buf_set_option(...)
			vim.api.nvim_buf_set_option(bufnr, ...)
		end

		-- Enable completion triggered by <c-x><c-o>
		buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

		-- See `:help vim.lsp.*` for documentation on any of the below functions
		buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
		buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
		buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
		buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
		buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
		buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
		buf_set_keymap("n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
		buf_set_keymap("n", "gl", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>")
		--buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")
		--buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>")
		--buf_set_keymap("n", "<space>wl", "<cmd>lua prnt(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
		--buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
		--buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
		--buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
		buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
		buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
	end

	local function setup_servers()
		lspinstall.setup()
		local servers = lspinstall.installed_servers()
		for _, server in pairs(servers) do
			lspconfig[server].setup({
				on_attach = on_attach,
			})
		end
	end

	setup_servers()

	-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
	lspinstall.post_install_hook = function()
		setup_servers() -- reload installed servers
		vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
	end

	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		--virtual_text = false,
	})

	vim.cmd("autocmd BufWritePre * :silent lua vim.lsp.buf.formatting_sync()")
end

return M
