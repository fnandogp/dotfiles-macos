return {
  { "nvim-tree/nvim-web-devicons", version = false, opts = {} },
  { "nvim-mini/mini.icons", version = false, opts = {} },
  {
    "nvim-mini/mini.statusline",
    version = false,
    opts = {
      content = {
        active = function()
          local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
          local git = MiniStatusline.section_git({ trunc_width = 40 })
          local diff = MiniStatusline.section_diff({ trunc_width = 75 })
          local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
          local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
          local filename = MiniStatusline.section_filename({ trunc_width = 140 })
          local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
          local location = MiniStatusline.section_location({ trunc_width = 75 })
          local search = MiniStatusline.section_searchcount({ trunc_width = 75 })

          -- Add kulala env for http filetype
          local kulala_env = ""
          if vim.bo.filetype == "http" and vim.g.kulala_selected_env then kulala_env = string.format("(%s) ", vim.g.kulala_selected_env) end

          return MiniStatusline.combine_groups({
            { hl = mode_hl, strings = { mode } },
            { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
            "%<", -- Mark general truncate point
            { hl = "MiniStatuslineFilename", strings = { filename } },
            "%=", -- End left alignment
            { hl = "MiniStatuslineFileinfo", strings = { kulala_env, fileinfo, location, search } },
          })
        end,
      },
    },
  },
  { "nvim-mini/mini.cursorword", version = false, opts = {} },
  { "j-hui/fidget.nvim", opts = {} },
  { "stevearc/dressing.nvim", opts = { select = { enabled = false } } },
  {
    "nvim-mini/mini.clue",
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
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" },
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
      file_types = { "markdown", "vimwiki", "codecompanion" },
    },
    ft = { "markdown" },
  },
}
