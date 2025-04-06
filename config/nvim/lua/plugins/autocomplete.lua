return {
  "saghen/blink.cmp",
  lazy = false,
  dependencies = {
    { "rafamadriz/friendly-snippets" },
    { "xzbdmw/colorful-menu.nvim", opts = {} },
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      config = function(_, opts)
        local luasnip = require("luasnip")
        if opts then luasnip.config.setup(opts) end
        vim.tbl_map(function(type) require("luasnip.loaders.from_" .. type).lazy_load() end, { "vscode", "snipmate", "lua" })
        luasnip.filetype_extend("typescript", { "javascript", "tsdoc" })
        luasnip.filetype_extend("typescriptreact", { "javascript", "tsdoc" })
        luasnip.filetype_extend("javascript", { "jsdoc" })
        luasnip.filetype_extend("javascriptreact", { "javascript", "jsdoc" })
        luasnip.filetype_extend("lua", { "luadoc" })
        luasnip.filetype_extend("python", { "pydoc" })
        luasnip.filetype_extend("rust", { "rustdoc" })
        luasnip.filetype_extend("cs", { "csharpdoc" })
        luasnip.filetype_extend("java", { "javadoc" })
        luasnip.filetype_extend("c", { "cdoc" })
        luasnip.filetype_extend("cpp", { "cppdoc" })
        luasnip.filetype_extend("php", { "phpdoc" })
        luasnip.filetype_extend("kotlin", { "kdoc" })
        luasnip.filetype_extend("ruby", { "rdoc" })
        luasnip.filetype_extend("sh", { "shelldoc" })
      end,
    },
  },
  version = "*",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = "none",
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<C-y>"] = { "select_and_accept", "fallback" },
      ["<CR>"] = { "select_and_accept", "fallback" },

      ["<Tab>"] = { "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },

      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "show", "select_next", "fallback" },

      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    },

    cmdline = {
      completion = { ghost_text = { enabled = false } },
      keymap = {
        preset = "none",
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<C-y>"] = { "select_and_accept" },
        ["<CR>"] = { "accept", "fallback" },

        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "show", "select_next", "fallback" },

        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      },
    },

    appearance = {
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = "mono",
    },

    completion = {
      accept = {
        auto_brackets = {
          semantic_token_resolution = { enabled = false },
        },
      },
      menu = {
        auto_show = function(ctx)
          -- Don't show completion in cmdline or dressing.nvim
          return ctx.mode ~= "cmdline" and vim.bo.filetype ~= "DressingInput"
        end,
        draw = {
          -- We don't need label_description now because label and label_description are already
          -- combined together in label by colorful-menu.nvim.
          columns = { { "kind_icon" }, { "label", gap = 1 } },
          components = {
            label = {
              text = function(ctx) return require("colorful-menu").blink_components_text(ctx) end,
              highlight = function(ctx) return require("colorful-menu").blink_components_highlight(ctx) end,
            },
          },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
      },
    },

    snippets = { preset = "luasnip" },

    sources = {
      default = { "snippets", "lsp", "path", "buffer" },
      providers = {
        buffer = { score_offset = 3 },
        lsp = { score_offset = 2 },
        path = { score_offset = 1 },
        snippets = { score_offset = 0 },
      },
    },

    fuzzy = { prebuilt_binaries = { download = true } },
  },
  opts_extend = { "sources.default" },
}

-- ORIGINAL MENU DRAW
-- draw = {
--   padding = 1,
--   columns = {
--     { "label", "label_description", gap = 1 },
--     { "kind_icon", "kind", gap = 1 },
--   },
--   -- columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "source_name", "kind", gap = 1 } },
--   components = {
--     kind_icon = {
--       ellipsis = false,
--       width = { fill = true },
--       text = function(ctx)
--         local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
--         return kind_icon
--       end,
--       -- Optionally, you may also use the highlights from mini.icons
--       highlight = function(ctx)
--         local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
--         return hl
--       end,
--     },
--     kind = {
--       ellipsis = false,
--       text = function(ctx) return "(" .. ctx.kind .. ")" end,
--     },
--   },
-- },
