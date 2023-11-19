return {
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    lazy = true,
    config = false,
    init = function()
      -- Disable automatic setup, we are doing it manually
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = true,
  },
  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "onsails/lspkind.nvim",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local luasnip = require("luasnip")
      luasnip.filetype_extend("javascriptreact", { "javascript" })
      luasnip.filetype_extend("typescript", { "javascript" })
      luasnip.filetype_extend("typescriptreact", { "javascript", "typescript" })

      -- Here is where you configure the autocompletion settings.
      local lsp_zero = require("lsp-zero")
      lsp_zero.extend_cmp()

      -- Defines the sign icons that appear in the gutter.
      lsp_zero.set_sign_icons({
        error = "✘",
        warn = "▲",
        hint = "⚑",
        info = "»",
      })
      -- And you can configure cmp even more, if you want to.
      local cmp = require("cmp")
      local cmp_action = lsp_zero.cmp_action()

      require("luasnip.loaders.from_vscode").lazy_load()
      cmp.setup({
        sources = {
          { name = "path" },
          { name = "nvim_lsp" },
          { name = "nvim_lua" },
          { name = "buffer", keyword_length = 3 },
          { name = "luasnip", keyword_length = 2 },
        },
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
          }),
          ["<Up>"] = cmp.mapping.select_prev_item(),
          ["<Down>"] = cmp.mapping.select_next_item(),
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-Space>"] = cmp_action.toggle_completion(),

          ["<C-l>"] = cmp_action.luasnip_jump_forward(),
          ["<C-h>"] = cmp_action.luasnip_jump_backward(),
          ["<Tab>"] = cmp_action.luasnip_supertab(),
          ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
        }),
        formatting = {
          fields = { "abbr", "kind", "menu" },
          format = require("lspkind").cmp_format({
            mode = "symbol_text", -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters
            ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
          }),
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })
    end,
  },
  -- LSP
  {
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "williamboman/mason-lspconfig.nvim" },
      { "SmiteshP/nvim-navic" },
      { "lukas-reineke/lsp-format.nvim" },
      { "mfussenegger/nvim-lint" },
      { "stevearc/conform.nvim" },
    },
    config = function()
      local lsp = require("lspconfig")
      local lsp_zero = require("lsp-zero")

      lsp_zero.extend_lspconfig({
        on_init = function(client)
          -- disable formatting capabilities
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentFormattingRangeProvider = false
        end,
      })
      lsp_zero.on_attach(function(client, bufnr)
        local bind = vim.keymap.set

        bind("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", { buffer = bufnr, desc = "Displays hover information." })
        bind("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", { buffer = bufnr, desc = "Jumps to the definition." })
        bind("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", { buffer = bufnr, desc = "Jumps to the declaration." })
        bind("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", { buffer = bufnr, desc = "Lists implementations." })
        bind("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", { buffer = bufnr, desc = "Jumps to the definition." })
        bind("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", { buffer = bufnr, desc = "Lists references." })

        bind("n", "gn", "<cmd>lua vim.lsp.buf.rename()<cr>", { buffer = bufnr, desc = "Rename" })
        bind("n", "gx", "<cmd>lua vim.lsp.buf.code_action()<cr>", { buffer = bufnr, desc = "Code Action" })
        bind("v", "gx", "<cmd>lua vim.lsp.buf.range_code_action()<cr>", { buffer = bufnr, desc = "Code Action" })

        bind("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", { buffer = bufnr, desc = "List diagnostics" })
        bind("n", "gL", "<cmd>lua vim.diagnostic.setqflist()<cr>", { buffer = bufnr, desc = "List diagnostics" })
        bind("n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", { buffer = bufnr, desc = "Prev diagnostic" })
        bind("n", "gj", "<cmd>lua vim.diagnostic.goto_next()<cr>", { buffer = bufnr, desc = "Next diagnostic" })

        --navic
        if client.server_capabilities.documentSymbolProvider then
          require("nvim-navic").attach(client, bufnr)
        end

        -- autoformat
        if client.supports_method("textDocument/formatting") then
          require("lsp-format").on_attach(client)
        end
      end)

      require("mason-lspconfig").setup({
        ensure_installed = {},
        handlers = {
          lsp_zero.default_setup,
          lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            lsp.lua_ls.setup(lua_opts)
          end,
        },
      })

      require("lint").linters_by_ft = {
        markdown = { "vale" },
        lua = { "luacheck" },
        javascript = { "eslint" },
        typescript = { "eslint" },
        javascriptreact = { "eslint" },
        typescriptreact = { "eslint" },
        php = { "php", "phpstan", "phpmd" },
        css = { "stylelint" },
      }

      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          javascript = { "prettier", "trim_whitespace", "trim_newlines" },
          typescript = { "prettier", "trim_whitespace", "trim_newlines" },
          javascriptreact = { "prettier", "trim_whitespace", "trim_newlines" },
          typescriptreact = { "prettier", "trim_whitespace", "trim_newlines" },
          json = { "prettier", "trim_whitespace", "trim_newlines" },
          jsonc = { "prettier", "trim_whitespace", "trim_newlines" },
          css = { "prettier" },
          --php = { "php_cs_fixer" },
          php = { "trim_whitespace", "trim_newlines" },
          ["*"] = { "codespell" }, -- Use the "*" filetype to run formatters on all filetypes.
          ["_"] = { "trim_whitespace", "trim_newlines" }, -- Use the "_" filetype to run formatters on filetypes that don't
        },
        formatters = {
          --php_cs_fixer = {
          --prepend_args = { "--rules=@PSR12" },
          --},
        },
        format_on_save = {
          async = true,
          quiet = true,
        },
      })
    end,
    keys = {
      { "<Leader>lr", "<cmd>LspRestart<CR>", desc = "Restart LSP server" },
      { "<Leader>cf", "<cmd>LspZeroFormat<CR>", desc = "Format" },
    },
  },
}
