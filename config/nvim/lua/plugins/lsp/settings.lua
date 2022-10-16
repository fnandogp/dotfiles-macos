local lsp_installer_servers = require("nvim-lsp-installer.servers")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local mappings = require("plugins.lsp.mappings")

require("plugins.lsp.handlers").lsp_handlers()

local function on_attach(client, bufnr)
  mappings.set_default(client, bufnr)

  -- adds beatiful icon to completion
  require("lspkind").init()

  -- adds highlight for word under cursor
  require("illuminate").on_attach(client)
end

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = cmp_nvim_lsp.default_capabilities()

local opts = {
  on_attach = on_attach,
  capabilities = capabilities,
}
local servers = {
  bashls = {},
  yamlls = {},
  jsonls = require("plugins.lsp.servers.jsonls")(opts),
  tsserver = require("plugins.lsp.servers.tsserver")(opts),
  html = {},
  cssls = {},
  emmet_ls = require("plugins.lsp.servers.emmet")(opts),
  sumneko_lua = require("plugins.lsp.servers.sumneko_lua")(opts),
  dockerls = {},
  vuels = {},
  graphql = {},
  pyright = {},
  tailwindcss = {},
  intelephense = require("plugins.lsp.servers.intelephense")(opts),
}

for server_name, server_opts in pairs(servers) do
  local server_available, server = lsp_installer_servers.get_server(server_name)
  if server_available then
    server:on_ready(function()
      local config = (vim.tbl_deep_extend("force", opts, server_opts))
      server:setup(config)
    end)

    if not server:is_installed() then
      print("Installing " .. server_name)
      server:install()
    end
  end
end
