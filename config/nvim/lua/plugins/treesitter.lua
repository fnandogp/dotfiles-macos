local M = {}

function M.config()
	require("nvim-treesitter.configs").setup({
		ensure_installed = "maintained",
		highlight = { enable = true },
	})
end

return M
