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
      { "L3MON4D3/LuaSnip" },
    },
    config = function()
      -- Here is where you configure the autocompletion settings.
      local lsp_zero = require("lsp-zero")
      lsp_zero.extend_cmp()

      -- And you can configure cmp even more, if you want to.
      local cmp = require("cmp")
      local cmp_action = lsp_zero.cmp_action()

      cmp.setup({
        formatting = lsp_zero.cmp_format(),
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-f>"] = cmp_action.luasnip_jump_forward(),
          ["<C-b>"] = cmp_action.luasnip_jump_backward(),
        }),
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
      { "creativenull/efmls-configs-nvim" },
      { "SmiteshP/nvim-navic" },
      { "lukas-reineke/lsp-format.nvim" },
    },
    config = function()
      -- This is where all the LSP shenanigans will live
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
        local opts = { buffer = bufnr }
        lsp_zero.default_keymaps(opts)

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

      -- Linter and Formatters
      local eslint = require("efmls-configs.linters.eslint")
      local prettier = require("efmls-configs.formatters.prettier")
      local luacheck = require("efmls-configs.linters.luacheck")
      local stylua = require("efmls-configs.formatters.stylua")

      local languages = {
        javascrip = { eslint, prettier },
        javascripreact = { eslint, prettier },
        typescript = { eslint, prettier },
        typescriptreact = { eslint, prettier },
        lua = { luacheck, stylua },
      }
      lsp_zero.configure('efm', {
        filetypes = vim.tbl_keys(languages),
        settings = {
          rootMarkers = { ".git/" },
          languages = languages,
        },
        init_options = {
          documentFormatting = true,
          documentRangeFormatting = true,
        },
      })


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
    end,
  },
}
