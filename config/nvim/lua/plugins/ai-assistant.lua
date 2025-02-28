return {
  {
    "Exafunction/codeium.nvim",
    cmd = "Codeium",
    event = "InsertEnter",
    dependencies = { "nvim-lua/plenary.nvim", "echasnovski/mini.diff" },
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
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter", "echasnovski/mini.pick" },
    opts = {
      display = { action_palette = { provider = "mini_pick" } },
      strategies = {
        chat = {
          adapter = "gemini",
          keymaps = {
            send = { modes = { n = "<C-s>", i = "<C-s>" } },
            close = { modes = { n = "q" } },
          },
        },
        inline = { adapter = "gemini" },
      },
      adapters = {
        coder = function()
          return require("codecompanion.adapters").extend("ollama", {
            name = "coder",
            schema = { model = { default = "deepseek-coder:6.7b" }, num_ctx = { default = 16384 }, num_predict = { default = -1 } },
          })
        end,
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
      { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Code Companion Chat", mode = { "n", "v" } },
      { "<leader>aA", "<cmd>CodeCompanionChat Add<cr>", desc = "Code Companion Chat Add", mode = { "v" } },
      { "<leader>ae", "<cmd>'<,'>CodeCompanion<cr>", desc = "Code Companion Inline", mode = { "v" } },
      { "<leader>ax", "<cmd>CodeCompanionActions<cr>", desc = "Code Companion Actions", mode = { "n", "v" } },
    },
  },
}
