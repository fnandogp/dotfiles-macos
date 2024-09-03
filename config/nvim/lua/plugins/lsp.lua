return {
  "neovim/nvim-lspconfig",
  cmd = { "LspInfo", "LspInstall", "LspStart" },
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "SmiteshP/nvim-navic",
  },
  config = function()
    local lspconfig = require("lspconfig")

    vim.api.nvim_create_autocmd("LspAttach", {
      desc = "LSP actions",
      callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", { buffer = bufnr, desc = "Displays hover information." })
        vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", { buffer = bufnr, desc = "Jumps to the definition." })
        vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", { buffer = bufnr, desc = "Lists implementations." })
        vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", { buffer = bufnr, desc = "Lists references." })
        vim.keymap.set("n", "go", "<cmd>Telescope lsp_document_symbols<cr>", { buffer = bufnr, desc = "Jumps to the definition." })
        vim.keymap.set("n", "gO", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", { buffer = bufnr, desc = "Lists references." })

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
      end,
    })

    vim.diagnostic.config({ float = { border = "rounded" } })
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })

    local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

    local default_setup = function(server_name)
      lspconfig[server_name].setup({
        capabilities = lsp_capabilities,
        on_init = function(client)
          -- disable formatting capabilities
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentFormattingRangeProvider = false
        end,
      })
    end

    require("mason").setup({})
    require("mason-lspconfig").setup({
      ensure_installed = {},
      handlers = {
        default_setup,
        lua_ls = function()
          lspconfig.lua_ls.setup({
            capabilities = lsp_capabilities,
            settings = {
              Lua = {
                runtime = { version = "LuaJIT" },
                diagnostics = { globals = { "vim" } },
                workspace = { library = { vim.env.VIMRUNTIME } },
              },
            },
          })
        end,
      },
    })
  end,
  keys = {
    { "<Leader>ls", "<cmd>LspStart<CR>", desc = "Start LSP server" },
    { "<Leader>lt", "<cmd>LspStop<CR>", desc = "Stop LSP server" },
    { "<Leader>lr", "<cmd>LspRestart<CR>", desc = "Restart LSP server" },
  },
}
