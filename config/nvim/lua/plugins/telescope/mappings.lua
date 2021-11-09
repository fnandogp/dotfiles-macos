nnoremap("<leader>p", "<cmd>Telescope find_files<CR>")

nnoremap("<leader>fw", "<cmd>lua require('telescope.builtin').live_grep()<CR>")
nnoremap("<leader>fg", "<cmd>lua require('telescope.builtin').git_files()<CR>")
nnoremap("<leader>fC", "<cmd>lua require('lt.plugins.telescope.functions').search_config()<CR>")

nnoremap("<leader>fh", "<cmd>lua require('telescope.builtin').command_history()<CR>")
nnoremap("<leader>fc", "<cmd>lua require('telescope.builtin').commands()<CR>")
nnoremap("<leader>ft", "<cmd>lua require('telescope.builtin').treesitter()<CR>")

nnoremap("<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<CR>")
nnoremap("<leader>fbc", "<cmd>lua require('telescope.builtin').git_bcommits()<CR>")
