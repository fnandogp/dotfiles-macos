return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  ft = "markdown",
  event = {
    "BufReadPre " .. vim.fn.expand("~") .. "/Documents/Vaults/*.md",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "echasnovski/mini.pick",
  },
  opts = {
    ui = {
      enable = false,
      checkboxes = {
        [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
        ["x"] = { char = "", hl_group = "ObsidianDone" },
        ["-"] = { char = "", hl_group = "ObsidianRightArrow" },
        ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
        ["?"] = { char = "", hl_group = "ObsidianImportant" },
      },
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
    { "<Leader>nn", "<cmd>ObsidianNew<CR>", desc = "Create an Obsidian note" },
    { "<Leader>nf", "<cmd>ObsidianQuickSwitch<CR>", desc = "Find an Obsidian note" },
    { "<Leader>ns", "<cmd>ObsidianSearch<CR>", desc = "Search for an Obsidian note" },
    { "<Leader>nl", "<cmd>ObsidianLinks<CR>", desc = "List Obsidian links" },
    { "<Leader>nb", "<cmd>ObsidianBackLinks<CR>", desc = "List Obsidian back links" },
    { "<Leader>nt", "<cmd>ObsidianToday<CR>", desc = "Create a new daily note in Obsidian" },
  },
}
