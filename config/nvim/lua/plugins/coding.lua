-- Editing utilities: mini.* modules (comment/pairs/surround/bufremove/move/ai)
-- plus the git toolset (gitsigns, diffview, fugitive, neogit).
return {
  -- Toggle comments; commentstring resolved per-context via treesitter (e.g. JSX vs JS)
  {
    "nvim-mini/mini.comment",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring", opts = { enable_autocmd = false } },
    version = false,
    opts = {
      options = {
        custom_commentstring = function() return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring end,
      },
    },
  },
  { "nvim-mini/mini.pairs", version = false, opts = {} }, -- auto-close brackets/quotes
  { "nvim-mini/mini.surround", version = false, opts = {} }, -- add/change/delete surrounding pairs
  { "nvim-mini/mini.bufremove", version = false, opts = {} }, -- delete buffers without closing windows
  { "nvim-mini/mini.move", version = false, opts = {} }, -- move lines/selections with Alt+hjkl
  -- Extended a/i text objects (custom: f = function, g = whole buffer)
  {
    "nvim-mini/mini.ai",
    version = false,
    opts = function()
      local miniai = require("mini.ai")
      return {
        custom_textobjects = {
          f = miniai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          -- Whole buffer.
          g = function()
            local from = { line = 1, col = 1 }
            local to = { line = vim.fn.line("$"), col = math.max(vim.fn.getline("$"):len(), 1) }
            return { from = from, to = to }
          end,
        },
      }
    end,
  },
  -- Git gutter signs + hunk navigation/staging keymaps (all under <leader>h)
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end
        -- Navigation: ]c/[c jump hunks (defer to native diff motions when in diff mode)
        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end)
        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end)
        -- Actions
        map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage Hunk" })
        map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset Hunk" })
        map("v", "<leader>hs", function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Stage Hunk" })
        map("v", "<leader>hr", function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Reset Hunk" })
        map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage Buffer" })
        map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset Buffer" })
        map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview Hunk" })
        map("n", "<leader>hi", gitsigns.preview_hunk_inline or function() end, { desc = "Preview Hunk Inline" })
        map("n", "<leader>hb", function() gitsigns.blame_line({ full = true }) end, { desc = "Blame Line" })
        map("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff This" })
        map("n", "<leader>hD", function() gitsigns.diffthis("~") end, { desc = "Diff This ~" })
        map("n", "<leader>hQ", function() gitsigns.setqflist("all") end, { desc = "Set Quickfix List" })
        map("n", "<leader>hq", gitsigns.setqflist, { desc = "Set Quickfix List" })
        -- Text object
        map({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "Select Hunk" })
      end,
    },
  },
  -- Side-by-side diff/merge UI; q closes it from the file panel
  { "sindrets/diffview.nvim", opts = {}, keys = {
    { "q", "<cmd>DiffviewClose<CR>", desc = "Close Diffview", mode = "n", ft = "DiffviewFiles" },
  } },
  { "tpope/vim-fugitive" }, -- classic git command wrapper (:Git ...)
  -- Magit-style git interface; <leader>g opens status (uses mini.pick + diffview)
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-mini/mini.pick",
    },
    opts = {
      kind = "auto",
      graph_style = "unicode",
      signs = {
        --{ CLOSED, OPENED }
        hunk = { "", "" },
        item = { "▸", "▾" },
        section = { "▸", "▾" },
      },
      integrations = {
        telescope = false,
        diffview = true,
        mini_pick = true,
      },
      mappings = {
        popup = {
          ["l"] = false,
          ["L"] = "LogPopup",
        },
        status = {
          ["l"] = "OpenFold",
        },
      },
    },

    keys = {
      { "<leader>g", "<Cmd>Neogit<CR>", desc = "Open Neogit", mode = "n" },
    },

    -- Soft-wrap long lines in the Neogit status buffer
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "NeogitStatus",
        callback = function(args) vim.wo[0][0].wrap = true end,
      })
    end,
  },
}
