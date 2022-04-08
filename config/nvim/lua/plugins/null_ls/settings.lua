local null_ls = require("null-ls")

null_ls.setup({
  diagnostics_format = "[#{c}] #{m} (#{s})",
  sources = {
    -- global
    null_ls.builtins.formatting.trim_whitespace,
    -- lua
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.diagnostics.luacheck.with({ extra_args = { "--global vim" } }),
    -- js / ts
    null_ls.builtins.diagnostics.eslint.with({ only_local = "node_modules/.bin" }),
    null_ls.builtins.code_actions.eslint.with({ only_local = "node_modules/.bin" }),
    --null_ls.builtins.formatting.prettier.with({ only_local = "node_modules/.bin" }),
    null_ls.builtins.formatting.prettier,
    --null_ls.builtins.formatting.eslint_d.with({ only_local = "node_modules/.bin" }),
    -- css
    null_ls.builtins.formatting.stylelint,
    null_ls.builtins.diagnostics.stylelint,
    -- vim
    null_ls.builtins.diagnostics.vint,
    -- python
    null_ls.builtins.diagnostics.flake8,
    null_ls.builtins.formatting.black,
    -- php
    null_ls.builtins.diagnostics.php,
    null_ls.builtins.formatting.phpcsfixer,

    null_ls.builtins.code_actions.gitsigns,
  },
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
            ]])
    end
  end,
})
