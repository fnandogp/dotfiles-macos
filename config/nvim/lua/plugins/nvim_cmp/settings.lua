local lspkind = require("lspkind")

local feedkey = function(key, mode)
   vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local cmp = require("cmp")

cmp.setup {
      completion = { completeopt = "menu,menuone,noinsert" },
      formatting = {
         format = function(_, vim_item)
            vim_item.kind = lspkind.presets.default[vim_item.kind] .. " " .. vim_item.kind
            return vim_item
         end,
      },
      snippet = {
         expand = function(args) vim.fn["vsnip#anonymous"](args.body) end,
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
            else
               fallback()
            end
         end, { "i", "s" }),
         ["<S-Tab>"] = cmp.mapping(function(fallback)
            if vim.fn.pumvisible() == 1 then
               feedkey("<C-p>", "n")
            else
               fallback()
            end
         end, { "i", "s" }),
         ["<C-l>"] = cmp.mapping(function(fallback)
            if vim.fn["vsnip#available"](1) == 1 then
               feedkey("<Plug>(vsnip-expand-or-jump)", "")
            else
               fallback()
            end
         end, { "i", "s" }),
         ["<C-h>"] = cmp.mapping(function(fallback)
            if vim.fn["vsnip#jumpable"](-1) == 1 then
               feedkey("<Plug>(vsnip-jump-prev)", "")
            else
               fallback()
            end
         end, { "i", "s" }),
    },
    sources = {
       { name = "vsnip" ,  max_item_count = 10},
       { name = "buffer" ,  max_item_count = 10},
       { name = "nvim_lsp" ,  max_item_count = 10},
       { name = "nvim_lua" ,  max_item_count = 10},
       { name = "path" ,  max_item_count = 10},
    },
    documentation = {
       border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
 }

