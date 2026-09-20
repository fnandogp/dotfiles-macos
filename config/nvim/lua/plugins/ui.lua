-- UI layer: icons, statusline, notifications (now: needed for the first draw),
-- then cursorword, cmdline, input, key hints and markdown rendering (later).
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
  require("mini.icons").setup()
  -- Prepend icons to LSP kinds -> glyphs show in the completion popup + symbol pickers
  require("mini.icons").tweak_lsp_kind()

  -- Statusline. Custom active() builds each section with a trunc_width so they
  -- drop out progressively as the window narrows.
  require("mini.statusline").setup({
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
  })

  -- Notifications + LSP progress; vim.notify override in place before anything can notify
  require("mini.notify").setup({
    window = {
      config = { border = "rounded" }, -- match vim.o.winborder used by the other floats
      winblend = 0, -- opaque; the module default of 25 ignores the global 'winblend'
    },
  })
  vim.notify = require("mini.notify").make_notify()
  vim.keymap.set("n", "<leader>N", function() require("mini.notify").show_history() end, { desc = "Notification history" })
  -- Full :messages (native echo/errors/aborted output mini.notify never sees)
  vim.keymap.set("n", "<leader>M", function()
    local messages = vim.api.nvim_exec2("messages", { output = true }).output
    vim.cmd("botright new")
    vim.bo.buftype = "nofile"
    vim.bo.bufhidden = "wipe"
    vim.bo.swapfile = false
    vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(messages, "\n"))
    vim.keymap.set("n", "q", "<Cmd>close<CR>", { buffer = true, desc = "Close window" })
  end, { desc = "All messages (:messages)" })
end)

later(function()
  -- File-type icons for legacy consumers (mini.icons is the modern provider)
  add("nvim-tree/nvim-web-devicons")
  require("nvim-web-devicons").setup()

  -- Highlights other instances of the word under the cursor
  require("mini.cursorword").setup()
  -- Command line tweaks (autocomplete/autocorrect/range-peek); popup UI handled by vim._extui
  require("mini.cmdline").setup()
  -- vim.ui.input override (vim.ui.select is wired to MiniPick.ui_select in picker.lua)
  require("mini.input").setup()

  -- Shows a popup of available next keys after a trigger (which-key style)
  local miniclue = require("mini.clue")
  miniclue.setup({
    triggers = {
      -- Leader triggers
      { mode = "n", keys = "<Leader>" },
      { mode = "x", keys = "<Leader>" },
      -- `g` key
      { mode = "n", keys = "g" },
      { mode = "x", keys = "g" },
      -- Bracketed navigation (mini.bracketed / mini.diff / mini.indentscope)
      { mode = "n", keys = "[" },
      { mode = "n", keys = "]" },
      -- Window commands
      { mode = "n", keys = "<C-w>" },
    },
    clues = {
      miniclue.gen_clues.g(),
      miniclue.gen_clues.windows(),
      { mode = "n", keys = "<Leader>h", desc = "+Hunks/git" },
      { mode = "n", keys = "<Leader>v", desc = "+Bookmarks" },
      { mode = "n", keys = "<Leader>n", desc = "+Notes" },
      { mode = "n", keys = "<Leader>s", desc = "+Search/replace" },
      { mode = "n", keys = "<Leader>l", desc = "+LSP" },
      { mode = "n", keys = "<Leader>F", desc = "+Format" },
    },
  })

  -- In-buffer markdown rendering (headings, code blocks, checkboxes)
  add({ source = "MeanderingProgrammer/render-markdown.nvim", depends = { "nvim-treesitter/nvim-treesitter" } })
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  require("render-markdown").setup({
    completions = {
      lsp = { enabled = true },
    },
    heading = {
      width = "block",
      right_pad = 1,
      border = false,
    },
    code = {
      width = "block",
      min_width = 20,
      disable_background = {},
      border = "thin",
    },
    checkbox = {
      unchecked = {
        icon = "",
        highlight = "RenderMarkdownUnchecked",
      },
      checked = { icon = "", highlight = "RenderMarkdownChecked" },
      -- Extra checkbox states beyond the default checked/unchecked
      custom = {
        cancelled = { raw = "[~]", rendered = " ", highlight = "RenderMarkdownTodo", scope_highlight = nil },
        undefined = { raw = "[?]", rendered = " ", highlight = "RenderMarkdownTodo", scope_highlight = nil },
        partial = { raw = "[-]", rendered = " ", highlight = "RenderMarkdownTodo", scope_highlight = nil },
      },
    },
    file_types = { "markdown", "vimwiki" },
  })
end)
