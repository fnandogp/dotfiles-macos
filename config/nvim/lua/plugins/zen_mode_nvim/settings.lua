require("zen-mode").setup({
	window = {
		backdrop = 1,
		width = 100, -- width of the Zen window
		height = 1, -- height of the Zen window
	},
	options = {
		number = false, -- disable number column
		relativenumber = false, -- disable relative numbers
	},
	plugins = {
		kitty = {
			enabled = true,
			font = "2", -- font size increment
		},
	},
})
