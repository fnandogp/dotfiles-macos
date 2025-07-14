--- AI assistant utilities for CodeCompanion integration
--- Provides helper functions for managing file references and path operations
local M = {}

--- Add a file path to an active CodeCompanion chat session.
--- Prevents duplicate file references and provides user feedback.
--- @param file_path string The absolute path to the file to add
--- @param chat table The CodeCompanion chat instance with references
--- @return nil
M.add_file_path_to_chat = function(file_path, chat)
  -- Check if file is already referenced in the chat
  for _, ref in ipairs(chat.refs) do
    if ref.path == file_path then return vim.notify("Already added", vim.log.levels.INFO) end
  end

  -- Create file reference object for CodeCompanion
  local ref = {
    id = "<file>" .. file_path .. "</file>",
    path = file_path,
    source = "codecompanion.strategies.chat.slash_commands.file",
    opts = { pinned = true },
  }
  chat.references:add(ref)
end

--- List file paths from a given directory or return single file path.
--- Handles both files and directories with shallow directory traversal.
--- @param path string The path to list (file or directory)
--- @return table List of file paths or empty table if path doesn't exist
M.list_file_paths = function(path)
  local stat = vim.uv.fs_stat(path)

  if stat == nil then
    print("Path does not exist")
    return {}
  end

  -- Handle directory: list all files (depth 1)
  if stat.type == "directory" then
    local paths = {}
    for item in vim.fs.dir(path, { depth = 1 }) do
      local item_path = vim.fs.joinpath(path, item)
      local item_stat = vim.uv.fs_stat(item_path)
      if item_stat ~= nil and item_stat.type == "file" then paths[#paths + 1] = item_path end
    end
    return paths
  end

  -- Handle single file
  if stat.type == "file" then return { path } end

  return {}
end

return M
