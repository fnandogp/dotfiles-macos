local lsp_installer_servers = require("nvim-lsp-installer.servers")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local mappings = require("plugins.lsp.mappings")

require("plugins.lsp.handlers").lsp_handlers()

local function on_attach(client, bufnr)
  -- print(client.name)
  mappings.set_default(client, bufnr)

  -- adds beatiful icon to completion
  require("lspkind").init()

  -- add signature autocompletion while typing
  require("lsp_signature").on_attach({
    floating_window = false,
    timer_interval = 500,
  })
end

local capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

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
  sumneko_lua = require("plugins.lsp.servers.sumneko_lua")(opts),
  dockerls = {},
  omnisharp = {},
  vuels = {},
  graphql = {},
  pyright = {},
  tailwindcss = {},
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
