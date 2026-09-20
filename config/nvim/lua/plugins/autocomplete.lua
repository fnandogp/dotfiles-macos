-- Completion stack: mini.snippets (engine) + mini.completion (LSP popup) + mini.keymap (Tab/CR multistep).
local add, later = MiniDeps.add, MiniDeps.later

later(function()
  -- Snippet engine; loads friendly-snippets + a custom JS/TS console.log snippet
  add("rafamadriz/friendly-snippets")
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

  -- LSP-driven completion popup with bordered info/signature windows
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

  -- Smart insert-mode keys: each key tries steps in order, falling back to normal behaviour.
  -- minipairs_cr needs mini.pairs, set up in coding.lua (same later() queue, earlier position not required: steps resolve at keypress).
  local map_multistep = require("mini.keymap").map_multistep
  -- Tab: jump to next snippet tabstop, else expand snippet, else next popup item
  map_multistep("i", "<Tab>", { "minisnippets_next", "minisnippets_expand", "pmenu_next" })
  -- Shift-Tab: prev snippet tabstop, else prev popup item
  map_multistep("i", "<S-Tab>", { "minisnippets_prev", "pmenu_prev" })
  -- Enter: accept popup selection, else insert newline with auto-pair handling
  map_multistep("i", "<CR>", { "pmenu_accept", "minipairs_cr" })
end)
