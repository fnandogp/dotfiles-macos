local M = {}

function M.config()
	require("nvim-tree").setup({
		open_on_setup = false,
		open_on_tab = false,
		hijack_cursor = true,
		lsp_diagnostics = true,
		update_focused_file = { enable = true },
		view = {
			width = 30,
			side = "left",
			auto_resize = false,
			mappings = {
				custom_only = false,
				list = {},
			},
		},
	})

	vim.g.nvim_tree_quit_on_open = 1
	vim.api.nvim_set_keymap("n", "<Leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
end

return M
