return {
  "neovim/nvim-lspconfig",
  cmd = { "LspInfo", "LspInstall", "LspStart" },
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "SmiteshP/nvim-navic",
    "saghen/blink.cmp",
  },
  opts = {
    lua_ls = {
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          diagnostics = { globals = { "vim" } },
          workspace = { library = { vim.env.VIMRUNTIME } },
        },
      },
    },
  },
  config = function(_, opts)
    local lspconfig = require("lspconfig")

    vim.api.nvim_create_autocmd("LspAttach", {
      desc = "LSP actions",
      callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", { buffer = bufnr, desc = "Displays hover information." })

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

    require("mason").setup()
    require("mason-lspconfig").setup()

    --require("mason-lspconfig").setup_handlers({
    --function(server_name)
    --local config = opts[server_name] or {}
    --config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
    --lspconfig[server_name].setup(config)
    --end,
    --})
  end,
  keys = {
    { "<Leader>ls", "<cmd>LspStart<CR>", desc = "Start LSP server" },
    { "<Leader>lt", "<cmd>LspStop<CR>", desc = "Stop LSP server" },
    { "<Leader>lr", "<cmd>LspRestart<CR>", desc = "Restart LSP server" },
  },
}
