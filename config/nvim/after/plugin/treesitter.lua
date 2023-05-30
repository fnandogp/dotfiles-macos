require("nvim-treesitter.configs").setup({
	ensure_installed = "all",
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	context_commentstring = {
		enable = true,
	},
	autotag = {
		enable = true,
	},
	context = {
		enable = true,
	},
})
