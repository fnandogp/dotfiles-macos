local u = require("utils")
local lspconfig = require("lspconfig")
local lspinstall = require("lspinstall")
local lsp = vim.lsp

local M = {}

lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	signs = true,
	virtual_text = false,
})

local popup_opts = { border = "single", focusable = false }

lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, popup_opts)
lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, popup_opts)

--_G.global.lsp = {
--popup_opts = popup_opts,
--}

local on_attach = function(client, bufnr)
	vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

	u.buf_map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
	u.buf_map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
	u.buf_map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
	u.buf_map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
	u.buf_map("n", "gl", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>")
	u.buf_map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
	u.buf_map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
	--u.buf_map("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")
	--u.buf_map("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>")
	--u.buf_map("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
	u.buf_map("n", "gT", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
	u.buf_map("n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
	u.buf_map("n", "<Leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
	u.buf_map("n", "[d", "<cmd>lua vim.lsp.diagnostic.got_prev()<CR>")
	u.buf_map("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
	u.buf_map("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>")
	--u.buf_map("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>")

	client.resolved_capabilities.document_formatting = false
	client.resolved_capabilities.document_range_formatting = false
end

function M.config()
	local function setup_servers()
		lspinstall.setup()
		local servers = lspinstall.installed_servers()
		for _, server in pairs(servers) do
			lspconfig[server].setup({
				on_attach = on_attach,
			})
		end

		require("plugins.lsp.null-ls").config()

		lspconfig["null-ls"].setup({
			on_attach = on_attach,
		})
	end

	setup_servers()

	-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
	lspinstall.post_install_hook = function()
		setup_servers() -- reload installed servers
		vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
	end

	vim.cmd("autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()")
end

return M
