require("trouble").setup({})

vim.keymap.set("n", "<leader>xx", "<Cmd>TroubleToggle<CR>")

vim.keymap.set("n", "<leader>xw", "<Cmd>TroubleToggle workspace_diagnostics<CR>")
vim.keymap.set("n", "<leader>xd", "<Cmd>TroubleToggle document_diagnostics<CR>")
vim.keymap.set("n", "<leader>xl", "<Cmd>TroubleToggle loclist<CR>")
vim.keymap.set("n", "<leader>xq", "<Cmd>TroubleToggle quickfix<CR>")
vim.keymap.set("n", "gR", "<Cmd>TroubleToggle lsp_references<CR>")
