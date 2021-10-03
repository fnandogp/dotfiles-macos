local M = {}

function M.config()
	local which_key = require("which-key")

	vim.g.timeoutlen = 250

	local config = {
		plugins = {
			marks = false, -- shows a list of your marks on ' and `
			registers = false,
			presets = {
				operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
				motions = false, -- adds help for motions
				text_objects = false, -- help for text objects triggered after entering an operator
				windows = false, -- default bindings on <c-w>
				nav = false, -- misc bindings to work with windows
			},
		},
		window = {
			border = "single", -- none, single, double, shadow
			position = "bottom", -- bottom, top
			margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
			padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		},
		layout = {
			height = { min = 4, max = 25 }, -- min and max height of the columns
			width = { min = 20, max = 50 }, -- min and max width of the columns
			spacing = 3, -- spacing between columns
		},
		hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
		show_help = true, -- show help message on the command line when the popup is visible
	}

	which_key.setup(config)

	which_key.register({
		w = { "<cmd>w!<CR>", "Save" },
		q = { "<cmd>q!<CR>", "Quit" },
		Q = { "<cmd>BufferClose!<CR>", "Close Buffer" },
		p = { "<cmd>Telescope find_files<CR>", "Find File" },
		h = { "<cmd>nohlsearch<CR>", "No Highlight" },
		P = {
			name = "Packer",
			c = { "<cmd>PackerCompile<cr>", "Compile" },
			i = { "<cmd>PackerInstall<cr>", "Install" },
			s = { "<cmd>PackerSync<cr>", "Sync" },
			S = { "<cmd>PackerStatus<cr>", "Status" },
			u = { "<cmd>PackerUpdate<cr>", "Update" },
		},
		l = {
			name = "LSP",
			a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
			d = {
				"<cmd>Telescope lsp_document_diagnostics<cr>",
				"Document Diagnostics",
			},
			w = {
				"<cmd>Telescope lsp_workspace_diagnostics<cr>",
				"Workspace Diagnostics",
			},
			-- f = { "<cmd>silent FormatWrite<cr>", "Format" },
			f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
			i = { "<cmd>LspInfo<cr>", "Info" },
			j = {
				"<cmd>lua vim.lsp.diagnostic.goto_next({popup_opts = {border = lvim.lsp.popup_border}})<cr>",
				"Next Diagnostic",
			},
			k = {
				"<cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = lvim.lsp.popup_border}})<cr>",
				"Prev Diagnostic",
			},
			p = {
				name = "Peek",
				d = { "<cmd>lua require('lsp.peek').Peek('definition')<cr>", "Definition" },
				t = { "<cmd>lua require('lsp.peek').Peek('typeDefinition')<cr>", "Type Definition" },
				i = { "<cmd>lua require('lsp.peek').Peek('implementation')<cr>", "Implementation" },
			},
			q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
			r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
			s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
			S = {
				"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
				"Workspace Symbols",
			},
		},
		s = {
			name = "Search",
			b = { "<cmd>Telescope buffers<cr>", "Buffers" },
			c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
			f = { "<cmd>Telescope find_files<cr>", "Find File" },
			h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
			M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
			r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
			R = { "<cmd>Telescope registers<cr>", "Registers" },
			t = { "<cmd>Telescope live_grep<cr>", "Text" },
			k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
			C = { "<cmd>Telescope commands<cr>", "Commands" },
			p = {
				"<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<cr>",
				"Colorscheme with Preview",
			},
		},
		t = {
			name = "Trouble",
			r = { "<cmd>Trouble lsp_references<cr>", "References" },
			f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
			d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnosticss" },
			q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
			l = { "<cmd>Trouble loclist<cr>", "LocationList" },
			w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnosticss" },
		},
		T = {
			name = "Treesitter",
			i = { ":TSConfigInfo<cr>", "Info" },
		},
	}, {
		mode = "n",
		prefix = "<leader>",
	})
end

return M
