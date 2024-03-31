vim.g.mapleader = ","

-- vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set({ "n", "i" }, ",,", "<Esc>A,<Esc>")
vim.keymap.set({ "n", "i" }, ";;", "<Esc>A;<Esc>")

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "C-v", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("v", "//", "y/\\V<C-r>=escape(@\",'/\\')<CR><CR>")
vim.keymap.set("n", "//", "yiw/\\V<C-r>=escape(@\",'/\\')<CR><CR>")
vim.keymap.set("v", "<M-/>", '"hy:%s/<C-r>h//gc<left><left><left>')

-- Move text up and down
vim.keymap.set("x", "J", ":move '>+1<CR>gv-gv")
vim.keymap.set("x", "K", ":move '<-2<CR>gv-gv")
vim.keymap.set("x", "<A-j>", ":move '>+1<CR>gv-gv")
vim.keymap.set("x", "<A-k>", ":move '<-2<CR>gv-gv")

-- Format
vim.keymap.set("n", "<leader>cf", "<cmd>LspZeroFormat<cr>", { desc = "Format" })

vim.keymap.set("n", "<Leader>w", "<Cmd>w<CR>", { desc = "Write buffer" })
vim.keymap.set("n", "<Leader>W", "<Cmd>wa<CR>", { desc = "Write all" })
vim.keymap.set("n", "<Leader>q", "<Cmd>q<CR>", { desc = "Quit buffer" })
vim.keymap.set("n", "<Leader>Q", "<Cmd>qa<CR>", { desc = "Quit all" })

vim.keymap.set("n", "<leader>R", ":edit!<CR>", { desc = "Reload buffer" })

-- Terminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

---- Better window navigation
--vim.keymap.set("n", "<M-h>", "<C-w>h", { desc = "Navigate to left window" })
--vim.keymap.set("n", "<M-j>", "<C-w>j", { desc = "Navigate to down window" })
--vim.keymap.set("n", "<M-k>", "<C-w>k", { desc = "Navigate to up window" })
--vim.keymap.set("n", "<M-l>", "<C-w>l", { desc = "Navigate to right window" })
------ Move windows
--vim.keymap.set("n", "<M-S-h>", "<C-w>H")
--vim.keymap.set("n", "<M-S-j>", "<C-w>J")
--vim.keymap.set("n", "<M-S_k>", "<C-w>K")
--vim.keymap.set("n", "<M-S-l>", "<C-w>L")

---- Resize with arrows
--vim.keymap.set("n", "<M-Up>", "<cmd>resize -2<CR>")
--vim.keymap.set("n", "<M-Down>", "<cmd>resize +2<CR>")
--vim.keymap.set("n", "<M-Left>", "<cmd>vertical resize -2<CR>")
--vim.keymap.set("n", "<M-Right>", "<cmd>vertical resize +2<CR>")
