nnoremap("<leader>p", [[<cmd>lua require('telescope.builtin').find_files({hidden=true})<CR>]])
nnoremap("<leader>P", [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]])

nnoremap("<leader>fw", [[<cmd>lua require('telescope.builtin').live_grep()<CR>]])
nnoremap("<leader>fg", [[<cmd>lua require('telescope.builtin').git_files()<CR>]])

nnoremap("<leader>fc", [[<cmd>lua require('telescope.builtin').commands()<CR>]])
nnoremap("<leader>fh", [[<cmd>lua require('telescope.builtin').command_history()<CR>]])
nnoremap("<leader>ft", [[<cmd>lua require('telescope.builtin').treesitter()<CR>]])

nnoremap("<leader>fb", [[<cmd>lua require('telescope.builtin').git_bcommits()<CR>]])
