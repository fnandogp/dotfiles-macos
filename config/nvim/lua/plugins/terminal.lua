local M = {}

function M.config()
	require("toggleterm").setup({
		size = 20,
		open_mapping = [[<C-t>]],
		shading_factor = 1,
		direction = "float",
		close_on_exit = true, -- close the terminal window when the process exits
		float_opts = {
			border = "curved",
		},
	})
end

return M
