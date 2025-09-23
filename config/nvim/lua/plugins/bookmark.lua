return {
  "nvim-mini/mini.visits",
  version = false,
  config = function()
    local MiniVisits = require("mini.visits")
    local MiniExtra = require("mini.extra")

    MiniVisits.setup()

    local BOOKMARK_LABEL = "bookmark"

    -- Add bookmark to current file
    local function add_bookmark()
      local current_file = vim.fn.expand("%:p")
      if current_file == "" then
        vim.notify("No file in current buffer", vim.log.levels.WARN)
        return
      end

      local project_dir = vim.fn.getcwd()
      MiniVisits.add_label(BOOKMARK_LABEL, current_file, project_dir)
      vim.notify("Added bookmark", vim.log.levels.INFO)
    end

    -- Remove bookmark from current file
    local function remove_bookmark()
      local current_file = vim.fn.expand("%:p")
      if current_file == "" then
        vim.notify("No file in current buffer", vim.log.levels.WARN)
        return
      end

      local project_dir = vim.fn.getcwd()
      MiniVisits.remove_label(BOOKMARK_LABEL, current_file, project_dir)
      vim.notify("Removed bookmark", vim.log.levels.INFO)
    end

    -- Toggle bookmark on current file
    local function toggle_bookmark()
      local current_file = vim.fn.expand("%:p")
      if current_file == "" then
        vim.notify("No file in current buffer", vim.log.levels.WARN)
        return
      end

      local project_dir = vim.fn.getcwd()
      local labels = MiniVisits.list_labels(current_file, project_dir)

      local has_bookmark = false
      for _, label in ipairs(labels) do
        if label == BOOKMARK_LABEL then
          has_bookmark = true
          break
        end
      end

      if has_bookmark then
        MiniVisits.remove_label(BOOKMARK_LABEL, current_file, project_dir)
        vim.notify("Removed bookmark", vim.log.levels.INFO)
      else
        MiniVisits.add_label(BOOKMARK_LABEL, current_file, project_dir)
        vim.notify("Added bookmark", vim.log.levels.INFO)
      end
    end

    -- Show only bookmarked files
    local function show_bookmarks()
      local project_dir = vim.fn.getcwd()
      local all_paths = MiniVisits.list_paths(project_dir)
      local bookmarked_paths = {}

      for _, path in ipairs(all_paths) do
        local labels = MiniVisits.list_labels(path, project_dir)
        for _, label in ipairs(labels) do
          if label == BOOKMARK_LABEL then
            table.insert(bookmarked_paths, path)
            break
          end
        end
      end

      if #bookmarked_paths == 0 then
        vim.notify("No bookmarked files in this project", vim.log.levels.INFO)
        return
      end

      local MiniPick = require("mini.pick")
      MiniPick.start({
        source = {
          items = bookmarked_paths,
          name = "Bookmarks (" .. vim.fn.fnamemodify(project_dir, ":t") .. ")",
        },
      })
    end

    -- Navigate through bookmarked files only
    local bookmark_index = 1
    local function navigate_bookmarks(direction)
      local project_dir = vim.fn.getcwd()
      local all_paths = MiniVisits.list_paths(project_dir)
      local bookmarked_paths = {}

      for _, path in ipairs(all_paths) do
        local labels = MiniVisits.list_labels(path, project_dir)
        for _, label in ipairs(labels) do
          if label == BOOKMARK_LABEL then
            table.insert(bookmarked_paths, path)
            break
          end
        end
      end

      if #bookmarked_paths == 0 then
        vim.notify("No bookmarked files in this project", vim.log.levels.INFO)
        return
      end

      if direction == "forward" then
        bookmark_index = bookmark_index % #bookmarked_paths + 1
      else
        bookmark_index = bookmark_index == 1 and #bookmarked_paths or bookmark_index - 1
      end

      vim.cmd("edit " .. vim.fn.fnameescape(bookmarked_paths[bookmark_index]))
    end

    -- Direct access to bookmarked files by number
    local function goto_bookmark(number)
      local project_dir = vim.fn.getcwd()
      local all_paths = MiniVisits.list_paths(project_dir)
      local bookmarked_paths = {}

      for _, path in ipairs(all_paths) do
        local labels = MiniVisits.list_labels(path, project_dir)
        for _, label in ipairs(labels) do
          if label == BOOKMARK_LABEL then
            table.insert(bookmarked_paths, path)
            break
          end
        end
      end

      if #bookmarked_paths >= number then
        bookmark_index = number
        vim.cmd("edit " .. vim.fn.fnameescape(bookmarked_paths[number]))
      else
        vim.notify("Bookmark " .. number .. " doesn't exist", vim.log.levels.WARN)
      end
    end

    -- Set up keymaps
    vim.keymap.set("n", "<leader>va", add_bookmark, { desc = "Add bookmark" })
    vim.keymap.set("n", "<leader>vd", remove_bookmark, { desc = "Delete bookmark" })
    vim.keymap.set("n", "<leader>vt", toggle_bookmark, { desc = "Toggle bookmark" })
    vim.keymap.set("n", "<leader>vv", show_bookmarks, { desc = "Show bookmarks" })
    vim.keymap.set("n", "<leader>vj", function() navigate_bookmarks("forward") end, { desc = "Next bookmark" })
    vim.keymap.set("n", "<leader>vk", function() navigate_bookmarks("backward") end, { desc = "Previous bookmark" })
    vim.keymap.set("n", "<leader>v1", function() goto_bookmark(1) end, { desc = "Goto bookmark 1" })
    vim.keymap.set("n", "<leader>v2", function() goto_bookmark(2) end, { desc = "Goto bookmark 2" })
    vim.keymap.set("n", "<leader>v3", function() goto_bookmark(3) end, { desc = "Goto bookmark 3" })
    vim.keymap.set("n", "<leader>v4", function() goto_bookmark(4) end, { desc = "Goto bookmark 4" })
  end,
}