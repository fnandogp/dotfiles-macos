--local gps = require("nvim-gps")

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
	},
	--sections = {
	--lualine_c = {
	--{ gps.get_location, cond = gps.is_available },
	--},
	--},
})
