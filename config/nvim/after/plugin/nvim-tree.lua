require("nvim-tree").setup({
	reload_on_bufenter = true,
	update_focused_file = { enable = true },
	git = { enable = false },
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
})

vim.keymap.set("n", "<leader>e", "<Cmd>NvimTreeToggle<CR>", {})
