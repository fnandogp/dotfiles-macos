return {
  { "nvim-tree/nvim-web-devicons", version = false, opts = {} },
  { "echasnovski/mini.icons", version = false, opts = {} },
  { "echasnovski/mini.statusline", version = false, opts = {} },
  { "echasnovski/mini.cursorword", version = false, opts = {} },
  { "echasnovski/mini.notify", version = false, opts = {} },
  { "stevearc/dressing.nvim", opts = {
    select = { enabled = false },
  } },
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
    dependencies = { "MunifTanjim/nui.nvim" },
    event = "VeryLazy",
    opts = {
      lsp = {
        signature = { enabled = false },
        hover = { enabled = false },
        message = { enabled = false },
      },
      presets = {
        command_palette = true, -- position the cmdline and popupmenu together
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
      messages = {
        enabled = false,
      },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      completions = {
        lsp = { enabled = true },
        blink = { enabled = true },
      },
      heading = {
        width = "block",
        right_pad = 1,
        border = true,
        -- border_virtual = true,
      },
      code = {
        width = "block",
        min_width = 20,
        disable_background = {},
        left_pad = 2,
        -- left_margin = 4,
        right_pad = 2,
        -- right_margin = 4,
        border = "thin",
      },
      file_types = { "markdown", "vimwiki", "codecompanion" },
    },
  },
}
