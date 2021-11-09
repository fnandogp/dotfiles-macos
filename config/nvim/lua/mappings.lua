nnoremap("<Leader>w", ":w<CR>", "utils", "n_save", "")
vnoremap("<Leader>w", "<C-c>:w<CR>", "utils", "v_save", "")
inoremap("<Leader>w", "<C-o>:w<CR>", "utils", "i_save", "")
nnoremap("<Leader>q", ":q<CR>", "utils", "n_quit", "")
vnoremap("<Leader>q", "<C-c>:q<CR>", "utils", "v_quit", "")
inoremap("<Leader>q", "<C-o>:q<CR>", "utils", "i_quit", "")
nnoremap("<Leader>Q", ":bdelete!<CR>", "utils", "close_buffer", "")
nnoremap("<Leader>R", ":edit!<CR>", "utils", "reload", "")

vnoremap("//", "y/\\V<C-r>=escape(@\",'/\\')<CR><CR>", "utils", "highlight_selection", "")
nnoremap("//", "yiw/\\V<C-r>=escape(@\",'/\\')<CR><CR>", "utils", "highlight_word", "" )
vnoremap("<M-/>", '"hy:%s/<C-r>h//gc<left><left><left>', "utils", "replace_selection", "")

vnoremap("<C-c>", '"+y', "utils", "ctrl_c", "")

vnoremap("p", '"0p', "utils", "paste_", "")
vnoremap("P", '"0P', "utils", "paste", "")

vnoremap("<", "<gv", "utils", "indent_line", "")
vnoremap(">", ">gv", "utils", "unindent_line", "")

vnoremap("J", ":m '>+1<CR>gv=gv", "utils", "move_line_down", "")
vnoremap("K", ":m '<-2<CR>gv=gv", "utils", "move_line_up", "")

tnoremap("<Esc>", "<C-\\><C-n>", "terminal", "t_exit_insert_mode", "")
tnoremap("<M-h>", "<C-\\><C-n><C-w>h", "terminal", "t_go_left", "")
tnoremap("<M-j>", "<C-\\><C-n><C-w>j", "terminal", "t_go_down", "")
tnoremap("<M-k>", "<C-\\><C-n><C-w>k", "terminal", "t_go_up", "")
tnoremap("<M-l>", "<C-\\><C-n><C-w>l", "terminal", "t_go_right", "")

nnoremap("<M-h>", "<C-w>h", "Window", "n_go_left", "")
nnoremap("<M-j>", "<C-w>j", "Window", "n_go_down", "")
nnoremap("<M-k>", "<C-w>k", "Window", "n_go_up", "")
nnoremap("<M-l>", "<C-w>l", "Window", "n_go_right", "")
nnoremap("<M-S-h>", "<C-w>H", "Window", "n_move_left", "")
nnoremap("<M-S-j>", "<C-w>J", "Window", "n_move_down", "")
nnoremap("<M-S-k>", "<C-w>K", "Window", "n_move_up", "")
nnoremap("<M-S-l>", "<C-w>L", "Window", "n_move_right", "")

