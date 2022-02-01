local map = require("utils").map

map("n", "<leader>S", ":lua require('spectre').open()<CR>")
-- search current word
map("n", "<leader>sw", ":lua require('spectre').open_visual({select_word=true})<CR>")
map("n", "<leader>s", ":lua require('spectre').open_visual()<CR>")
-- search in current file
map("n", "<leader>sp", "viw:lua require('spectre').open_file_search()<cr>")
