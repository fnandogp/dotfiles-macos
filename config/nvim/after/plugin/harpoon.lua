--require("telescope").load_extension("harpoon")

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>ha", mark.add_file, {})
vim.keymap.set("n", "<leader>hj", ui.nav_next, {})
vim.keymap.set("n", "<leader>hk", ui.nav_prev, {})
vim.keymap.set("n", "<leader>hh", ui.toggle_quick_menu, {})
