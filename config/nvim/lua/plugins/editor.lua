-- Editor enhancements. now(): sessions + start screen (need VimEnter).
-- later(): highlighting, animation, indent guides, bracketed nav, jump labels,
-- zoom/auto-root, folds, search/replace, outline, tree navigation, HTTP client,
-- tmux pane navigation.
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
  -- Sessions: one global session per (cwd, git branch), auto-read on a bare
  -- `nvim` inside a session dir, auto-written on exit. Local Session.vim disabled.
  local MiniSessions = require("mini.sessions")
  MiniSessions.setup({
    autoread = false, -- handled below so it is scoped to session_dirs
    autowrite = true,
    file = "",
    verbose = { read = false, write = false, delete = true },
  })

  local session_dirs = { "~/.dotfiles", "~/workspace/" }
  local function in_session_dir()
    local cwd = vim.fn.getcwd()
    for _, dir in ipairs(session_dirs) do
      if vim.startswith(cwd, vim.fn.expand(dir)) then return true end
    end
    return false
  end

  -- Session file name: cwd path with "/" -> "%", plus "@@branch" when in a git repo
  local function session_name()
    local cwd = vim.fn.getcwd()
    local branch = vim.fn.systemlist({ "git", "-C", cwd, "rev-parse", "--abbrev-ref", "HEAD" })[1]
    local name = (cwd:gsub("/", "%%"))
    if vim.v.shell_error == 0 and branch and branch ~= "" then name = name .. "@@" .. (branch:gsub("/", "%%")) end
    return name
  end

  vim.keymap.set("n", "<leader>S", function() MiniSessions.select() end, { desc = "Select session" })

  -- Start screen: sessions, recent files in cwd, pickers, builtin actions
  local MiniStarter = require("mini.starter")
  MiniStarter.setup({
    autoopen = false, -- opened below only when no session is auto-read
    evaluate_single = true,
    items = {
      MiniStarter.sections.sessions(5, true),
      MiniStarter.sections.recent_files(5, true, false),
      MiniStarter.sections.pick(),
      MiniStarter.sections.builtin_actions(),
    },
    content_hooks = {
      MiniStarter.gen_hook.adding_bullet(),
      MiniStarter.gen_hook.indexing("all", { "Builtin actions" }),
      MiniStarter.gen_hook.aligning("center", "center"),
    },
  })

  -- Bare `nvim`: read the matching session, or start tracking a new one and show the start screen
  vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    nested = true,
    callback = function()
      -- Skip when files were given or the buffer already has content (stdin)
      if vim.fn.argc() > 0 or vim.fn.line2byte("$") ~= -1 then return end

      if in_session_dir() then
        local name = session_name()
        if MiniSessions.detected[name] then return MiniSessions.read(name) end
        MiniSessions.write(name)
      end
      MiniStarter.open()
    end,
  })
end)

later(function()
  -- Highlight hex colours and TODO/FIXME/HACK/NOTE words
  local hipatterns = require("mini.hipatterns")
  hipatterns.setup({
    highlighters = {
      fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
      hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
      todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
      note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  })

  -- Animated cursor/window transitions; scroll animation disabled (jarring with stay-centered)
  require("mini.animate").setup({ scroll = { enable = false } })

  -- Indent guide for the current scope; ii/ai textobjects, [i/]i motions
  require("mini.indentscope").setup({
    symbol = "│",
    options = { try_as_border = true },
  })
  vim.api.nvim_create_autocmd("FileType", {
    pattern = {
      "help",
      "ministarter",
      "minifiles",
      "toggleterm",
      "NeogitStatus",
      "NeogitPopup",
      "DiffviewFiles",
      "grug-far",
      "Outline",
      "kulala_ui",
      "markdown",
    },
    callback = function() vim.b.miniindentscope_disable = true end,
  })

  -- Unified ]x/[x navigation. comment/indent/undo disabled: ]c is hunks (mini.diff),
  -- ]i is mini.indentscope, undo would remap u/<C-r>.
  require("mini.bracketed").setup({
    comment = { suffix = "" },
    indent = { suffix = "" },
    undo = { suffix = "" },
  })

  -- Label-based jumping: <CR> in normal/visual/operator-pending shows labels
  require("mini.jump2d").setup({
    view = { dim = true, n_steps_ahead = 2 },
  })
  -- Quickfix/location lists need <CR> to open the entry
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "qf",
    callback = function(args) vim.keymap.set("n", "<CR>", "<CR>", { buffer = args.buf }) end,
  })

  -- Zoom (<leader>z), restore cursor on reopen, cwd follows the project root
  local MiniMisc = require("mini.misc")
  MiniMisc.setup()
  MiniMisc.setup_restore_cursor()
  MiniMisc.setup_auto_root()
  vim.keymap.set("n", "<leader>z", function()
    local width = math.min(150, vim.o.columns)
    MiniMisc.zoom(0, { width = width, col = math.floor((vim.o.columns - width) / 2) })
  end, { desc = "Toggle zoom" })

  -- Nicer folding UX; start fully unfolded (foldlevel 99, set in options.lua)
  add("chrisgrieser/nvim-origami")
  require("origami").setup()

  -- Project-wide find & replace UI (buffer-based, ripgrep backed)
  add("MagicDuck/grug-far.nvim")
  require("grug-far").setup()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "grug-far",
    callback = function(args) vim.keymap.set("n", "q", "<cmd>q<CR>", { buffer = args.buf, desc = "Close GrugFar" }) end,
  })
  local map = vim.keymap.set
  map("n", "<leader>ss", "<cmd>GrugFar<CR>", { desc = "Open GrugFar" })
  map("n", "<leader>sf", function() require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } }) end, { desc = "GrugFar: current file" })
  map("x", "<leader>sw", function() require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } }) end, { desc = "GrugFar: word under cursor" })
  map(
    "x",
    "<leader>sf",
    function() require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>"), paths = vim.fn.expand("%") } }) end,
    { desc = "GrugFar: word, current file" }
  )

  -- Symbol/code outline sidebar (LSP symbols)
  add({ source = "hedyhli/outline.nvim", depends = { "onsails/lspkind.nvim" } })
  require("outline").setup({
    symbols = { icon_source = "lspkind" },
    symbol_folding = { auto_unfold = { only = 2 } },
  })
  map("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })

  -- Keeps cursor vertically centred; skipped in terminal/file-tree buffers
  add("arnamak/stay-centered.nvim")
  require("stay-centered").setup({ skip_filetypes = { "toggleterm", "minifiles" } })

  -- Move/swap by treesitter nodes; <tab>+hjkl navigates the syntax tree
  add("aaronik/treewalker.nvim")
  require("treewalker").setup()
  map("n", "<tab>h", "<cmd>Treewalker Left<CR>")
  map("n", "<tab>j", "<cmd>Treewalker Down<CR>")
  map("n", "<tab>k", "<cmd>Treewalker Up<CR>")
  map("n", "<tab>l", "<cmd>Treewalker Right<CR>")

  -- Prettier rendering of :help / vimdoc buffers
  add("OXY2DEV/helpview.nvim")
  require("helpview").setup()

  -- HTTP/REST client for .http files; <leader>r prefix runs requests, env scoped globally
  add("mistweaverco/kulala.nvim")
  require("kulala").setup({
    global_keymaps = true,
    global_keymaps_prefix = "<leader>r",
    kulala_keymaps_prefix = "",
    kulala_keymaps = {
      ["Show verbose"] = { "!", function() require("kulala.ui").show_verbose() end },
      -- Free <C-h>/<C-l> for window navigation inside the response window
      ["Previous tab"] = false,
      ["Next tab"] = false,
    },
    environment_scope = "g",
    lsp = { keymaps = true }, -- .http document symbols / format / hover
    ui = {
      max_response_size = 10 * 1000 * 1000,
    },
  })

  -- Seamless <c-hjkl> movement between nvim splits and tmux panes
  add("christoomey/vim-tmux-navigator")
  map("n", "<c-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Navigate to left tmux pane" })
  map("n", "<c-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Navigate to bottom tmux pane" })
  map("n", "<c-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Navigate to top tmux pane" })
  map("n", "<c-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Navigate to right tmux pane" })
  map("n", "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>", { desc = "Navigate to previous tmux pane" })
end)
