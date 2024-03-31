return {
  "VonHeikemen/lsp-zero.nvim",
  branch = "v3.x",
  lazy = true,
  dependencies = {
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "neovim/nvim-lspconfig" },
    { "SmiteshP/nvim-navic" },
  },
  config = function()
    local lsp_zero = require("lsp-zero")

    lsp_zero.on_attach(function(client, bufnr)
      lsp_zero.default_keymaps({ buffer = bufnr })

      vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", { buffer = bufnr, desc = "Displays hover information." })
      vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", { buffer = bufnr, desc = "Jumps to the definition." })
      vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", { buffer = bufnr, desc = "Jumps to the declaration." })
      vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", { buffer = bufnr, desc = "Lists implementations." })
      vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", { buffer = bufnr, desc = "Jumps to the definition." })
      vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", { buffer = bufnr, desc = "Lists references." })

      vim.keymap.set("n", "gn", "<cmd>lua vim.lsp.buf.rename()<cr>", { buffer = bufnr, desc = "Rename" })
      vim.keymap.set("n", "gx", "<cmd>lua vim.lsp.buf.code_action()<cr>", { buffer = bufnr, desc = "Code Action" })
      vim.keymap.set("v", "gx", "<cmd>lua vim.lsp.buf.range_code_action()<cr>", { buffer = bufnr, desc = "Code Action" })

      vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", { buffer = bufnr, desc = "List diagnostics" })
      vim.keymap.set("n", "gL", "<cmd>lua vim.diagnostic.setqflist()<cr>", { buffer = bufnr, desc = "List diagnostics" })
      vim.keymap.set("n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", { buffer = bufnr, desc = "Prev diagnostic" })
      vim.keymap.set("n", "gj", "<cmd>lua vim.diagnostic.goto_next()<cr>", { buffer = bufnr, desc = "Next diagnostic" })

      --navic
      if client.server_capabilities.documentSymbolProvider then
        require("nvim-navic").attach(client, bufnr)
      end
    end)

    lsp_zero.extend_lspconfig({
      on_init = function(client)
        -- disable formatting capabilities
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentFormattingRangeProvider = false
      end,
    })

    lsp_zero.set_sign_icons({
      error = "✘",
      warn = "▲",
      hint = "⚑",
      info = "»",
    })

    lsp_zero.format_on_save({
      format_opts = {
        async = false,
        timeout_ms = 10000,
      },
    })

    require("mason").setup({})
    require("mason-lspconfig").setup({
      -- Replace the language servers listed here
      -- with the ones you want to install
      ensure_installed = { "tsserver", "rust_analyzer" },
      handlers = {
        lsp_zero.default_setup,
      },
    })
  end,
  keys = {
    { "<Leader>ls", "<cmd>LspStart<CR>", desc = "Start LSP server" },
    { "<Leader>lr", "<cmd>LspRestart<CR>", desc = "Restart LSP server" },
  },
}
