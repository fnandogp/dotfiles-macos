-- This file is automatically loaded by plugins.core
local opt = vim.opt

opt.clipboard = "unnamedplus" -- Copy paste between vim and everything else
opt.scrolloff = 10 -- Lines of context
opt.title = true -- Set the title of window to the value of the titlestring

opt.tabstop = 2 -- Number of spaces tabs count for
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 2 -- Size of an indent
opt.list = true -- Show some invisible characters (tabs...

opt.pumblend = 0 -- disable transparency for completion popup
opt.winblend = 0 -- disable transparency for documentation popup
-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

--folding options
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- fold based on treesitter
vim.opt.foldmethod = "expr" -- fold based on treesitter
vim.opt.foldlevel = 99 -- don't fold by default
