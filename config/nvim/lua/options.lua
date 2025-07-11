vim.opt.clipboard = "unnamedplus" -- Copy paste between vim and everything else
vim.opt.scrolloff = 10 -- Lines of context
vim.opt.title = true -- Set the title of window to the value of the titlestring

vim.opt.tabstop = 2 -- Number of spaces tabs count for
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.shiftwidth = 2 -- Size of an indent
vim.opt.list = true -- Show some invisible characters (tabs...

vim.opt.pumblend = 0 -- Disable transparency for completion popup
vim.opt.winblend = 0 -- Disable transparency for documentation popup
-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- Folding options
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- fold based on treesitter
vim.opt.foldmethod = "expr" -- fold based on treesitter
vim.opt.foldlevel = 99 -- start with all folds open
vim.opt.foldlevelstart = 99 -- start with all folds open

-- Views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3
vim.opt.conceallevel = 1

-- Diagnostics
vim.diagnostic.config({
  jump = {
    float = true,
  },
  signs = {
    text = { "", "▲", "●", "" }, -- Error, Warn, Info, Hint
  },
  float = {
    max_width = 70,
    border = "rounded",
    header = "",
    prefix = function(_, _, total) return (total > 1 and "• " or ""), "Comment" end,
    suffix = function(diag)
      local source = (diag.source or ""):gsub(" ?%.$", "")
      local code = diag.code and ": " .. diag.code or ""
      return " " .. source .. code, "Comment"
    end,
    format = function(diag)
      local msg = diag.message:gsub("%.$", "")
      return msg
    end,
  },
})
