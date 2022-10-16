local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")

null_ls.setup({
  diagnostics_format = "[#{c}] #{m} (#{s})",
  sources = {
    -- global
    null_ls.builtins.formatting.trim_whitespace,
    --null_ls.builtins.code_actions.gitsigns,
    --
    -- lua
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.diagnostics.luacheck.with({ extra_args = { "--global vim" } }),

    -- js / ts
    null_ls.builtins.diagnostics.eslint_d.with({
      condition = function(utils)
        return utils.root_has_file({ ".eslintrc.json", ".eslintrc.js", ".eslintrc" })
      end,
    }),
    null_ls.builtins.code_actions.eslint_d.with({
      --condition = function(utils)
      --return utils.root_has_file({ ".eslintrc.json", ".eslintrc.js", ".eslintrc" })
      --end,
    }),
    null_ls.builtins.formatting.eslint_d.with({
      --condition = function(utils)
      --return utils.root_has_file({ ".eslintrc.json", ".eslintrc.js", ".eslintrc" })
      --end,
    }),
    null_ls.builtins.formatting.prettier.with({
      --condition = function(utils)
      --return utils.root_has_file({ ".prettierrc.json", ".prettierrc" })
      --end,
    }),

    --json
    null_ls.builtins.formatting.prettier.with({
      filetypes = { "html", "json", "yaml", "markdown" },
    }),

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

    -- prisma
    null_ls.builtins.formatting.prismaFmt.with({
      command = "prisma",
      arg = { "format", "--schema", "$FILENAME" },
    }),
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
})
