local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
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
	project = {
		base_dirs = { "~/workspace/" },
		sync_with_nvim_tree = true, -- default false
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
		},
	},
})

vim.keymap.set("n", "<leader>p", "<Cmd>Telescope find_files<CR>")
vim.keymap.set("n", "<leader>P", "<Cmd>Telescope git_files<CR>")
vim.keymap.set("n", "<leader>sr", "<Cmd>Telescope resume<CR>")
vim.keymap.set("n", "<leader>sw", "<Cmd>Telescope live_grep<CR>")
vim.keymap.set("n", "<leader>sc", "<Cmd>Telescope commands<CR>")
vim.keymap.set("n", "<leader>sh", "<Cmd>Telescope harpoon marks<CR>")

--LSP
vim.keymap.set("n", "<Leader>gr", "<Cmd>Telescope lsp_references<CR>")
vim.keymap.set("n", "<Leader>go", "<Cmd>Telescope lsp_document_symbols<CR>")
vim.keymap.set("n", "<Leader>gO", "<Cmd>Telescope lsp_dynamic_workspace_symbols<CR>")
vim.keymap.set("n", "<Leader>gd", "<Cmd>Telescope lsp_definitions<CR>")
vim.keymap.set("n", "<Leader>gi", "<Cmd>Telescope lsp_implementations<CR>")
vim.keymap.set("n", "<Leader>gt", "<Cmd>Telescope lsp_type_definitions<CR>")

vim.keymap.set("n", "<Leader>G", "<Cmd>G<CR>")
vim.keymap.set("n", "<Leader>ggs", "<Cmd>Telescope git_status<CR>")
vim.keymap.set("n", "<Leader>ggb", "<Cmd>Telescope git_branches<CR>")
