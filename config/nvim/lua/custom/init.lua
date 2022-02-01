-- Please check NvChad docs if you're totally new to nvchad + dont know lua!!
-- This is an example init file in /lua/custom/
-- this init.lua can load stuffs etc too so treat it like your ~/.config/nvim/

-- MAPPINGS
local map = require("core.utils").map

map("n", "<leader>w", ":w<CR>")
map("v", "<leader>w", "<C-c>:w<CR>")
map("i", "<leader>w", "<C-o>:w<CR>")
map("n", "<leader>W", ":wa<CR>")

map("n", "<leader>q", ":q<CR>")
map("v", "<leader>q", "<C-c>:q<CR>")
map("i", "<leader>q", "<C-o>:q<CR>")
map("n", "<leader>Q", ":qa<CR>")

map("n", "<leader>R", ":edit!<CR>")

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("v", "//", "y/\\V<C-r>=escape(@\",'/\\')<CR><CR>")
map("n", "//", "yiw/\\V<C-r>=escape(@\",'/\\')<CR><CR>")
map("v", "<M-/>", '"hy:%s/<C-r>h//gc<left><left><left>')
