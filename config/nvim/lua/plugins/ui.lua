return {
  { "stevearc/dressing.nvim", opts = {} },
  { "echasnovski/mini.statusline", opts = {} },
  { "andymass/vim-matchup", event = "VimEnter" },
  { "norcalli/nvim-colorizer.lua", opts = {} },
  { "echasnovski/mini.cursorword", opts = {} },
  {
    "echasnovski/mini.clue",
    version = false,
    opts = {
      triggers = {
        -- Leader triggers
        { mode = "n", keys = "<Leader>" },
        { mode = "x", keys = "<Leader>" },

        -- `g` key,
        { mode = "n", keys = "g" },
        { mode = "x", keys = "g" },

        -- Window commands
        { mode = "n", keys = "<C-w>" },

        -- `z` key
        { mode = "n", keys = "z" },
        { mode = "x", keys = "z" },
      },
    },
  },
  { "echasnovski/mini.fuzzy", version = false, opts = {} },
  { "kwkarlwang/bufresize.nvim", opts = {} },
  { "echasnovski/mini.notify", version = false, opts = {} },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = { signature = { enabled = false }, hover = { enabled = false }, message = { enabled = false } },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    },
    dependencies = { "MunifTanjim/nui.nvim" },
  },
}
