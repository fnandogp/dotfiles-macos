vim.g.nvim_tree_git_hl = 0
vim.g.nvim_tree_quit_on_open = 1
vim.g.nvim_tree_highlight_opened_files = 1
vim.g.nvim_tree_group_empty = 1
vim.g.nvim_tree_window_picker_exclude = {
	filetype = { "notify", "packer", "qf" },
	buftype = { "terminal" },
}
vim.g.nvim_tree_show_icons = { git = 0, folders = 1, files = 1, folder_arrows = 1 }

require("nvim-tree").setup({
	update_focused_file = { enable = true },
})
