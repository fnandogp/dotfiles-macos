local M = {}

M.options = {
   mapleader = ",",
   tabstop = 4,
}

M.ui = {
   theme = "chadracula",
}

-- Install plugins
local userPlugins = require "custom.plugins"

M.plugins = {
   install = userPlugins,
   status = {
      bufferline = false, -- manage and preview opened buffers
      colorizer = true, -- color RGB, HEX, CSS, NAME color codes
      dashboard = true,
      snippets = true,
      autopairs = false,
   },
   options = {
      lspconfig = {
         setup_lspconf = "custom.lsp", -- path of file containing setups of different lsps
      },
   },
}

M.mappings = {
   misc = {
      cheatsheet = "<leader>ch",
      close_buffer = "<leader>x",
      copy_whole_file = "<C-a>", -- copy all contents of current buffer
      copy_to_system_clipboard = "<C-c>", -- copy selected text (visual mode) or curent line (normal)
      line_number_toggle = "<leader>n", -- toggle line number
      relative_line_number_toggle = "<leader>N",
      update_nvchad = "<leader>uu",
      new_buffer = "<nil>",
      new_tab = "<nil>",
      save_file = "<nil>", -- save file using :w
   },

   -- terminal related mappings
   terminal = {
      -- multiple mappings can be given for esc_termmode, esc_hide_termmode
      -- get out of terminal mode
      esc_termmode = { "jk" },
      -- -- get out of terminal mode and hide it
      esc_hide_termmode = { "JK" },
      -- show & recover hidden terminal buffers in a telescope picker
      pick_term = "<leader>tW",
      -- spawn terminals
      new_horizontal = "<leader>th",
      new_vertical = "<leader>tv",
      new_window = "<leader>tw",
   },
}

M.mappings.plugins = {
   comment = {
      toggle = "<leader>c",
   },

   lspconfig = {
      declaration = "gD",
      definition = "gd",
      hover = "K",
      implementation = "gi",
      signature_help = "gk",
      add_workspace_folder = "<leader>wa",
      remove_workspace_folder = "<leader>wr",
      list_workspace_folders = "<leader>wl",
      type_definition = "<leader>D",
      rename = "<leader>rn",
      code_action = "<leader>ca",
      references = "gr",
      float_diagnostics = "ge",
      goto_prev = "[d",
      goto_next = "]d",
      set_loclist = "<nil>",
      formatting = "<leader>f",
   },

   nvimtree = {
      toggle = "<leader>e",
      focus = "<nil>",
   },

   telescope = {
      buffers = "<leader>fb",
      find_files = "<leader>p",
      find_hiddenfiles = "<leader>fa",
      git_commits = "<leader>cm",
      git_status = "<leader>gt",
      help_tags = "<leader>fh",
      live_grep = "<leader>fw",
      oldfiles = "<leader>P",
      themes = "<leader>ft", -- NvChad theme picker
   },
}

return M
