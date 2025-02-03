return {
  { "preservim/nerdcommenter" },
  { "echasnovski/mini.pairs", version = false, opts = {} },
  { "echasnovski/mini.surround", version = false, opts = {} },
  { "echasnovski/mini.bufremove", version = false, opts = {} },
  { "echasnovski/mini.move", version = false, opts = {} },
  { "echasnovski/mini.ai", version = false, opts = {} },
  { "echasnovski/mini-git", version = false, main = "mini.git", opts = {} },
  { "echasnovski/mini.diff", version = false, opts = {} },
  { "sindrets/diffview.nvim", opts = {}, keys = {
    { "q", "<cmd>DiffviewClose<CR>", desc = "Close Diffview", mode = "n", ft = "DiffviewFiles" },
  } },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "echasnovski/mini.pick",
    },
    opts = {
      kind = "auto",
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
    },
    keys = {
      { "<leader>g", "<Cmd>Neogit<CR>", desc = "Open Neogit", mode = "n" },
    },
  },
  {
    "Exafunction/codeium.nvim",
    cmd = "Codeium",
    event = "InsertEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      enable_cmp_source = false,
      virtual_text = {
        enabled = true,
        manual = false,
        key_bindings = {
          -- Accept the current completion.
          accept = "<A-y>",
          -- Dismiss the current completion.
          dismiss = "<A-n>",
        },
      },
    },
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
    opts = {
      display = { action_palette = { provider = "mini_pick" } },
      strategies = { chat = { adapter = "r1_8b" }, inline = { adapter = "r1_8b" } },
      adapters = {
        r1_8b = function()
          return require("codecompanion.adapters").extend("ollama", {
            name = "r1_8b",
            schema = { model = { default = "deepseek-r1:8b" }, num_ctx = { default = 16384 }, num_predict = { default = -1 } },
          })
        end,
        r1_32b = function()
          return require("codecompanion.adapters").extend("ollama", {
            name = "r1_32b",
            schema = { model = { default = "deepseek-r1:32b" }, num_ctx = { default = 16384 }, num_predict = { default = -1 } },
          })
        end,
      },
    },
    keys = {
      { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Code Companion Chat", mode = { "n", "v" } },
      { "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "Code Companion Actions", mode = { "n", "v" } },
    },
  },
}
