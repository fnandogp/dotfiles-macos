local M = {}

M.add_file_path_to_chat = function(file_path, chat)
  for _, ref in ipairs(chat.refs) do
    if ref.path == file_path then return vim.notify("Already added", vim.log.levels.INFO) end
  end

  local ref = {
    id = "<file>" .. file_path .. "</file>",
    path = file_path,
    source = "codecompanion.strategies.chat.slash_commands.file",
    opts = { pinned = true },
  }
  chat.references:add(ref)
end

M.list_file_paths = function(path)
  local stat = vim.uv.fs_stat(path)

  if stat == nil then return print("Path does not exist") end

  if stat.type == "directory" then
    local paths = {}
    for item in vim.fs.dir(path, { depth = 1 }) do
      local item_path = vim.fs.joinpath(path, item)
      local item_stat = vim.uv.fs_stat(item_path)
      if item_stat ~= nil and item_stat.type == "file" then paths[#paths + 1] = item_path end
    end
    return paths
  end

  if stat.type == "file" then return { path } end

  return {}
end

return M
