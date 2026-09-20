-- Editing utilities: mini.* modules (comment/pairs/surround/bufremove/move/ai/
-- splitjoin/align/trailspace) plus the git toolset (mini.diff, mini.git,
-- diffview, neogit).
local add, later = MiniDeps.add, MiniDeps.later

later(function()
  -- Toggle comments; commentstring resolved per-context via treesitter (e.g. JSX vs JS)
  add("JoosepAlviste/nvim-ts-context-commentstring")
  require("ts_context_commentstring").setup({ enable_autocmd = false })
  require("mini.comment").setup({
    options = {
      custom_commentstring = function() return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring end,
    },
  })

  require("mini.pairs").setup() -- auto-close brackets/quotes
  require("mini.surround").setup() -- add/change/delete surrounding pairs (sa/sd/sr)
  require("mini.bufremove").setup() -- delete buffers without closing windows
  require("mini.move").setup() -- move lines/selections with Alt+hjkl
  require("mini.splitjoin").setup() -- gS: toggle args/lists between one line and many
  require("mini.align").setup() -- ga/gA: interactive alignment

  -- Extended a/i text objects (custom: f = function, g = whole buffer)
  local miniai = require("mini.ai")
  miniai.setup({
    custom_textobjects = {
      f = miniai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
      -- Whole buffer.
      g = function()
        local from = { line = 1, col = 1 }
        local to = { line = vim.fn.line("$"), col = math.max(vim.fn.getline("$"):len(), 1) }
        return { from = from, to = to }
      end,
    },
  })

  -- Highlight trailing whitespace; <leader>x trims it plus trailing blank lines
  require("mini.trailspace").setup()
  vim.keymap.set("n", "<leader>x", function()
    MiniTrailspace.trim()
    MiniTrailspace.trim_last_lines()
  end, { desc = "Trim trailing whitespace" })
end)

later(function()
  -- Git gutter signs + hunk ops. Sign style (not number colouring) to match the
  -- previous gutter; `ih` is the hunk textobject; ]c/[c jump hunks (native diff
  -- motions win inside :diffthis windows).
  local MiniDiff = require("mini.diff")
  MiniDiff.setup({
    view = {
      style = "sign",
      signs = { add = "▎", change = "▎", delete = "" },
    },
    mappings = { textobject = "ih" },
  })

  -- :Git command, line history and blame-like inspection
  local MiniGit = require("mini.git")
  MiniGit.setup()

  local map = vim.keymap.set

  local function goto_hunk(direction)
    return function()
      if vim.wo.diff then return vim.cmd.normal({ direction == "next" and "]c" or "[c", bang = true }) end
      MiniDiff.goto_hunk(direction)
    end
  end
  map("n", "]c", goto_hunk("next"), { desc = "Next hunk" })
  map("n", "[c", goto_hunk("prev"), { desc = "Prev hunk" })

  -- Apply/reset the hunk under the cursor (normal) or every hunk touching the selection (visual)
  local function cursor_range()
    local line = vim.fn.line(".")
    return { line_start = line, line_end = line }
  end
  local function visual_range()
    local from, to = vim.fn.line("."), vim.fn.line("v")
    return { line_start = math.min(from, to), line_end = math.max(from, to) }
  end
  local function do_hunks(action, range_fn)
    return function()
      MiniDiff.do_hunks(0, action, range_fn())
      if vim.fn.mode() ~= "n" then vim.cmd("normal! \27") end
    end
  end
  map("n", "<leader>hs", do_hunks("apply", cursor_range), { desc = "Stage hunk" })
  map("x", "<leader>hs", do_hunks("apply", visual_range), { desc = "Stage hunk" })
  map("n", "<leader>hr", do_hunks("reset", cursor_range), { desc = "Reset hunk" })
  map("x", "<leader>hr", do_hunks("reset", visual_range), { desc = "Reset hunk" })
  map("n", "<leader>hS", function() MiniDiff.do_hunks(0, "apply") end, { desc = "Stage buffer" })
  map("n", "<leader>hR", function() MiniDiff.do_hunks(0, "reset") end, { desc = "Reset buffer" })
  map("n", "<leader>hp", function() MiniDiff.toggle_overlay(0) end, { desc = "Toggle hunk overlay" })

  -- Hunks -> quickfix (current buffer / all buffers)
  local function hunks_to_qf(scope)
    return function()
      vim.fn.setqflist(MiniDiff.export("qf", { scope = scope }))
      vim.cmd("copen")
    end
  end
  map("n", "<leader>hq", hunks_to_qf("current"), { desc = "Hunks to quickfix" })
  map("n", "<leader>hQ", hunks_to_qf("all"), { desc = "All hunks to quickfix" })

  -- History/blame: line history at cursor, selected range history, file diffs
  map("n", "<leader>hb", function() MiniGit.show_at_cursor() end, { desc = "Line history / show at cursor" })
  map("x", "<leader>hb", function() MiniGit.show_range_history() end, { desc = "Range history" })
  map("n", "<leader>hd", "<cmd>vertical Git diff -- %<CR>", { desc = "Diff file (unstaged)" })
  map("n", "<leader>hD", "<cmd>vertical Git diff --cached -- %<CR>", { desc = "Diff file (staged)" })
end)

later(function()
  -- Side-by-side diff/merge UI; q closes it from the file panel
  add({ source = "sindrets/diffview.nvim", depends = { "nvim-lua/plenary.nvim" } })
  require("diffview").setup()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "DiffviewFiles",
    callback = function(args) vim.keymap.set("n", "q", "<cmd>DiffviewClose<CR>", { buffer = args.buf, desc = "Close Diffview" }) end,
  })

  -- Echo Neogit's own log (incl. failed actions) to :messages. Set before the
  -- plugin loads so its logger reads it. Any non-nil value enables it.
  vim.env.NEOGIT_LOG_CONSOLE = "true"
  vim.env.NEOGIT_LOG_LEVEL = "warn" -- errors/warnings only; drop info chatter

  -- Soft-wrap long lines in the Neogit status buffer
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "NeogitStatus",
    callback = function() vim.wo[0][0].wrap = true end,
  })

  -- Neogit's process console (bufhidden="hide") keeps its terminal channel
  -- when dismissed. The next console reuses the same-named buffer and calls
  -- nvim_open_term on it again -> "Terminal already connected" crash. Wipe
  -- the hidden buffer so it's never reused with a live terminal.
  vim.api.nvim_create_autocmd("BufHidden", {
    callback = function(args)
      if vim.bo[args.buf].filetype ~= "NeogitConsole" then return end
      vim.schedule(function() pcall(vim.api.nvim_buf_delete, args.buf, { force = true }) end)
    end,
  })

  -- Magit-style git interface; <leader>g opens status (uses mini.pick + diffview)
  add({ source = "NeogitOrg/neogit", depends = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" } })
  require("neogit").setup({
    kind = "auto",
    -- Build the log graph from the commit list itself. The default "ascii"
    -- style runs a separate `git log --graph` command whose commit set can
    -- diverge from the main log under --max-count on merge histories,
    -- throwing "No commit found for oid" in parse_log. "unicode" derives the
    -- graph from the same commits, so oids always resolve.
    graph_style = "unicode",
    signs = {
      --{ CLOSED, OPENED }
      hunk = { "", "" },
      item = { "▸", "▾" },
      section = { "▸", "▾" },
    },
    integrations = {
      telescope = nil,
      diffview = true,
      -- Route finders through vim.ui.select (wired to MiniPick.ui_select in
      -- picker.lua) instead of neogit's native mini_pick integration. The
      -- native path (finder.lua) starts the picker with only a `choose`
      -- callback and no abort handler, so dismissing a picker never resumes
      -- neogit's async coroutine and the action stalls silently. ui_select
      -- calls on_choice(nil) on cancel, so the coroutine resumes cleanly.
      mini_pick = false,
    },
    mappings = {
      popup = { ["l"] = false, ["L"] = "LogPopup" },
      status = { ["l"] = "OpenFold" },
    },
  })
  vim.keymap.set("n", "<leader>g", "<Cmd>Neogit<CR>", { desc = "Open Neogit" })
end)
