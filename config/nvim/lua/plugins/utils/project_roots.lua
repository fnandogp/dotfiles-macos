--- Resolves an LSP `root_dir` from a buffer by locating the nearest project
--- marker upward from the file. Each function finds the config file then returns
--- its containing directory (`:h` = head/dirname), or nil if none is found.
--- Used by lsp.lua to set the right root per server (paired with config_detection
--- so Deno and Node LSPs attach to the correct project in mixed/monorepo setups).
local M = {}

--- Get the root directory of a Deno project (dir holding deno.json/deno.jsonc).
--- @param bufnr number Buffer number
--- @return string|nil Project root, or nil when no Deno config is found
function M.get_deno_root_dir(bufnr)
  local path = vim.api.nvim_buf_get_name(bufnr)
  local config_file = vim.fs.find({ "deno.json", "deno.jsonc" }, {
    upward = true,
    path = path,
  })[1]
  -- :h strips the filename, leaving the directory to use as root_dir
  return config_file and vim.fn.fnamemodify(config_file, ":h") or nil
end

--- Get the root directory of a Node.js/TypeScript project.
--- Matches package.json or tsconfig.json (whichever is nearest going upward).
--- @param bufnr number Buffer number
--- @return string|nil Project root, or nil when no Node/TS config is found
function M.get_node_root_dir(bufnr)
  local path = vim.api.nvim_buf_get_name(bufnr)
  local config_file = vim.fs.find({ "package.json", "tsconfig.json" }, {
    upward = true,
    path = path,
  })[1]
  return config_file and vim.fn.fnamemodify(config_file, ":h") or nil
end

return M
