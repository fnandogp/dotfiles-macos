vim.g.mapleader = ","

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "C-v", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("v", "//", "y/\\V<C-r>=escape(@\",'/\\')<CR><CR>")
vim.keymap.set("n", "//", "yiw/\\V<C-r>=escape(@\",'/\\')<CR><CR>")
vim.keymap.set("v", "<M-/>", '"hy:%s/<C-r>h//gc<left><left><left>')

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<Leader>w", "<Cmd>w<CR>")
vim.keymap.set("n", "<Leader>W", "<Cmd>wa<CR>")
vim.keymap.set("n", "<Leader>q", "<Cmd>q<CR>")
vim.keymap.set("n", "<Leader>Q", "<Cmd>qa<CR>")

vim.keymap.set("n", "<leader>R", ":edit!<CR>")

-- Navigate windows
vim.keymap.set("n", "<A-h>", "<C-w>h")
vim.keymap.set("n", "<A-j>", "<C-w>j")
vim.keymap.set("n", "<A-k>", "<C-w>k")
vim.keymap.set("n", "<A-l>", "<C-w>l")
-- Move windows
vim.keymap.set("n", "<A-H>", "<C-w>H")
vim.keymap.set("n", "<A-J>", "<C-w>J")
vim.keymap.set("n", "<A-K>", "<C-w>K")
vim.keymap.set("n", "<A-L>", "<C-w>L")

-- Navigate terminals
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("t", "<A-h>", "<C-\\><C-n><C-w>h")
vim.keymap.set("t", "<A-j>", "<C-\\><C-n><C-w>j")
vim.keymap.set("t", "<A-k>", "<C-\\><C-n><C-w>k")
vim.keymap.set("t", "<A-l>", "<C-\\><C-n><C-w>l")

-- Resize with arrows
vim.keymap.set("n", "<A-Up>", "<cmd>resize -2<CR>")
vim.keymap.set("n", "<A-Down>", "<cmd>resize +2<CR>")
vim.keymap.set("n", "<A-Left>", "<cmd>vertical resize -2<CR>")
vim.keymap.set("n", "<A-Right>", "<cmd>vertical resize +2<CR>")
