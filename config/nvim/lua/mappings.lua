nnoremap("<Leader>w", ":w<CR>")
nnoremap("<Leader>W", ":wa<CR>")
vnoremap("<Leader>w", "<C-c>:w<CR>")
inoremap("<Leader>w", "<C-o>:w<CR>")
nnoremap("<Leader>q", ":q<CR>")
vnoremap("<Leader>q", "<C-c>:q<CR>")
inoremap("<Leader>q", "<C-o>:q<CR>")
nnoremap("<Leader>Q", ":bdelete!<CR>")
nnoremap("<Leader>R", ":edit!<CR>")

vnoremap("//", "y/\\V<C-r>=escape(@\",'/\\')<CR><CR>")
nnoremap("//", "yiw/\\V<C-r>=escape(@\",'/\\')<CR><CR>")
vnoremap("<M-/>", '"hy:%s/<C-r>h//gc<left><left><left>')

vnoremap("<C-c>", '"+y')

vnoremap("p", '"0p')
vnoremap("P", '"0P')

vnoremap("<", "<gv")
vnoremap(">", ">gv")

vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")

tnoremap("<Esc>", "<C-\\><C-n>")
tnoremap("<M-h>", "<C-\\><C-n><C-w>h")
tnoremap("<M-j>", "<C-\\><C-n><C-w>j")
tnoremap("<M-k>", "<C-\\><C-n><C-w>k")
tnoremap("<M-l>", "<C-\\><C-n><C-w>l")

nnoremap("<M-h>", "<C-w>h")
nnoremap("<M-j>", "<C-w>j")
nnoremap("<M-k>", "<C-w>k")
nnoremap("<M-l>", "<C-w>l")
nnoremap("<M-S-h>", "<C-w>H")
nnoremap("<M-S-j>", "<C-w>J")
nnoremap("<M-S-k>", "<C-w>K")
nnoremap("<M-S-l>", "<C-w>L")
