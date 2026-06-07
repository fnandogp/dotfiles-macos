-- Global keymaps. Leader is "," so it must be set before any <leader> mapping.

vim.g.mapleader = ","

-- Keep the cursor stable while editing/scrolling:
vim.keymap.set("n", "J", "mzJ`z") -- Join lines without moving the cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz") -- Half-page down, recentre
vim.keymap.set("n", "<C-u>", "<C-u>zz") -- Half-page up, recentre
vim.keymap.set("n", "n", "nzzzv") -- Next search match, centred and unfolded
vim.keymap.set("n", "N", "Nzzzv") -- Prev search match, centred and unfolded

-- Append trailing "," / ";" to the current line without leaving position context
vim.keymap.set({ "n", "i" }, ",,", "<Esc>A,<Esc>")
vim.keymap.set({ "n", "i" }, ";;", "<Esc>A;<Esc>")

-- Register-aware clipboard ops (avoid clobbering the unnamed register):
vim.keymap.set("x", "<leader>p", [["_dP]]) -- Paste over selection without yanking it
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]]) -- Yank to system clipboard
vim.keymap.set("n", "<C-v>", [["+Y]]) -- Yank line to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]]) -- Delete into black hole register

-- Search for the selected/word text literally (\V), escaping special chars
vim.keymap.set("v", "//", "y/\\V<C-r>=escape(@\",'/\\')<CR><CR>")
vim.keymap.set("n", "//", "yiw/\\V<C-r>=escape(@\",'/\\')<CR><CR>")
-- Start a substitute (confirm) pre-filled with the visual selection
vim.keymap.set("v", "<M-/>", '"hy:%s/<C-r>h//gc<left><left><left>')

-- Move the visual selection down/up, keeping it selected
vim.keymap.set("x", "<A-j>", ":move '>+1<CR>gv-gv")
vim.keymap.set("x", "<A-k>", ":move '<-2<CR>gv-gv")

vim.keymap.set("n", "<Leader>w", "<Cmd>w<CR>", { desc = "Write buffer" })
vim.keymap.set("n", "<Leader>W", "<Cmd>wa<CR>", { desc = "Write all" })
vim.keymap.set("n", "<Leader>q", "<Cmd>q<CR>", { desc = "Quit buffer" })
vim.keymap.set("n", "<Leader>Q", "<Cmd>qa<CR>", { desc = "Quit all" })

vim.keymap.set("n", "<leader>E", ":edit!<CR>", { desc = "Reload buffer" })

-- Terminal: <Esc> leaves terminal-insert mode (back to normal mode)
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
-- Move windows
vim.keymap.set("n", "<C-M-h>", "<C-w>H", { desc = "Move window to left" })
vim.keymap.set("n", "<C-M-j>", "<C-w>J", { desc = "Move window to bottom" })
vim.keymap.set("n", "<C-M-k>", "<C-w>K", { desc = "Move window to top" })
vim.keymap.set("n", "<C-M-l>", "<C-w>L", { desc = "Move window to right" })
