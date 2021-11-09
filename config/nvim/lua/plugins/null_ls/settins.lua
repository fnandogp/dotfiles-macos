local null_ls = require("null-ls")

null_ls.config({
      diagnostics_format = "[#{c}] #{m} (#{s})",
      sources = {
         -- global
         null_ls.builtins.formatting.trim_whitespace,
         -- lua
         null_ls.builtins.diagnostics.luacheck,
         null_ls.builtins.formatting.stylua,
         -- js / ts
         null_ls.builtins.diagnostics.eslint,
         null_ls.builtins.formatting.eslint_d,
         -- css
         null_ls.builtins.formatting.stylelint,
         null_ls.builtins.diagnostics.stylelint,
         -- vim
         null_ls.builtins.diagnostics.vint,
         -- python
         null_ls.builtins.diagnostics.pyright,
         null_ls.builtins.formatting.black,
   } })

vim.cmd [[  autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()  ]]

require("lspconfig")["null-ls"].setup({ })
