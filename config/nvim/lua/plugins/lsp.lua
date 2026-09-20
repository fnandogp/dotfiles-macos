-- LSP setup: nvim-lspconfig + Mason (server install) + nvim-navic (winbar breadcrumbs).
-- Capabilities are advertised via mini.completion; server configs use vim.lsp.config().
-- vim.lsp.enable() attaches to already-open buffers, so later() is safe here.
local add, later = MiniDeps.add, MiniDeps.later

later(function()
  add({
    source = "neovim/nvim-lspconfig",
    depends = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "SmiteshP/nvim-navic",
      "yioneko/nvim-vtsls", -- TypeScript/JS server wrapper used by the vtsls config
    },
  })

  -- nvim-navic: shows the symbol path (code context) at the cursor; rendered in the winbar
  local navic = require("nvim-navic")
  navic.setup({ lsp = { highlight = true } })
  -- Build winbar as "filename > symbol > path" from navic location
  local function set_winbar()
    local filename = vim.fn.expand("%t")
    local navic_location = navic.is_available() and navic.get_location() or ""

    local winbar_content = filename
    if navic_location ~= "" then winbar_content = winbar_content .. " > " .. navic_location end

    -- Hide winbar for specific filetypes
    local ignored_filetypes = { "minifiles", "ministarter", "kulala_ui", "text.kulala_ui", "json.kulala_ui" }
    if not vim.tbl_contains(ignored_filetypes, vim.bo.filetype) then vim.wo.winbar = winbar_content end
  end
  vim.api.nvim_create_autocmd({ "CursorMoved", "BufEnter" }, { callback = set_winbar })

  -- Project root + config-file detection helpers (e.g. distinguish Deno vs Node projects)
  local config_detection = require("plugins.utils.config_detection")
  local project_roots = require("plugins.utils.project_roots")

  local servers = {
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
  }

  -- Set buffer-local diagnostic keymaps + attach navic whenever a server attaches
  vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function(args)
      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)

      vim.keymap.set("n", "gl", function() vim.diagnostic.open_float() end, { buffer = bufnr, desc = "Line diagnostics" })
      vim.keymap.set("n", "gk", function() vim.diagnostic.jump({ count = -1 }) end, { buffer = bufnr, desc = "Prev diagnostic" })
      vim.keymap.set("n", "gj", function() vim.diagnostic.jump({ count = 1 }) end, { buffer = bufnr, desc = "Next diagnostic" })

      -- navic: attach only if the server supports document symbols (skip the harper_ls grammar checker)
      if client and client.name ~= "harper_ls" and client.server_capabilities and client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
      end
    end,
  })

  -- Advertise mini.completion capabilities to all servers
  vim.lsp.config("*", { capabilities = require("mini.completion").get_lsp_capabilities() })

  for server_name, config in pairs(servers) do
    vim.lsp.config(server_name, config)
  end

  require("mason").setup() -- LSP server installer
  require("mason-lspconfig").setup() -- bridges Mason-installed servers into lspconfig (calls vim.lsp.enable)

  -- LSP lifecycle via the native `:lsp` command.
  vim.keymap.set("n", "<Leader>lr", "<cmd>lsp restart<CR>", { desc = "Restart LSP server" })
  vim.keymap.set("n", "<Leader>lt", "<cmd>lsp stop<CR>", { desc = "Stop LSP server" })
  vim.keymap.set("n", "<Leader>ls", "<cmd>lsp start<CR>", { desc = "Start LSP server" })
  vim.keymap.set("n", "<Leader>li", "<cmd>lsp info<CR>", { desc = "LSP info" })
end)
