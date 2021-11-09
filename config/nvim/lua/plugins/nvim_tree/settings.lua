vim.g.nvim_tree_show_icons = { git = 0, folders = 1, files = 1 }

vim.g.nvim_tree_git_hl = 0
vim.g.nvim_tree_quit_on_open = 1
vim.g.nvim_tree_highlight_opened_files = 1
vim.g.nvim_tree_group_empty = 1

require("nvim-tree").setup({
	open_on_setup = false,
	open_on_tab = false,
	update_cwd = false,
	auto_close = false,
	follow = 1,
	update_focused_file = {
		enable = true,
		update_cwd = false,
		ignore_list = {},
	},
	show_icons = { git = false, folders = true, files = true },
	view = {
		width = 20,
		height = 20,
	},
})
