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
        filetypes = {
          Avante = false,
        },
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
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
      provider = "gemini_flash",
      providers = {
        gemini_flash = { __inherited_from = "gemini", model = "gemini-2.5-flash" },
        gemini_pro = { __inherited_from = "gemini", model = "gemini-2.5-pro" },
      },
    },
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
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
      "ravitemer/codecompanion-history.nvim",
      "j-hui/fidget.nvim",
    },
    init = function() require("plugins.utils.fidget-spinner"):init() end,
    opts = {
      display = {
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
      extensions = {
        history = {
          enabled = true,
          opts = {
            -- Keymap to open history from chat buffer (default: gh)
            keymap = "gh",
            -- Automatically generate titles for new chats
            auto_generate_title = true,
            ---On exiting and entering neovim, loads the last chat on opening chat
            continue_last_chat = false,
            ---When chat is cleared with `gx` delete the chat from history
            delete_on_clearing_chat = false,
            -- Picker interface ("telescope", "snacks" or "default")
            picker = "default",
            ---Enable detailed logging for history extension
            enable_logging = false,
            ---Directory path to save the chats
            dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
          },
        },
      },
    },
    config = function(_, opts)
      require("codecompanion").setup(opts)

      vim.api.nvim_create_user_command("CodeCompanionChatAddFile", function()
        local current_file_path = vim.api.nvim_buf_get_name(0)
        print(vim.inspect(current_file_path))
        require("codecompanion").last_chat().references:add({
          id = current_file_path,
          path = current_file_path,
          source = "codecompanion.strategies.chat.slash_commands.file",
          opts = { pinned = true },
        })
      end, { nargs = 0 })
    end,
    keys = {
      { "<leader>ct", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle Code Companion Chat", mode = { "n" } },
      { "<leader>cc", "<cmd>CodeCompanionChat Add<cr>", desc = "Toggle Code Companion Chat", mode = { "v" } },
      { "<leader>cc", "<cmd>CodeCompanionChat<cr>", desc = "Start new Code Companion Chat", mode = { "n" } },
      { "<leader>ce", "<cmd>'<,'>CodeCompanion<cr>", desc = "Code Companion Inline", mode = { "v" } },
      { "<leader>cx", "<cmd>CodeCompanionActions<cr>", desc = "Code Companion Actions", mode = { "n", "v" } },
      { "ga", "<cmd>CodeCompanionChatAddFile<cr>", desc = "Add current file to Code Companion Chat", mode = { "n" } },
    },
  },
}
