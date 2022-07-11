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

--map("v", "p", '"0p')
map("v", "P", '"0P')

map("v", "<", "<gv")
map("v", ">", ">gv")

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Navigate windows
map("n", "<A-h>", "<C-w>h")
map("n", "<A-j>", "<C-w>j")
map("n", "<A-k>", "<C-w>k")
map("n", "<A-l>", "<C-w>l")
-- Move windows
map("n", "<A-H>", "<C-w>H")
map("n", "<A-J>", "<C-w>J")
map("n", "<A-K>", "<C-w>K")
map("n", "<A-L>", "<C-w>L")

-- Navigate terminals
map("t", "<Esc>", "<C-\\><C-n>")
map("t", "<A-h>", "<C-\\><C-n><C-w>h")
map("t", "<A-j>", "<C-\\><C-n><C-w>j")
map("t", "<A-k>", "<C-\\><C-n><C-w>k")
map("t", "<A-l>", "<C-\\><C-n><C-w>l")

-- Resize with arrows
map("n", "<A-Up>", "<cmd>resize -2<CR>")
map("n", "<A-Down>", "<cmd>resize +2<CR>")
map("n", "<A-Left>", "<cmd>vertical resize -2<CR>")
map("n", "<A-Right>", "<cmd>vertical resize +2<CR>")
