local M = {}

function M.config()
	local actions = require("telescope.actions")

	require("telescope").setup({
		defaults = {
			mappings = {
				i = {
					["<esc>"] = actions.close,
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
					["<C-n>"] = actions.cycle_history_next,
					["<C-p>"] = actions.cycle_history_prev,
				},
				n = {
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
				},
			},
		},
	})

	local opts = { noremap = true, silent = true }
	vim.api.nvim_set_keymap("n", "<Leader>p", "<cmd>Telescope find_files<CR>", opts)
	vim.api.nvim_set_keymap("n", "<Leader>fg", "<cmd>Telescope live_grep<CR>", opts)
	vim.api.nvim_set_keymap("n", "<Leader>fb", "<cmd>Telescope buffers<CR>", opts)
end

return M
