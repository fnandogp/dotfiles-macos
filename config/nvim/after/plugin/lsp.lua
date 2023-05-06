local lsp = require("lsp-zero")
local cmp = require("cmp")
local luasnip = require("luasnip")
local cmp_action = require("lsp-zero").cmp_action()

luasnip.filetype_extend("javascriptreact", { "javascript" })
luasnip.filetype_extend("typescript", { "javascript" })
luasnip.filetype_extend("typescriptreact", { "javascript", "typescript" })

lsp.preset("recomended")

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }
	local bind = vim.keymap.set

	bind("n", "gD", vim.lsp.buf.declaration, opts)
	bind("n", "gd", vim.lsp.buf.definition, opts)
	bind("n", "gr", vim.lsp.buf.references, opts)
	bind("n", "gt", vim.lsp.buf.type_definition, opts)
	bind("n", "K", vim.lsp.buf.hover, opts)
	bind("n", "gi", vim.lsp.buf.implementation, opts)
	bind("n", "<C-k>", vim.lsp.buf.signature_help, opts)
	bind("n", "gn", vim.lsp.buf.rename, opts)
	bind("n", "gx", vim.lsp.buf.code_action, opts)
	bind("v", "gx", vim.lsp.buf.range_code_action, opts)

	bind("n", "gl", vim.diagnostic.open_float, opts)
	bind("n", "gL", vim.diagnostic.setqflist, opts)
	bind("n", "gk", vim.diagnostic.goto_prev, opts)
	bind("n", "gj", vim.diagnostic.goto_next, opts)

	bind("n", "<Leader>lr", "<Cmd>LspRestart<CR>", opts)
end)

require("luasnip.loaders.from_vscode").lazy_load()

lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({ buffer = bufnr })
	lsp.buffer_autoformat()
end)

lsp.set_sign_icons({ error = "✘", warn = "▲", hint = "⚑", info = "»" })

lsp.nvim_workspace()

lsp.setup()

cmp.setup({
	mapping = {
		["<CR>"] = cmp.mapping.confirm(),
		["<Up>"] = cmp.mapping.select_prev_item(),
		["<Down>"] = cmp.mapping.select_next_item(),
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-Space>"] = cmp_action.toggle_completion(),

		["<C-l>"] = cmp_action.luasnip_jump_forward(),
		["<C-h>"] = cmp_action.luasnip_jump_backward(),
		["<Tab>"] = cmp_action.luasnip_supertab(),
		["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	formatting = {
		fields = { "abbr", "kind", "menu" },
		format = require("lspkind").cmp_format({
			mode = "symbol", -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters
			ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
		}),
	},
})

local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		-- global
		null_ls.builtins.formatting.trim_whitespace,
		--null_ls.builtins.code_actions.gitsigns,

		-- lua
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.diagnostics.luacheck.with({ extra_args = { "--global vim" } }),

		-- js / ts
		null_ls.builtins.diagnostics.eslint_d,
		null_ls.builtins.code_actions.eslint_d,
		null_ls.builtins.formatting.eslint_d,
		null_ls.builtins.formatting.prettier,

		--json
		null_ls.builtins.formatting.prettier.with({
			filetypes = { "html", "json", "yaml", "markdown" },
		}),

		-- css
		null_ls.builtins.formatting.stylelint,
		null_ls.builtins.diagnostics.stylelint,

		-- vim
		null_ls.builtins.diagnostics.vint,

		-- python
		null_ls.builtins.diagnostics.flake8,
		null_ls.builtins.formatting.black,

		-- php
		null_ls.builtins.diagnostics.php,
		null_ls.builtins.formatting.phpcsfixer,

		-- prisma
		null_ls.builtins.formatting.prismaFmt.with({
			command = "prisma",
			arg = { "format", "--schema", "$FILENAME" },
		}),
	},
})
