--- Detects which tooling configs are present for a given buffer (Deno, Biome,
--- ESLint, Prettier, Oxc). Each check walks upward from the buffer's file to find
--- a matching config, so the answer reflects the project the file actually lives in.
--- Used by lsp.lua / linting.lua / formatting.lua to pick the right server/tool
--- per buffer (notably Deno vs Node, which must not both attach to the same file).
local M = {}

--- Check if buffer has Deno config (deno.json / deno.jsonc anywhere up the tree).
--- Presence of this is the signal to use the Deno LSP instead of the Node LSP.
--- @param bufnr number Buffer number
--- @return boolean
function M.has_deno_config(bufnr)
  local path = vim.api.nvim_buf_get_name(bufnr)
  -- upward = true: search the buffer's dir and every ancestor (monorepo-safe)
  return vim.fs.find({ "deno.json", "deno.jsonc" }, {
    upward = true,
    path = path,
  })[1] ~= nil
end

--- Check if buffer has Biome config
--- @param bufnr number Buffer number
--- @return boolean
function M.has_biome_config(bufnr)
  local path = vim.api.nvim_buf_get_name(bufnr)
  return vim.fs.find({ "biome.json", "biome.jsonc" }, {
    upward = true,
    path = path,
  })[1] ~= nil
end

--- Check if buffer has ESLint config.
--- Covers both legacy (.eslintrc*) and flat-config (eslint.config.*) layouts.
--- @param bufnr number Buffer number
--- @return boolean
function M.has_eslint_config(bufnr)
  local path = vim.api.nvim_buf_get_name(bufnr)
  return vim.fs.find({
    ".eslintrc",
    ".eslintrc.js",
    ".eslintrc.cjs",
    ".eslintrc.yaml",
    ".eslintrc.yml",
    ".eslintrc.json",
    "eslint.config.js",
    "eslint.config.mjs",
    "eslint.config.cjs",
    "eslint.config.ts",
    "eslint.config.mts",
    "eslint.config.cts",
  }, {
    upward = true,
    path = path,
  })[1] ~= nil
end

--- Check if buffer has Prettier config (any of the many supported filenames).
--- @param bufnr number Buffer number
--- @return boolean
function M.has_prettier_config(bufnr)
  local path = vim.api.nvim_buf_get_name(bufnr)
  return vim.fs.find({
    ".prettierrc",
    ".prettierrc.json",
    ".prettierrc.yml",
    ".prettierrc.yaml",
    ".prettierrc.json5",
    ".prettierrc.js",
    ".prettierrc.cjs",
    ".prettierrc.mjs",
    ".prettierrc.toml",
    "prettier.config.js",
    "prettier.config.cjs",
    "prettier.config.mjs",
  }, {
    upward = true,
    path = path,
  })[1] ~= nil
end

--- Check if buffer has Oxc config
--- @param bufnr number Buffer number
--- @return boolean
function M.has_oxc_config(bufnr)
  local path = vim.api.nvim_buf_get_name(bufnr)
  return vim.fs.find({ "oxcrc.json", "oxcrc.json5", ".oxcrc.json", ".oxcrc.json5", ".oxfmtrc.json", ".oxfmtrc.jsonc", "oxfmt.config.ts" }, {
    upward = true,
    path = path,
  })[1] ~= nil
end

return M
