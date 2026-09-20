-- Note-taking: obsidian.nvim over Obsidian vaults in ~/Documents/Vaults.
-- Two workspaces (work/personal), Zettelkasten note IDs, daily notes.
local add, later = MiniDeps.add, MiniDeps.later

later(function()
  add({ source = "obsidian-nvim/obsidian.nvim", depends = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" } })
  require("obsidian").setup({
    legacy_commands = false,
    -- Disable built-in concealing UI (render-markdown handles it)
    ui = { enable = false },
    -- Checkbox states cycled with the toggle command, in this order
    checkboxes = {
      order = { " ", "x", "-", "~", "?" },
    },
    workspaces = {
      { name = "work", path = "~/Documents/Vaults/Work/" },
      { name = "personal", path = "~/Documents/Vaults/Personal/" },
    },
    daily_notes = {
      folder = "dailies",
      date_format = "%Y-%m-%d",
      alias_format = "%A, %B %-d, %Y",
      default_tags = { "daily-notes" },
    },
    -- Zettelkasten IDs: '<unix time>-<slugified title>' or 4 random uppercase letters when untitled
    ---@param title string|?
    ---@return string
    note_id_func = function(title)
      local suffix = ""
      if title ~= nil then
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return tostring(os.time()) .. "-" .. suffix
    end,
  })

  local map = vim.keymap.set
  map("n", "<Leader>nn", "<cmd>Obsidian new<CR>", { desc = "Create an Obsidian note" })
  map("n", "<Leader>nf", "<cmd>Obsidian quick_switch<CR>", { desc = "Find an Obsidian note" })
  map("n", "<Leader>ns", "<cmd>Obsidian search<CR>", { desc = "Search for an Obsidian note" })
  map("n", "<Leader>nl", "<cmd>Obsidian links<CR>", { desc = "List Obsidian links" })
  map("n", "<Leader>nb", "<cmd>Obsidian backlinks<CR>", { desc = "List Obsidian back links" })
  map("n", "<Leader>nt", "<cmd>Obsidian today<CR>", { desc = "Create a new daily note in Obsidian" })
end)
