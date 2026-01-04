local M = {}

--- Check if buffer has Deno config
--- @param bufnr number Buffer number
--- @return boolean
function M.has_deno_config(bufnr)
  local path = vim.api.nvim_buf_get_name(bufnr)
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

--- Check if buffer has ESLint config
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

--- Check if buffer has Prettier config
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
  return vim.fs.find({ "oxcrc.json", "oxcrc.json5", ".oxcrc.json", ".oxcrc.json5" }, {
    upward = true,
    path = path,
  })[1] ~= nil
end

return M

