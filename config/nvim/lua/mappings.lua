local map = require("utils").map

map("n", "<leader>w", ":w<CR>")
map("n", "<leader>W", ":wa<CR>")
map("v", "<leader>w", "<C-c>:w<CR>")
map("i", "<leader>w", "<C-o>:w<CR>")
map("n", "<leader>q", ":q<CR>")
map("v", "<leader>q", "<C-c>:q<CR>")
map("i", "<leader>q", "<C-o>:q<CR>")
map("n", "<leader>Q", ":bdelete!<CR>")
map("n", "<leader>R", ":edit!<CR>")

map("v", "//", "y/\\V<C-r>=escape(@\",'/\\')<CR><CR>")
map("n", "//", "yiw/\\V<C-r>=escape(@\",'/\\')<CR><CR>")
map("v", "<M-/>", '"hy:%s/<C-r>h//gc<left><left><left>')

map("v", "<C-c>", '"+y')

map("v", "p", '"0p')
map("v", "P", '"0P')

map("v", "<", "<gv")
map("v", ">", ">gv")

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Navigate windows
map("n", "<M-h>", "<C-w>h")
map("n", "<M-j>", "<C-w>j")
map("n", "<M-k>", "<C-w>k")
map("n", "<M-l>", "<C-w>l")
-- Move windows
map("n", "<M-S-h>", "<C-w>H")
map("n", "<M-S-j>", "<C-w>J")
map("n", "<M-S-k>", "<C-w>K")
map("n", "<M-S-l>", "<C-w>L")

-- Navigate terminals
map("t", "<Esc>", "<C-\\><C-n>")
map("t", "<M-h>", "<C-\\><C-n><C-w>h")
map("t", "<M-j>", "<C-\\><C-n><C-w>j")
map("t", "<M-k>", "<C-\\><C-n><C-w>k")
map("t", "<M-l>", "<C-\\><C-n><C-w>l")

-- Resize with arrows
map("n", "<M-Up>", "<cmd>resize -2<CR>")
map("n", "<M-Down>", "<cmd>resize +2<CR>")
map("n", "<M-Left>", "<cmd>vertical resize -2<CR>")
map("n", "<M-Right>", "<cmd>vertical resize +2<CR>")
