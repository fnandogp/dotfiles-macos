return {
  "neovim/nvim-lspconfig",
  cmd = { "LspInfo", "LspInstall", "LspStart" },
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
    {
      "SmiteshP/nvim-navic",
      opts = { lsp = { highlight = true } },
      config = function(_, opts)
        local navic = require("nvim-navic")
        navic.setup(opts)
        local function set_winbar()
          local filename = vim.fn.expand("%t")
          local navic_location = navic.is_available() and navic.get_location() or ""

          local winbar_content = filename
          if navic_location ~= "" then winbar_content = winbar_content .. " > " .. navic_location end

          vim.wo.winbar = winbar_content
        end

        -- Update winbar when cursor moves or file changes
        vim.api.nvim_create_autocmd({ "CursorMoved", "BufEnter" }, {
          callback = set_winbar,
        })
      end,
    },
    "saghen/blink.cmp",
    "yioneko/nvim-vtsls",
  },
  opts = function()
    return {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              diagnostics = { globals = { "vim" } },
              workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            },
          },
        },
        vtsls = require("vtsls").lspconfig,
      },
    }
  end,
  config = function(_, opts)
    vim.api.nvim_create_autocmd("LspAttach", {
      desc = "LSP actions",
      callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        vim.keymap.set("n", "gn", function() vim.lsp.buf.rename() end, { buffer = bufnr, desc = "Rename" })
        vim.keymap.set("n", "gx", function() vim.lsp.buf.code_action() end, { buffer = bufnr, desc = "Code Action" })
        vim.keymap.set("v", "gx", function() vim.lsp.buf.range_code_action() end, { buffer = bufnr, desc = "Code Action" })

        vim.keymap.set("n", "gl", function() vim.diagnostic.open_float() end, { buffer = bufnr, desc = "List diagnostics" })
        vim.keymap.set("n", "gk", function() vim.diagnostic.jump({ count = -1 }) end, { buffer = bufnr, desc = "Prev diagnostic" })
        vim.keymap.set("n", "gj", function() vim.diagnostic.jump({ count = 1 }) end, { buffer = bufnr, desc = "Next diagnostic" })

        --navic
        if client and client.name ~= "harper_ls" and client.server_capabilities and client.server_capabilities.documentSymbolProvider then
          require("nvim-navic").attach(client, bufnr)
        end
      end,
    })

    -- Set custom configs for defined servers
    for server_name, config in pairs(opts.servers) do
      vim.lsp.config(server_name, config)
    end

    require("mason").setup()
    require("mason-lspconfig").setup()
  end,
  keys = {
    { "<Leader>ls", "<cmd>LspStart<CR>", desc = "Start LSP server" },
    { "<Leader>lt", "<cmd>LspStop<CR>", desc = "Stop LSP server" },
    { "<Leader>lr", "<cmd>LspRestart<CR>", desc = "Restart LSP server" },
  },
}
