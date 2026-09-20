-- Per-project file bookmarks built on mini.visits.
-- Bookmarks are visits tagged with a "bookmark" label, scoped to cwd.
-- Provides add/remove/toggle, a picker view, cyclic nav, and slots 1-4.
local later = MiniDeps.later

later(function()
  local MiniVisits = require("mini.visits")
  MiniVisits.setup()

  -- Label used to mark a visit as a bookmark
  local BOOKMARK_LABEL = "bookmark"

  -- Current buffer's absolute path, or nil (with a warning) for unnamed buffers
  local function current_file()
    local path = vim.fn.expand("%:p")
    if path == "" then
      vim.notify("No file in current buffer", vim.log.levels.WARN)
      return nil
    end
    return path
  end

  local function has_bookmark(path, project_dir) return vim.tbl_contains(MiniVisits.list_labels(path, project_dir), BOOKMARK_LABEL) end

  -- All bookmarked paths for the current project, in mini.visits order
  local function bookmarked_paths()
    local project_dir = vim.fn.getcwd()
    return vim.tbl_filter(function(path) return has_bookmark(path, project_dir) end, MiniVisits.list_paths(project_dir))
  end

  local function add_bookmark()
    local path = current_file()
    if not path then return end
    MiniVisits.add_label(BOOKMARK_LABEL, path, vim.fn.getcwd())
    vim.notify("Added bookmark", vim.log.levels.INFO)
  end

  local function remove_bookmark()
    local path = current_file()
    if not path then return end
    MiniVisits.remove_label(BOOKMARK_LABEL, path, vim.fn.getcwd())
    vim.notify("Removed bookmark", vim.log.levels.INFO)
  end

  local function toggle_bookmark()
    local path = current_file()
    if not path then return end
    if has_bookmark(path, vim.fn.getcwd()) then return remove_bookmark() end
    add_bookmark()
  end

  -- Show only bookmarked files in a mini.pick picker
  local function show_bookmarks()
    local paths = bookmarked_paths()
    if #paths == 0 then return vim.notify("No bookmarked files in this project", vim.log.levels.INFO) end
    require("mini.pick").start({
      source = {
        items = paths,
        name = "Bookmarks (" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. ")",
      },
    })
  end

  -- Navigate through bookmarked files only; bookmark_index persists across calls
  local bookmark_index = 1
  local function navigate_bookmarks(direction)
    local paths = bookmarked_paths()
    if #paths == 0 then return vim.notify("No bookmarked files in this project", vim.log.levels.INFO) end

    -- Wrap around either end of the list
    if direction == "forward" then
      bookmark_index = bookmark_index % #paths + 1
    else
      bookmark_index = bookmark_index == 1 and #paths or bookmark_index - 1
    end
    vim.cmd("edit " .. vim.fn.fnameescape(paths[bookmark_index]))
  end

  -- Direct access to bookmarked files by ordinal position (1-based)
  local function goto_bookmark(number)
    local paths = bookmarked_paths()
    if #paths < number then return vim.notify("Bookmark " .. number .. " doesn't exist", vim.log.levels.WARN) end
    bookmark_index = number
    vim.cmd("edit " .. vim.fn.fnameescape(paths[number]))
  end

  local map = vim.keymap.set
  map("n", "<leader>va", add_bookmark, { desc = "Add bookmark" })
  map("n", "<leader>vd", remove_bookmark, { desc = "Delete bookmark" })
  map("n", "<leader>vt", toggle_bookmark, { desc = "Toggle bookmark" })
  map("n", "<leader>vv", show_bookmarks, { desc = "Show bookmarks" })
  map("n", "<leader>vj", function() navigate_bookmarks("forward") end, { desc = "Next bookmark" })
  map("n", "<leader>vk", function() navigate_bookmarks("backward") end, { desc = "Previous bookmark" })
  for slot = 1, 4 do
    map("n", "<leader>v" .. slot, function() goto_bookmark(slot) end, { desc = "Goto bookmark " .. slot })
  end
end)
