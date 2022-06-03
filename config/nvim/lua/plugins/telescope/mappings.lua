local map = require("utils").map

map("n", "<leader>p", [[<cmd>lua require('telescope.builtin').find_files({hidden=true})<CR>]])
map("n", "<leader>P", [[<cmd>lua require('telescope.builtin').commands()<CR>]])

map("n", "<leader>fw", [[<cmd>lua require('telescope.builtin').live_grep()<CR>]])
map("n", "<leader>fg", [[<cmd>lua require('telescope.builtin').git_files()<CR>]])

map("n", "<leader>fc", [[<cmd>lua require('telescope.builtin').commands()<CR>]])
map("n", "<leader>fh", [[<cmd>lua require('telescope.builtin').command_history()<CR>]])
map("n", "<leader>ft", [[<cmd>lua require('telescope.builtin').treesitter()<CR>]])

map("n", "<leader>fb", [[<cmd>lua require('telescope.builtin').git_bcommits()<CR>]])

--LSP

map("n", "<leader>gr", [[<cmd>lua require('telescope.builtin').lsp_references()<CR>]])
map("n", "<leader>go", [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]])
map("n", "<leader>gO", [[<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>]])
map("n", "<leader>ca", [[<cmd>lua require('telescope.builtin').lsp_code_actions()<CR>]])
map("n", "<leader>ca", [[<cmd>lua require('telescope.builtin').lsp_range_code_actions()<CR>]])
map("n", "<leader>gd", [[<cmd>lua require('telescope.builtin').lsp_definitions()<CR>]])
map("n", "<leader>gi", [[<cmd>lua require('telescope.builtin').lsp_implementations()<CR>]])
map("n", "<leader>gt", [[<cmd>lua require('telescope.builtin').lsp_type_definitions()<CR>]])
