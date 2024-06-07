return {
  "echasnovski/mini.files",
  version = false,
  config = function()
    local MiniFiles = require("mini.files")

    MiniFiles.setup()

    --Create mapping to show/hide dot-files ~
    local show_dotfiles = true
    local filter_show = function(fs_entry)
      return true
    end
    local filter_hide = function(fs_entry)
      return not vim.startswith(fs_entry.name, ".")
    end
    local toggle_dotfiles = function()
      show_dotfiles = not show_dotfiles
      local new_filter = show_dotfiles and filter_show or filter_hide
      MiniFiles.refresh({ content = { filter = new_filter } })
    end

    --Create mappings to modify target window via split ~
    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesBufferCreate",
      callback = function(args)
        local buf_id = args.data.buf_id
        -- Tweak left-hand side of mapping to your liking
        vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id })
      end,
    })
    local map_split = function(buf_id, lhs, direction)
      local rhs = function()
        -- Make new window and set it as target
        local new_target_window
        vim.api.nvim_win_call(MiniFiles.get_target_window(), function()
          vim.cmd(direction .. " split")
          new_target_window = vim.api.nvim_get_current_win()
        end)

        MiniFiles.set_target_window(new_target_window)
      end
      -- Adding `desc` will result into `show_help` entries
      local desc = "Split " .. direction
      vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
    end
    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesBufferCreate",
      callback = function(args)
        local buf_id = args.data.buf_id
        -- Tweak keys to your liking
        map_split(buf_id, "gs", "belowright horizontal")
        map_split(buf_id, "gv", "belowright vertical")
      end,
    })

    --Create mapping to set current working directory ~
    local files_set_cwd = function(path)
      -- Works only if cursor is on the valid file system entry
      local cur_entry_path = MiniFiles.get_fs_entry().path
      local cur_directory = vim.fs.dirname(cur_entry_path)
      vim.fn.chdir(cur_directory)
    end
    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesBufferCreate",
      callback = function(args)
        vim.keymap.set("n", "g~", files_set_cwd, { buffer = args.data.buf_id })
      end,
    })

    local minifiles_toggle = function()
      if not MiniFiles.close() then
        local ok, res = pcall(function()
          MiniFiles.open(vim.api.nvim_buf_get_name(0))
        end)
        if not ok then
          MiniFiles.open()
        end
      end
    end
    vim.keymap.set("n", "<leader>e", minifiles_toggle, { silent = true, desc = "File Explorer" })
  end,
}
--return {

--"stevearc/oil.nvim",
--dependencies = { "nvim-tree/nvim-web-devicons" },
--opts = {
--view_options = {
--show_hidden = true,
--},
--},
--keys = {
--{ "<leader>e", "<Cmd>Oil<CR>", desc = "Explorer" },
--},
--}
