local M = {}

M.setup_lsp = function(attach, capabilities)
   local lsp_installer = require "nvim-lsp-installer"

   lsp_installer.settings {
      ui = {
         icons = {
            server_installed = "﫟",
            server_pending = "",
            server_uninstalled = "✗",
         },
      },
   }

   lsp_installer.on_server_ready(function(server)
      local opts = {
         on_attach = attach,
         capabilities = capabilities,
         flags = {
            debounce_text_changes = 150,
         },
         settings = {},
      }
      -- basic example to edit lsp server's options, disabling tsserver's inbuilt formatter
      if server.name == "tsserver" then
         opts.on_attach = require "custom.lsp.tsserver"(attach)
      end

      server:setup(opts)
      vim.cmd [[ do User LspAttachBuffers ]]
   end)
end

return M