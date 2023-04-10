local telescope = require("telescope")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

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

vim.keymap.set("n", "<leader>p", builtin.find_files, {})
vim.keymap.set("n", "<leader>P", builtin.git_files, {})
vim.keymap.set("n", "<leader>sr", builtin.resume, {})
vim.keymap.set("n", "<leader>sw", builtin.live_grep, {})
vim.keymap.set("n", "<leader>sc", builtin.commands, {})
vim.keymap.set("n", "<leader>sh", "<Cmd>Telescope harpoon marks<CR>", {})

--LSP
vim.keymap.set("n", "<Leader>gr", builtin.lsp_references)
vim.keymap.set("n", "<Leader>go", builtin.lsp_document_symbols)
vim.keymap.set("n", "<Leader>gO", builtin.lsp_dynamic_workspace_symbols)
vim.keymap.set("n", "<Leader>gd", builtin.lsp_definitions)
vim.keymap.set("n", "<Leader>gi", builtin.lsp_implementations)
vim.keymap.set("n", "<Leader>gt", builtin.lsp_type_definitions)
