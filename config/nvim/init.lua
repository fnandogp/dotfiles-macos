-- Entry point. Bootstraps mini.nvim (which ships mini.deps), then loads core
-- settings and one plugin module per concern. Each module registers plugins
-- with MiniDeps.add() and runs its setup inside now() (needed for the first
-- screen draw) or later() (everything else, executed after startup).

-- Bootstrap mini.nvim into pack/deps/start so it is always on the runtimepath
local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"
if not vim.uv.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = { "git", "clone", "--filter=blob:none", "--branch", "stable", "https://github.com/nvim-mini/mini.nvim", mini_path }
  vim.fn.system(clone_cmd)
  vim.cmd("packadd mini.nvim | helptags ALL")
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Snapshot (lockfile equivalent) lives in the config dir so it is versioned
require("mini.deps").setup({ path = { package = path_package } })
-- Track mini.nvim itself on the stable branch (:DepsUpdate keeps it current)
MiniDeps.add({ name = "mini.nvim", checkout = "stable" })

-- Leader keys must be set before any <leader> mapping is created
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

require("options")
require("keymaps")
require("ft")

-- Plugin modules. Order matters for now() blocks (colourscheme before UI).
require("plugins.colorscheme")
require("plugins.init")
require("plugins.ui")
require("plugins.treesitter")
require("plugins.autocomplete")
require("plugins.picker")
require("plugins.file-explorer")
require("plugins.bookmark")
require("plugins.coding")
require("plugins.editor")
require("plugins.lsp")
require("plugins.formatting")
require("plugins.linting")
require("plugins.terminal")
require("plugins.note-taking")
require("plugins.ai-assistant")
