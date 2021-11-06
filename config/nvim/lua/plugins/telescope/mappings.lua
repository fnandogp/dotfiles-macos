nnoremap('<leader>p', "<cmd>Telescope find_files<CR>", 'telescope', 'telescope', 'Files')

nnoremap('<leader>fw', "<cmd>lua require('telescope.builtin').live_grep()<CR>", 'telescope', 'telescope_live_grep', 'Live grep')
nnoremap('<leader>fg', "<cmd>lua require('telescope.builtin').git_files()<CR>", 'telescope', 'telescope_git_files', 'Find git files')
nnoremap('<leader>fC', "<cmd>lua require('lt.plugins.telescope.functions').search_config()<CR>", 'telescope', 'telescope_search_config', 'Search neovim config')

nnoremap('<leader>fh', "<cmd>lua require('telescope.builtin').command_history()<CR>", 'telescope', 'telescope_command_history', 'Search command history')
nnoremap('<leader>fc', "<cmd>lua require('telescope.builtin').commands()<CR>", 'telescope', 'telescope_commands', 'Search commands')
nnoremap('<leader>ft', "<cmd>lua require('telescope.builtin').treesitter()<CR>", 'telescope', 'telescope_treesitter', 'Search treesitter')

nnoremap('<leader>fb', "<cmd>lua require('telescope.builtin').buffers()<CR>", 'telescope', 'telescope_buffers', 'Search buffers')
nnoremap('<leader>fbc', "<cmd>lua require('telescope.builtin').git_bcommits()<CR>", 'telescope', 'telescope_git_bcommits', 'Search buffer git commits')

