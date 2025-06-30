return {
  { "nvim-tree/nvim-web-devicons", version = false, opts = {} },
  { "echasnovski/mini.icons", version = false, opts = {} },
  { "echasnovski/mini.statusline", version = false, opts = {} },
  { "echasnovski/mini.cursorword", version = false, opts = {} },
  { "j-hui/fidget.nvim", opts = {} },
  { "stevearc/dressing.nvim", opts = { select = { enabled = false } } },
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
      },
    },
  },
  {
    "folke/noice.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    event = "VeryLazy",
    opts = {
      lsp = {
        progress = { enabled = false },
        signature = { enabled = false },
        hover = { enabled = false },
        message = { enabled = false },
      },
      presets = {
        command_palette = true, -- Position the cmdline and popupmenu together
        lsp_doc_border = true, -- Add a border to hover docs and signature help
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
        border = false,
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
      checkbox = {
        unchecked = {
          icon = "",
          highlight = "RenderMarkdownUnchecked",
        },
        checked = { icon = "", highlight = "RenderMarkdownChecked" },
        custom = {
          cancelled = { raw = "[~]", rendered = " ", highlight = "RenderMarkdownTodo", scope_highlight = nil },
          undefined = { raw = "[?]", rendered = " ", highlight = "RenderMarkdownTodo", scope_highlight = nil },
          partial = { raw = "[-]", rendered = " ", highlight = "RenderMarkdownTodo", scope_highlight = nil },
        },
      },
      file_types = { "markdown", "vimwiki", "codecompanion", "Avante" },
    },
    ft = { "markdown", "Avante" },
  },
}
