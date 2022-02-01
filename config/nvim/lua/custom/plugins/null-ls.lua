local null_ls = require "null-ls"
local b = null_ls.builtins

local sources = {
   -- global
   b.formatting.trim_whitespace,
   b.code_actions.gitsigns,
   -- lua
   b.formatting.stylua,
   b.diagnostics.luacheck.with { extra_args = { "--global vim" } },
   -- js / ts
   b.diagnostics.eslint,
   b.code_actions.eslint,
   b.formatting.prettier,
   -- css
   b.formatting.stylelint,
   b.diagnostics.stylelint,
   -- vim
   b.diagnostics.vint,
   -- python
   b.diagnostics.flake8,
   b.formatting.black,
   -- Shell
   b.formatting.shfmt,
   b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },
}

local M = {}

M.setup = function()
   null_ls.setup {
      debug = true,
      sources = sources,
      -- format on save
      on_attach = function(client)
         if client.resolved_capabilities.document_formatting then
            vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()"
         end
      end,
   }
end

return M
