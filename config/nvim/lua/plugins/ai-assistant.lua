return {
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
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.pick",
      "echasnovski/mini.diff",
    },
    opts = {
      display = {
        action_palette = { provider = "mini_pick" },
        diff = {
          enabled = true,
          close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
          layout = "vertical", -- vertical|horizontal split for default provider
          opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
          provider = "mini_diff",
        },
      },
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
      prompt_library = {
        ["Improve writing"] = {
          strategy = "inline",
          description = "Improve writing",
          prompts = {
            {
              role = "system",
              content = "You are a writer and uses Oblision as you writing editor, therefore use only markdown files.",
            },
            {
              role = "user",
              content = [[
                Fix grammar and improve writing.
                Do not change the content of codeblocks and quotes.
                Return the text only and no markdown codeblocks.
                Lines must not be longer than 80 characters.
              ]],
            },
          },
        },
      },
    },
    keys = {
      { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle Code Companion Chat", mode = { "n" } },
      { "<leader>aa", "<cmd>CodeCompanionChat<cr>", desc = "Start new Code Companion Chat", mode = { "n", "v" } },
      { "<leader>ae", "<cmd>'<,'>CodeCompanion<cr>", desc = "Code Companion Inline", mode = { "v" } },
      { "<leader>ax", "<cmd>CodeCompanionActions<cr>", desc = "Code Companion Actions", mode = { "n", "v" } },
    },
  },
}
