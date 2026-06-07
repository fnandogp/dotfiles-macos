-- UI layer: statusline, notifications, cmdline, key hints and markdown rendering.
-- Built mostly from mini.* modules; markdown via render-markdown.nvim.
return {
  -- File-type icons (devicons for legacy consumers, mini.icons as the modern provider)
  { "nvim-tree/nvim-web-devicons", version = false, opts = {} },
  {
    "nvim-mini/mini.icons",
    version = false,
    opts = {},
    config = function(_, opts)
      require("mini.icons").setup(opts)
      -- Prepend icons to LSP kinds -> glyphs show in the completion popup + symbol pickers
      require("mini.icons").tweak_lsp_kind()
    end,
  },
  -- Statusline. Custom active() builds each section with a trunc_width so they
  -- drop out progressively as the window narrows.
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

          -- Layout: mode | git/diff/diagnostics/lsp | filename ... fileinfo/location/search
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
  -- Highlights other instances of the word under the cursor
  { "nvim-mini/mini.cursorword", version = false, opts = {} },
  -- Command line tweaks (autocomplete/autocorrect/range-peek); popup UI handled by vim._extui
  { "nvim-mini/mini.cmdline", version = false, opts = {} },
  -- vim.ui.input override (vim.ui.select is wired to MiniPick.ui_select in picker.lua)
  { "nvim-mini/mini.input", version = false, opts = {} },
  -- Notifications + LSP progress (replaces noice notify and fidget)
  {
    "nvim-mini/mini.notify",
    version = false,
    config = function()
      require("mini.notify").setup()
      vim.notify = require("mini.notify").make_notify()
    end,
  },
  -- Shows a popup of available next keys after a trigger (which-key style)
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
  -- In-buffer markdown rendering (headings, code blocks, checkboxes).
  -- Also enabled in codecompanion chat buffers (see file_types).
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      completions = {
        lsp = { enabled = true },
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
        -- Extra checkbox states beyond the default checked/unchecked
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
