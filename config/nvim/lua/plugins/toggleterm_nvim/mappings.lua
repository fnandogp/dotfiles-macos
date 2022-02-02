local map = require("utils").map

map("n", "<leader>t", [[<cmd>ToggleTerm direction=vertical<CR>]])
map("i", "<leader>t", [[<Esc><cmd>ToggleTerm<CR>]])
map("t", "<leader>t", [[<cmd>ToggleTerm<CR>]])

map("n", "<leader>T", [[<cmd>2ToggleTerm direction=float<CR>]])
