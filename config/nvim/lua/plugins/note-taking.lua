return {
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    ft = "markdown",
    event = {
      "BufReadPre " .. vim.fn.expand("~") .. "/Documents/Vaults/*.md",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-mini/mini.pick",
    },
    opts = {
      legacy_commands = false,
      ui = { enable = false },
      checkboxes = {
        order = { " ", "x", "-", "~", "?" },
      },
      workspaces = {
        { name = "work", path = "~/Documents/Vaults/Work/" },
        { name = "personal", path = "~/Documents/Vaults/Personal/" },
      },
      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = "dailies",
        -- Optional, if you want to change the date format for the ID of daily notes.
        date_format = "%Y-%m-%d",
        -- Optional, if you want to change the date format of the default alias of daily notes.
        alias_format = "%A, %B %-d, %Y",
        -- Optional, default tags to add to each new daily note created.
        default_tags = { "daily-notes" },
      },
      -- Optional, customize how note IDs are generated given an optional title.
      ---@param title string|?
      ---@return string
      note_id_func = function(title)
        -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
        -- In this case a note with the title 'My new note' will be given an ID that looks
        -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
        local suffix = ""
        if title ~= nil then
          -- If title is given, transform it into valid file name.
          suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        else
          -- If title is nil, just add 4 random uppercase letters to the suffix.
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return tostring(os.time()) .. "-" .. suffix
      end,
    },
    keys = {
      { "<Leader>nn", "<cmd>Obsidian new<CR>", desc = "Create an Obsidian note" },
      { "<Leader>nf", "<cmd>Obsidian quick_switch<CR>", desc = "Find an Obsidian note" },
      { "<Leader>ns", "<cmd>Obsidian search<CR>", desc = "Search for an Obsidian note" },
      { "<Leader>nl", "<cmd>Obsidian links<CR>", desc = "List Obsidian links" },
      { "<Leader>nb", "<cmd>Obsidian backlinks<CR>", desc = "List Obsidian back links" },
      { "<Leader>nt", "<cmd>Obsidian today<CR>", desc = "Create a new daily note in Obsidian" },
    },
  },
  -- {
  --   "3rd/diagram.nvim",
  --   dependencies = {
  --     {
  --       "3rd/image.nvim",
  --       opts = {
  --         integrations = {
  --           markdown = {
  --             only_render_image_at_cursor = true,
  --             only_render_image_at_cursor_mode = "inline", -- or "inline"
  --             floating_windows = true, -- if true, images will be rendered in floating markdown windows
  --           },
  --         },
  --         max_width_window_percentage = 80,
  --         max_height_window_percentage = 80,
  --         tmux_show_only_in_active_window = true, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
  --       },
  --     },
  --   },
  --   opts = {
  --     events = {
  --       render_buffer = { "InsertLeave", "BufWinEnter", "TextChanged" },
  --       clear_buffer = { "BufLeave" },
  --     },
  --     renderer_options = {
  --       mermaid = {
  --         background = "white", -- nil | "transparent" | "white" | "#hex"
  --         theme = "neutral", --| "dark" | "forest" | "neutral"
  --         -- scale = 1, -- nil | 1 (default) | 2 | 3 | ...
  --         -- width = 400, -- nil | 800 | 400 | ...
  --         -- height = nil, -- nil | 600 | 300 | ...
  --       },
  --     },
  --   },
  -- },
}
