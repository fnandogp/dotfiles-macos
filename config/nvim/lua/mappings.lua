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
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
-- Move windows
--map("n", "<C-H>", "<C-w>H")
--map("n", "<C-J>", "<C-w>J")
--map("n", "<C-K>", "<C-w>K")
--map("n", "<C-L>", "<C-w>L")

-- Navigate terminals
map("t", "<Esc>", "<C-\\><C-n>")
map("t", "<C-h>", "<C-\\><C-n><C-w>h")
map("t", "<C-j>", "<C-\\><C-n><C-w>j")
map("t", "<C-k>", "<C-\\><C-n><C-w>k")
map("t", "<C-l>", "<C-\\><C-n><C-w>l")

-- Resize with arrows
map("n", "<C-Up>", "<cmd>resize -2<CR>")
map("n", "<C-Down>", "<cmd>resize +2<CR>")
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>")
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>")
