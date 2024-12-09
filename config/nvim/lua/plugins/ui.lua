return {
  { "nvim-tree/nvim-web-devicons", opts = {} },
  { "echasnovski/mini.icons", version = false, opts = {} },
  { "stevearc/dressing.nvim", opts = {} },
  { "echasnovski/mini.statusline", opts = {} },
  { "andymass/vim-matchup", event = "VimEnter" },
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
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = { signature = { enabled = false }, hover = { enabled = false }, message = { enabled = false } },
      presets = {
        command_palette = true, -- position the cmdline and popupmenu together
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    },
    dependencies = { "MunifTanjim/nui.nvim" },
  },
}
