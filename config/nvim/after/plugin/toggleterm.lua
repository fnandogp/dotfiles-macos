local toggleterm = require("toggleterm")

toggleterm.setup({
	size = function(term)
		if term.direction == "horizontal" then
			return 10
		elseif term.direction == "vertical" then
			return vim.o.columns * 0.4
		end
	end,
})

vim.keymap.set("n", "<leader>t", [[<cmd>ToggleTerm size=70 direction=vertical<CR>]])
vim.keymap.set("i", "<leader>t", [[<Esc><cmd>ToggleTerm<CR>]])
vim.keymap.set("t", "<leader>t", [[<cmd>ToggleTerm<CR>]])

vim.keymap.set("n", "<leader>T", [[<cmd>2ToggleTerm direction=float<CR>]])
