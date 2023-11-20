return {
  { "stevearc/dressing.nvim", opts = {} },
  { "echasnovski/mini.statusline", opts = {} },
  { "andymass/vim-matchup", event = "VimEnter" },
  { "machakann/vim-highlightedyank" },
  { "echasnovski/mini.cursorword", opts = {} },
  {
    "echasnovski/mini.clue",
    version = false,
    opts = {
      triggers = {
        -- Leader triggers
        { mode = "n", keys = "<Leader>" },
        { mode = "x", keys = "<Leader>" },

        -- `g` key
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
    "echasnovski/mini.fuzzy",
    version = false,
    opts = {},
  },
}
