vim.opt.clipboard = "unnamedplus" -- Copy paste between vim and everything else
vim.opt.scrolloff = 10 -- Lines of context
vim.opt.title = true -- Set the title of window to the value of the titlestring

vim.opt.tabstop = 2 -- Number of spaces tabs count for
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.shiftwidth = 2 -- Size of an indent
vim.opt.list = true -- Show some invisible characters (tabs...

vim.opt.pumblend = 0 -- disable transparency for completion popup
vim.opt.winblend = 0 -- disable transparency for documentation popup
-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

--folding options
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- fold based on treesitter
vim.opt.foldmethod = "expr" -- fold based on treesitter
vim.opt.foldlevel = 99 -- start with all folds open
vim.opt.foldlevelstart = 99 -- start with all folds open

-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3
vim.opt.conceallevel = 1
