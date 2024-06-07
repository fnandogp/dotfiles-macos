return {
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
    "hrsh7th/cmp-cmdline",
  },
  config = function()
    local luasnip = require("luasnip")
    luasnip.filetype_extend("javascriptreact", { "javascript" })
    luasnip.filetype_extend("typescript", { "javascript" })
    luasnip.filetype_extend("typescriptreact", { "javascript", "typescript" })

    local cmp = require("cmp")

    require("luasnip.loaders.from_vscode").lazy_load()
    cmp.setup({
      sources = {
        { name = "path" },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "buffer", keyword_length = 3 },
        { name = "luasnip", keyword_length = 2 },
      },
      mapping = {
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = false, behavior = cmp.ConfirmBehavior.Replace }),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<Up>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
        ["<Down>"] = cmp.mapping.select_next_item({ behavior = "select" }),
        ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
        ["<C-j>"] = cmp.mapping.select_next_item({ behavior = "select" }),
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      formatting = {
        format = require("lspkind").cmp_format({
          maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
          ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
          show_labelDetails = true,
        }),
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
    })

    -- `/` cmdline setup.
    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    -- `:` cmdline setup.
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
    })
  end,
}
