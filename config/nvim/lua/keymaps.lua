vim.g.mapleader = ","

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
vim.keymap.set("x", "<A-j>", ":move '>+1<CR>gv-gv")
vim.keymap.set("x", "<A-k>", ":move '<-2<CR>gv-gv")

vim.keymap.set("n", "<Leader>w", "<Cmd>w<CR>", { desc = "Write buffer" })
vim.keymap.set("n", "<Leader>W", "<Cmd>wa<CR>", { desc = "Write all" })
vim.keymap.set("n", "<Leader>q", "<Cmd>q<CR>", { desc = "Quit buffer" })
vim.keymap.set("n", "<Leader>Q", "<Cmd>qa<CR>", { desc = "Quit all" })

vim.keymap.set("n", "<leader>R", ":edit!<CR>", { desc = "Reload buffer" })

-- Terminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
-- Move windows
vim.keymap.set("n", "<C-M-h>", "<C-w>H", { desc = "Move window to left" })
vim.keymap.set("n", "<C-M-j>", "<C-w>J", { desc = "Move window to bottom" })
vim.keymap.set("n", "<C-M-k>", "<C-w>K", { desc = "Move window to top" })
vim.keymap.set("n", "<C-M-l>", "<C-w>L", { desc = "Move window to right" })
