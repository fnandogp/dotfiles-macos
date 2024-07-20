-- This file is automatically loaded by plugins.core
local opt = vim.opt
opt.clipboard = "unnamedplus" -- Copy paste between vim and everything else
opt.scrolloff = 5 -- Lines of context
opt.title = true -- Set the title of window to the value of the titlestring

opt.tabstop = 2 -- Number of spaces tabs count for
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 2 -- Size of an indent
opt.list = true -- Show some invisible characters (tabs...

--opt.noswapfile = false -- Disable swap file
--opt.autoread = true -- Reload files changed outside vim
--opt.autowrite = true -- Automatically save before commands like :next and :make
--opt.completeopt = "menu,menuone,noselect" -- Completion options
--opt.conceallevel = 3 -- Hide * markup for bold and italic
--opt.confirm = true -- Confirm to save changes before exiting modified buffer
--opt.cursorline = true -- Enable highlighting of the current line
--opt.formatoptions = "jcroqlnt" -- tcqj
--opt.grepformat = "%f:%l:%c:%m"
--opt.grepprg = "rg --vimgrep"
--opt.ignorecase = true -- Ignore case
--opt.inccommand = "nosplit" -- preview incremental substitute
--opt.mouse = "a" -- Enable mouse mode
--opt.number = true -- Print line number
--opt.pumblend = 10 -- Popup blend
--opt.pumheight = 10 -- Maximum number of entries in a popup
--opt.relativenumber = true -- Relative line numbers
--opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
--opt.shiftround = true -- Round indent
--opt.shiftwidth = 2 -- Size of an indent
--opt.shortmess:append({ W = true, I = true, c = true })
--opt.showmode = false -- Dont show mode since we have a statusline
--opt.sidescrolloff = 8 -- Columns of context
--opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
--opt.smartcase = true -- Don't ignore case with capitals
--opt.smartindent = true -- Insert indents automatically
--opt.spelllang = { "en" }
--opt.splitbelow = true -- Put new windows below current
--opt.splitright = true -- Put new windows right of current
--opt.termguicolors = true -- True color support
--opt.timeoutlen = 300
--opt.undofile = true
--opt.undolevels = 10000
--opt.updatetime = 200 -- Save swap file and trigger CursorHold
--opt.wildmode = "longest:full,full" -- Command-line completion mode
--opt.winminwidth = 5 -- Minimum window width
--opt.wrap = false -- Disable line wrap
--opt.splitkeep = "screen"
--opt.shortmess:append({ C = true })

opt.pumblend = 0 -- disable transparency for completion popup
opt.winblend = 0 -- disable transparency for documentation popup

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
