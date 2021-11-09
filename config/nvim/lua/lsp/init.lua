local lsp_status = require("lsp-status")
local lsp_installer_servers = require("nvim-lsp-installer.servers")
local mappings = require("lsp.mappings")
local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

-- for debugging lsp
-- Levels by name: 'trace', 'debug', 'info', 'warn', 'error'

vim.lsp.set_log_level("error")

local function on_attach(client, bufnr)
	-- print(client.name)
	mappings.set_default(client, bufnr)
	lsp_status.on_attach(client, bufnr)

	-- adds beatiful icon to completion
	require("lspkind").init()

	-- add signature autocompletion while typing
	require("lsp_signature").on_attach({
		floating_window = false,
		timer_interval = 500,
	})
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = { spacing = 0, prefix = "■" },
	--virtual_text = false,
	signs = true,
	update_in_insert = false,
})

lsp_status.register_progress()

local capabilities = {}
capabilities = vim.tbl_extend("keep", capabilities, lsp_status.capabilities)

if cmp_nvim_lsp_ok then
	capabilities = vim.tbl_extend(
		"keep",
		capabilities,
		cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
	)
end

local default_server_config = { on_attach = on_attach, capabilities = capabilities }

local servers = {
	--efm = require('lsp.servers.efm')(),
	bashls = {},
	yamlls = {},
	jsonls = {},
	tsserver = require("lsp.servers.tsserver")(on_attach),
	html = {},
	cssls = {},
	sumneko_lua = {},
	dockerls = {},
	omnisharp = {},
	vuels = {},
	graphql = {},
	pyright = {},
}

for server_name, server_config in pairs(servers) do
	local server_available, server = lsp_installer_servers.get_server(server_name)
	if server_available then
		dump(server_name, server_available)
		server:on_ready(function()
			dump([[server_name 'ready']])
			local config = (vim.tbl_deep_extend("force", default_server_config, server_config))
			--dump(config)
			server:setup(config)
			vim.cmd([[ do User LspAttachBuffers ]])
		end)

		if not server:is_installed() then
			print("Installing " .. server_name)
			server:install()
		end
	end
end
