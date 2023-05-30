local lspconfig = require("lspconfig")
local lsp = require("lsp-zero")
local cmp = require("cmp")
local luasnip = require("luasnip")
local cmp_action = require("lsp-zero").cmp_action()
local mason = require("mason")
local null_ls = require("null-ls")

mason.setup({ ui = { border = "rounded" } })

luasnip.filetype_extend("javascriptreact", { "javascript" })
luasnip.filetype_extend("typescript", { "javascript" })
luasnip.filetype_extend("typescriptreact", { "javascript", "typescript" })

lsp.preset({ manage_nvim_cmp = { set_sources = "recommended" } })

require("luasnip.loaders.from_vscode").lazy_load()

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr }
  lsp.default_keymaps(opts)

  vim.keymap.set("n", "gn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
  vim.keymap.set("n", "gx", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
  vim.keymap.set("v", "gx", "<cmd>lua vim.lsp.buf.range_code_action()<cr>", opts)

  vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
  vim.keymap.set("n", "gL", "<cmd>lua vim.diagnostic.setqflist()<cr>", opts)
  vim.keymap.set("n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
  vim.keymap.set("n", "gj", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)

  vim.keymap.set("n", "<Leader>lr", "<Cmd>LspRestart<CR>", opts)

  --navic
  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
  end

  --autoformat
  if client.supports_method("textDocument/formatting") then
    require("lsp-format").on_attach(client)
  end
end)

lsp.set_sign_icons({ error = "✘", warn = "▲", hint = "⚑", info = "»" })

lsp.nvim_workspace({ library = vim.api.nvim_get_runtime_file("", true) })

lsp.skip_server_setup({ "tsserver" })
lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

require("typescript").setup({})

cmp.setup({
  mapping = {
    ["<CR>"] = cmp.mapping.confirm(),
    ["<Up>"] = cmp.mapping.select_prev_item(),
    ["<Down>"] = cmp.mapping.select_next_item(),
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-Space>"] = cmp_action.toggle_completion(),

    ["<C-l>"] = cmp_action.luasnip_jump_forward(),
    ["<C-h>"] = cmp_action.luasnip_jump_backward(),
    ["<Tab>"] = cmp_action.luasnip_supertab(),
    ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  formatting = {
    fields = { "abbr", "kind", "menu" },
    format = require("lspkind").cmp_format({
      mode = "symbol_text",
      maxwidth = 50,
      ellipsis_char = "...",
    }),
  },
})

null_ls.setup({
  sources = {
    -- global
    null_ls.builtins.formatting.trim_whitespace,
    --null_ls.builtins.code_actions.gitsigns,

    -- lua
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.diagnostics.luacheck.with({ extra_args = { "--global vim" } }),

    -- js / ts
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.formatting.eslint_d,
    null_ls.builtins.formatting.prettier,
    require("typescript.extensions.null-ls.code-actions"),

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

    -- toml
    null_ls.builtins.formatting.taplo,
  },
})
