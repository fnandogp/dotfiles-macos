-- LSP setup: nvim-lspconfig + Mason (server install) + nvim-navic (winbar breadcrumbs).
-- Capabilities are advertised via mini.completion; server configs use vim.lsp.config().
return {
  "neovim/nvim-lspconfig",
  cmd = { "LspInfo", "LspInstall", "LspStart" },
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
    -- nvim-navic: shows the symbol path (code context) at the cursor; rendered in the winbar below.
    {
      "SmiteshP/nvim-navic",
      opts = { lsp = { highlight = true } },
      config = function(_, opts)
        local navic = require("nvim-navic")
        navic.setup(opts)
        -- Build winbar as "filename > symbol > path" from navic location
        local function set_winbar()
          local filename = vim.fn.expand("%t")
          local navic_location = navic.is_available() and navic.get_location() or ""

          local winbar_content = filename
          if navic_location ~= "" then winbar_content = winbar_content .. " > " .. navic_location end

          -- Hide winbar for specific filetypes
          local ignored_filetypes = { "minifiles", "text.kulala_ui", "json.kulala_ui" }
          local should_hide = vim.tbl_contains(ignored_filetypes, vim.bo.filetype)
          if not should_hide then vim.wo.winbar = winbar_content end
        end

        -- Update winbar when cursor moves or file changes
        vim.api.nvim_create_autocmd({ "CursorMoved", "BufEnter" }, { callback = set_winbar })
      end,
    },
    "nvim-mini/mini.completion", -- provides LSP completion capabilities (see config below)
    "yioneko/nvim-vtsls", -- TypeScript/JS server wrapper used by the vtsls config
  },
  opts = function()
    -- Project root + config-file detection helpers (e.g. distinguish Deno vs Node projects)
    local config_detection = require("plugins.utils.config_detection")
    local project_roots = require("plugins.utils.project_roots")

    return {
      servers = {
        -- Lua: target LuaJIT runtime, recognise the `vim` global, expose Neovim runtime as workspace lib
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              diagnostics = { globals = { "vim" } },
              workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            },
          },
        },
        -- TS/JS via vtsls; only attach in Node projects (skip if a Deno config is present)
        vtsls = vim.tbl_deep_extend("force", require("vtsls").lspconfig, {
          root_dir = function(bufnr, on_dir)
            if not config_detection.has_deno_config(bufnr) then
              local root_path = project_roots.get_node_root_dir(bufnr)
              if root_path then on_dir(root_path) end
            end
          end,
        }),
        -- Deno LSP; only attaches when a Deno project root is found
        denols = {
          root_dir = function(bufnr, on_dir)
            local root_path = project_roots.get_deno_root_dir(bufnr)
            if root_path then on_dir(root_path) end
          end,
        },
        -- GraphQL LSP; run in stream mode and apply to .graphql/.gql files
        graphql = {
          cmd = { "graphql-lsp", "server", "-m", "stream" },
          filetypes = { "graphql", "gql" },
        },
      },
    }
  end,
  config = function(_, opts)
    -- Set buffer-local diagnostic keymaps + attach navic whenever a server attaches
    vim.api.nvim_create_autocmd("LspAttach", {
      desc = "LSP actions",
      callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        vim.keymap.set("n", "gl", function() vim.diagnostic.open_float() end, { buffer = bufnr, desc = "Line diagnostics" })
        vim.keymap.set("n", "gk", function() vim.diagnostic.jump({ count = -1 }) end, { buffer = bufnr, desc = "Prev diagnostic" })
        vim.keymap.set("n", "gj", function() vim.diagnostic.jump({ count = 1 }) end, { buffer = bufnr, desc = "Next diagnostic" })

        --navic: attach only if the server supports document symbols (skip the harper_ls grammar checker)
        if client and client.name ~= "harper_ls" and client.server_capabilities and client.server_capabilities.documentSymbolProvider then
          require("nvim-navic").attach(client, bufnr)
        end
      end,
    })

    -- Advertise mini.completion capabilities to all servers
    vim.lsp.config("*", { capabilities = require("mini.completion").get_lsp_capabilities() })

    -- Set custom configs for defined servers
    for server_name, config in pairs(opts.servers) do
      vim.lsp.config(server_name, config)
    end

    require("mason").setup() -- LSP server installer
    require("mason-lspconfig").setup() -- bridges Mason-installed servers into lspconfig
  end,
  -- LSP lifecycle controls
  keys = {
    { "<Leader>ls", "<cmd>LspStart<CR>", desc = "Start LSP server" },
    { "<Leader>lt", "<cmd>LspStop<CR>", desc = "Stop LSP server" },
    { "<Leader>lr", "<cmd>LspRestart<CR>", desc = "Restart LSP server" },
  },
}
