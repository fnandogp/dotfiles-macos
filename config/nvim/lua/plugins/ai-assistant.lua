return {
  {
    "Exafunction/codeium.nvim",
    cmd = "Codeium",
    event = "InsertEnter",
    dependencies = { "nvim-lua/plenary.nvim", "j-hui/fidget.nvim" },
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
    },
    init = function() require("plugins.utils.fidget-spinner"):init() end,
    opts = {
      display = {
        chat = { show_settings = true },
        action_palette = { provider = "mini_pick" },
      },
      strategies = {
        chat = {
          adapter = "gemini",
          keymaps = {
            send = { modes = { n = "<C-s>", i = "<C-s>" } },
          },
        },
        inline = {
          adapter = "gemini",
        },
      },
      adapters = {
        gemini2_5 = function()
          return require("codecompanion.adapters").extend("gemini", {
            schema = { model = { default = "gemini-2.5-pro-exp-03-25" } },
          })
        end,
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
          strategy = "chat",
          description = "Improve writing and fix grammar in Markdown",
          prompts = {
            {
              role = "system",
              content = [[
You are an expert editor specializing in improving technical writing and documentation written in Markdown.
Your goal is to enhance clarity, conciseness, and grammatical correctness while preserving the original meaning and structure.
You understand Markdown syntax and must leave content within code blocks (```...``` or `...`) and blockquotes (> ...) unchanged.
Adhere strictly to all user constraints.
              ]],
            },
            {
              role = "user",
              content = [[
Review and improve the following text for grammar, style, and clarity.

**Constraints:**
*   Preserve the original meaning.
*   Do NOT modify content inside Markdown code blocks or blockquotes.
*   Wrap lines to a maximum of 80 characters.
*   Return ONLY the revised text, without any preamble, explanation, or Markdown code block formatting.
              ]],
            },
          },
        },
      },
    },
    keys = {
      { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle Code Companion Chat", mode = { "n" } },
      { "<leader>aa", "<cmd>CodeCompanionChat Add<cr>", desc = "Toggle Code Companion Chat", mode = { "v" } },
      { "<leader>an", "<cmd>CodeCompanionChat<cr>", desc = "Start new Code Companion Chat", mode = { "n" } },
      { "<leader>ae", "<cmd>'<,'>CodeCompanion<cr>", desc = "Code Companion Inline", mode = { "v" } },
      { "<leader>ax", "<cmd>CodeCompanionActions<cr>", desc = "Code Companion Actions", mode = { "n", "v" } },
    },
  },
}
