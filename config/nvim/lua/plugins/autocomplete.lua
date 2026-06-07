-- Completion stack (migrated from blink.cmp+LuaSnip):
-- mini.snippets (snippet engine) + mini.completion (LSP popup) + mini.keymap (Tab/CR multistep).
return {
  -- Snippet engine; loads friendly-snippets + a custom JS/TS console.log snippet
  {
    "nvim-mini/mini.snippets",
    version = false,
    dependencies = { "rafamadriz/friendly-snippets" },
    lazy = false,
    config = function()
      local gen = require("mini.snippets").gen_loader
      require("mini.snippets").setup({
        snippets = {
          -- Custom snippets (console.log for JS/TS)
          function(ctx)
            if ctx.lang == "javascript" or ctx.lang == "typescript" then return { { prefix = "co", body = "console.log({$0})" } } end
          end,
          -- friendly-snippets (vscode format), loaded per language from runtimepath
          gen.from_lang(),
        },
      })
    end,
  },
  -- LSP-driven completion popup with bordered info/signature windows
  {
    "nvim-mini/mini.completion",
    version = false,
    -- mini.basics dep guarantees it loads (and sets completeopt) before we append "fuzzy"
    dependencies = { "nvim-mini/mini.snippets", "nvim-mini/mini.basics" },
    lazy = false,
    config = function()
      require("mini.completion").setup({
        lsp_completion = {
          -- Use 'completefunc' and auto-wire it to every LSP-attached buffer
          -- (kind icons come from MiniIcons.tweak_lsp_kind() in ui.lua)
          source_func = "completefunc",
          auto_setup = true,
        },
        window = {
          info = { border = "rounded" },
          signature = { border = "rounded" },
        },
      })
      -- Enable fuzzy matching for the completion popup (mini only auto-sets menuone,noselect)
      vim.opt.completeopt:append("fuzzy")
    end,
  },
  -- Smart insert-mode keys: each key tries steps in order, falling back to normal behaviour
  {
    "nvim-mini/mini.keymap",
    version = false,
    event = "VeryLazy",
    -- mini.pairs provides the minipairs_cr fallback step for <CR>
    dependencies = { "nvim-mini/mini.pairs" },
    config = function()
      local map_multistep = require("mini.keymap").map_multistep
      -- Tab: jump to next snippet tabstop, else expand snippet, else next popup item
      map_multistep("i", "<Tab>", { "minisnippets_next", "minisnippets_expand", "pmenu_next" })
      -- Shift-Tab: prev snippet tabstop, else prev popup item
      map_multistep("i", "<S-Tab>", { "minisnippets_prev", "pmenu_prev" })
      -- Enter: accept popup selection, else insert newline with auto-pair handling
      map_multistep("i", "<CR>", { "pmenu_accept", "minipairs_cr" })
    end,
  },
}
