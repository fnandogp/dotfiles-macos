local M = {}

local lspconfig = require("lspconfig")
local lspinstall = require("lspinstall")

function M.config()
	local on_attach = function(client, bufnr)
		local function buf_set_keymap(...)
			vim.api.nvim_buf_set_keymap(bufnr, ...)
		end
		local function buf_set_option(...)
			vim.api.nvim_buf_set_option(bufnr, ...)
		end

		buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
		-- Enable completion triggered by <c-x><c-o>

		-- Mappings.
		local opts = { noremap = true, silent = true }

		-- buf_set_keymap("n", "gh", "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>", opts)
		-- buf_set_keymap("n", "<Leader>ca", "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", opts)
		-- buf_set_keymap("v", "<Leader>ca", "<cmd>lua require('lspsaga.range_code_action').code_action()<CR>", opts)
		-- buf_set_keymap("n", "K", "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", opts)
		-- buf_set_keymap("n", "gs", "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>", opts)
		-- buf_set_keymap("n", "gr", "<cmd>lua require('lspsaga.rename').rename()<CR>", opts)
		-- buf_set_keymap("n", "<C-t>", "<cmd>lua require('lspsaga.floaterm').open_float_terminal()<CR>", opts)
		-- buf_set_keymap("t", "<C-t>", "<C-\\><C-n>:lua require('lspsaga.floaterm').close_float_terminal()<CR>", opts)

		buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
		buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
		buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
		buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)

		-- buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
		-- buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
		-- buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
		-- buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
		-- buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
		----buf_set_keymap('n', '<space>w', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
		----buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
		----buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
		--buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
		----buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
		----buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
		----buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
		----buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
		vim.g.completion_enable_snippet = "vim-vsnip"

		vim.g.completion_matching_smart_case = true
		vim.g.completion_trigger_on_delete = true
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
		virtual_text = false,
	})
end
-- local null_ls = require("null-ls")

-- local sources = {
-- 	null_ls.builtins.formatting.prettier,
-- 	null_ls.builtins.diagnostics.write_good,
-- 	null_ls.builtins.code_actions.gitsigns,
-- }

-- null_ls.config({
-- 	diagnostics_format = "[#{c}] #{m} (#{s})",
-- 	sources = sources,
-- })
-- require("lspconfig")["null-ls"].setup({})

return M
