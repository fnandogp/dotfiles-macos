local M = {}

--- Get the root directory of a Deno project
--- @param bufnr number Buffer number
--- @return string|nil
function M.get_deno_root_dir(bufnr)
  local path = vim.api.nvim_buf_get_name(bufnr)
  local config_file = vim.fs.find({ "deno.json", "deno.jsonc" }, {
    upward = true,
    path = path,
  })[1]
  return config_file and vim.fn.fnamemodify(config_file, ":h") or nil
end

--- Get the root directory of a Node.js/TypeScript project
--- @param bufnr number Buffer number
--- @return string|nil
function M.get_node_root_dir(bufnr)
  local path = vim.api.nvim_buf_get_name(bufnr)
  local config_file = vim.fs.find({ "package.json", "tsconfig.json" }, {
    upward = true,
    path = path,
  })[1]
  return config_file and vim.fn.fnamemodify(config_file, ":h") or nil
end

return M

