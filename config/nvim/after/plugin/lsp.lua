local lsp = require("lsp-zero")
local lspFormat = require("lsp-format")
local cmp = require("cmp")
local luasnip = require("luasnip")

luasnip.filetype_extend("javascriptreact", { "javascript" })
luasnip.filetype_extend("typescript", { "javascript" })
luasnip.filetype_extend("typescriptreact", { "javascript", "typescript" })

lsp.preset("recommended")

lsp.set_preferences({
	set_lsp_keymaps = false,
})

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }
	local bind = vim.keymap.set

	bind("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	bind("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	bind("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	bind("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	bind("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	bind("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	bind("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	bind("n", "gn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	bind("n", "gx", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	bind("v", "gx", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", opts)

	bind("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	bind("n", "gL", "<cmd>lua vim.diagnostic.setqflist()<CR>", opts)
	bind("n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	bind("n", "gj", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

	bind("n", "<Leader>lr", "<Cmd>LspRestart<CR>", opts)
end)

local select_opts = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	-- confirm selection
	["<CR>"] = cmp.mapping.confirm({ select = false }),
	["<C-y>"] = cmp.mapping.confirm({ select = false }),

	-- navigate items on the list
	["<Up>"] = cmp.mapping.select_prev_item(select_opts),
	["<Down>"] = cmp.mapping.select_next_item(select_opts),
	["<C-k>"] = cmp.mapping.select_prev_item(select_opts),
	["<C-j>"] = cmp.mapping.select_next_item(select_opts),

	-- scroll up and down in the completion documentation
	["<C-d>"] = cmp.mapping.scroll_docs(5),
	["<C-u>"] = cmp.mapping.scroll_docs(-5),

	-- toggle completion
	["<C-space>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.abort()
		else
			cmp.complete()
		end
	end),

	-- go to next placeholder in the snippet
	["<C-l>"] = cmp.mapping(function(fallback)
		if luasnip.jumpable(1) then
			luasnip.jump(1)
		else
			fallback()
		end
	end, { "i", "s" }),

	-- go to previous placeholder in the snippet
	["<C-h>"] = cmp.mapping(function(fallback)
		if luasnip.jumpable(-1) then
			luasnip.jump(-1)
		else
			fallback()
		end
	end, { "i", "s" }),
})

lsp.setup_nvim_cmp({
	mapping = cmp_mappings,
	--sources = {
	--{ name = "path" },
	--{ name = "nvim_lsp", keyword_length = 3 },
	--{ name = "buffer", keyword_length = 3 },
	--{ name = "luasnip", keyword_length = 2 },
	--},
})

lsp.nvim_workspace()
lsp.setup()

lspFormat.setup({})

local null_ls = require("null-ls")
local null_opts = lsp.build_options("null-ls", {
	on_attach = function(client, bufnr)
		lspFormat.on_attach(client, bufnr)
	end,
})

null_ls.setup({
	on_attach = null_opts.on_attach,
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
