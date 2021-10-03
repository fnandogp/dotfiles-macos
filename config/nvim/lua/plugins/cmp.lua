local lspconfig = require("lspconfig")
local lspinstall = require("lspinstall")
local lspkind = require("lspkind")

local M = {}

local has_words_before = function()
	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
		return false
	end
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local cmp = require("cmp")

function M.config()
	local config = {
		completion = { completeopt = "menu,menuone,noinsert" },
		formatting = {
			format = function(_, vim_item)
				vim_item.kind = lspkind.presets.default[vim_item.kind] .. " " .. vim_item.kind
				return vim_item
			end,
		},
		mapping = {
			["<C-d>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.close(),
			["<CR>"] = cmp.mapping.confirm({ select = true }),
			["<Tab>"] = cmp.mapping(function(fallback)
				if vim.fn.pumvisible() == 1 then
					feedkey("<C-n>", "n")
				elseif has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end, {
				"i",
				"s",
			}),
			["<S-Tab>"] = cmp.mapping(function()
				if vim.fn.pumvisible() == 1 then
					feedkey("<C-p>", "n")
				end
			end, {
				"i",
				"s",
			}),
			-- ["C-j"] = cmp.mapping(function(fallback)
			-- 	print("C-j")
			-- 	if vim.fn.pumvisible() == 1 and vim.fn["vsnip#expandable"]() == 1 then
			-- 		print("pumvisible and expandable")
			-- 		feedkey("<Plug>(vsnip-expand-or-jump)", "")
			-- 	else
			-- 		fallback()
			-- 	end
			-- end, {
			-- 	"i",
			-- 	"s",
			-- }),
			["<C-l>"] = cmp.mapping(function(fallback)
				print("C-l")
				if vim.fn["vsnip#available"](1) == 1 then
					print("jumpable")
					feedkey("<Plug>(vsnip-expand-or-jump)", "")
				else
					fallback()
				end
			end, {
				"i",
				"s",
			}),
			["<C-h>"] = cmp.mapping(function(fallback)
				print("C-h")
				if vim.fn["vsnip#jumpable"](-1) == 1 then
					print("jumpable -1")
					feedkey("<Plug>(vsnip-jump-prev)", "")
				else
					fallback()
				end
			end, {
				"i",
				"s",
			}),
		},
		sources = {
			{ name = "vsnip" },
			{ name = "buffer" },
			{ name = "nvim_lsp" },
			{ name = "nvim_lua" },
			{ name = "path" },
		},
		documentation = {
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		},
	}
	cmp.setup(config)

	lspinstall.setup()
	local servers = lspinstall.installed_servers()
	for _, server in pairs(servers) do
		lspconfig[server].setup({
			capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
		})
	end
end

return M
