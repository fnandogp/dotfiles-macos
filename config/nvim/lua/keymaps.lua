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

vim.keymap.set("n", "<leader>cf", "<cmd>LspZeroFormat<cr>", { desc = "Format" })

--vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
--vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
--vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
--vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<Leader>w", "<Cmd>w<CR>", { desc = "Write buffer" })
vim.keymap.set("n", "<Leader>W", "<Cmd>wa<CR>", { desc = "Write all" })
vim.keymap.set("n", "<Leader>q", "<Cmd>q<CR>", { desc = "Quit buffer" })
vim.keymap.set("n", "<Leader>Q", "<Cmd>qa<CR>", { desc = "Quit all" })

vim.keymap.set("n", "<leader>R", ":edit!<CR>", { desc = "Reload buffer" })

--vim.keymap.set({ "i", "t", "c" }, "<A-h>", "<C-o>h", { desc = "Move cursor to right on i/t/c" })
--vim.keymap.set({ "i", "t", "c" }, "<A-j>", "<C-o>j", { desc = "Move cursor to down on i/t/c" })
--vim.keymap.set({ "i", "t", "c" }, "<A-k>", "<C-o>k", { desc = "Move cursor to up on i/t/c" })
--vim.keymap.set({ "i", "t", "c" }, "<A-l>", "<C-o>l", { desc = "Move cursor to right on i/t/c" })

---- Navigate windows
--vim.keymap.set({ "n", "i", "t" }, "<C-h>", "<C-w>h", { desc = "Navigate to left window" })
--vim.keymap.set({ "n", "i", "t" }, "<C-j>", "<C-w>j", { desc = "Navigate to down window" })
--vim.keymap.set({ "n", "i", "t" }, "<C-k>", "<C-w>k", { desc = "Navigate to up window" })
--vim.keymap.set({ "n", "i", "t" }, "<C-l>", "<C-w>l", { desc = "Navigate to right window" })
---- Move windows
--vim.keymap.set("n", "<C-M-h>", "<C-w>H")
--vim.keymap.set("n", "<C-M-j>", "<C-w>J")
--vim.keymap.set("n", "<C-M_k>", "<C-w>K")
--vim.keymap.set("n", "<C-M-l>", "<C-w>L")

---- Navigate terminals
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
--vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h")
--vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j")
--vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k")
--vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l")

-- Resize with arrows
--vim.keymap.set("n", "<C-Up>", "<cmd>resize -2<CR>")
--vim.keymap.set("n", "<C-Down>", "<cmd>resize +2<CR>")
--vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<CR>")
--vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<CR>")
