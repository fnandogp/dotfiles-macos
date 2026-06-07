-- Core Neovim options: clipboard, indentation, folding, UI popups and diagnostics.
-- Loaded early in init; sets editor-wide defaults before plugins.

vim.opt.clipboard = "unnamedplus" -- Copy paste between vim and everything else
vim.opt.scrolloff = 10 -- Lines of context
vim.opt.title = true -- Set the title of window to the value of the titlestring

vim.opt.tabstop = 2 -- Number of spaces tabs count for
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.shiftwidth = 2 -- Size of an indent
vim.opt.list = true -- Show some invisible characters (tabs...

-- Opaque popups so the mini.completion popup/docs stay readable over any background
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
vim.opt.conceallevel = 1 -- Hide concealed text (e.g. markdown syntax) but keep a placeholder

-- Native extended UI for cmdline/messages (Neovim 0.12+; replaces noice UI)
pcall(function() require("vim._extui").enable({ msg = { target = "cmd", timeout = 3000 } }) end)

-- Diagnostics: signs in the gutter, no inline virtual text, details shown in a
-- rounded float on jump (source + code appended, trailing periods stripped).
vim.diagnostic.config({
  jump = {
    float = true, -- Auto-open the float when jumping between diagnostics
  },
  signs = {
    text = { "", "▲", "●", "" }, -- Error, Warn, Info, Hint
  },
  virtual_text = false,
  float = {
    max_width = 70,
    border = "rounded",
    header = "",
    source = true,
    -- Bullet-prefix each line only when the float lists more than one diagnostic
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
