local set_keymap = function(mode, lhs, rhs)
	local opts = { noremap = true, silent = true }
	return vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

set_keymap("v", "//", "y/\\V<C-r>=escape(@\",'/\\')<CR><CR>")
set_keymap("n", "//", "yiw/\\V<C-r>=escape(@\",'/\\')<CR><CR>")
set_keymap("v", "<M-/>", '"hy:%s/<C-r>h//gc<left><left><left>')

set_keymap("v", "<C-c>", '"+y')

set_keymap("v", "p", '"0p')
set_keymap("v", "P", '"0P')

set_keymap("v", "<", "<gv")
set_keymap("v", ">", ">gv")

set_keymap("v", "J", ":m '>+1<CR>gv=gv")
set_keymap("v", "K", ":m '<-2<CR>gv=gv")

set_keymap("t", "<Esc>", "<C-\\><C-n>")
set_keymap("t", "<M-h>", "<C-\\><C-n><C-w>h")
set_keymap("t", "<M-j>", "<C-\\><C-n><C-w>j")
set_keymap("t", "<M-k>", "<C-\\><C-n><C-w>k")
set_keymap("t", "<M-l>", "<C-\\><C-n><C-w>l")

set_keymap("n", "<M-h>", "<C-w>h")
set_keymap("n", "<M-j>", "<C-w>j")
set_keymap("n", "<M-k>", "<C-w>k")
set_keymap("n", "<M-l>", "<C-w>l")
set_keymap("n", "<M-S-h>", "<C-w>H")
set_keymap("n", "<M-S-j>", "<C-w>J")
set_keymap("n", "<M-S-k>", "<C-w>K")
set_keymap("n", "<M-S-l>", "<C-w>L")
