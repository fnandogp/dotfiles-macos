local M = {}
function M.config()
	local lspconfig = require("lspconfig")
	local null_ls = require("null-ls")

	null_ls.config({
		diagnostics_format = "[#{c}] #{m} (#{s})",
		debounce = 250,
		default_timeout = 5000,
		sources = {
			-- global
			null_ls.builtins.formatting.trim_whitespace.with({ filetypes = {} }),
			-- lua
			null_ls.builtins.diagnostics.luacheck,
			null_ls.builtins.formatting.stylua,
			-- js / ts
			null_ls.builtins.formatting.prettier,
			null_ls.builtins.diagnostics.eslint,
			-- css
			null_ls.builtins.formatting.stylelint,
			null_ls.builtins.diagnostics.stylelint,
			-- vim
			null_ls.builtins.diagnostics.vint,
		},
	})

	lspconfig["null-ls"].setup({})
end

return M
