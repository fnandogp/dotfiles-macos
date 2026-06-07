-- File explorer: mini.files with preview pane.
-- Adds custom buffer-local mappings: dotfile toggle, open-in-split,
-- set cwd / yank path from entry under cursor, plus a global toggle.
return {
  "nvim-mini/mini.files",
  version = false,
  opts = {
    windows = { preview = true },
    -- Sync filesystem changes with <leader>w (matches the global save key)
    mappings = { synchronize = "<leader>w" },
  },
  config = function(_, opts)
    local MiniFiles = require("mini.files")

    MiniFiles.setup(opts)

    --Create mapping to show/hide dot-files ~
    local show_dotfiles = true
    local filter_show = function(fs_entry) return true end
    local filter_hide = function(fs_entry) return not vim.startswith(fs_entry.name, ".") end
    local toggle_dotfiles = function()
      show_dotfiles = not show_dotfiles
      local new_filter = show_dotfiles and filter_show or filter_hide
      MiniFiles.refresh({ content = { filter = new_filter } })
    end

    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesBufferCreate",
      callback = function(args)
        local buf_id = args.data.buf_id
        -- Tweak left-hand side of mapping to your liking
        vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id })
      end,
    })

    -- Create mappings to modify target window via split ~
    -- Open the entry under cursor in a new split: create the split in the
    -- current target window, make it the new target, then go into the entry.
    local map_split = function(buf_id, lhs, direction)
      local rhs = function()
        -- Make new window and set it as target
        local cur_target = MiniFiles.get_explorer_state().target_window
        local new_target = vim.api.nvim_win_call(cur_target, function()
          vim.cmd(direction .. " split")
          return vim.api.nvim_get_current_win()
        end)

        MiniFiles.set_target_window(new_target)
        MiniFiles.go_in({ close_on_file = true })
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
        map_split(buf_id, "<C-s>", "belowright horizontal")
        map_split(buf_id, "<C-v>", "belowright vertical")
      end,
    })

    -- Create mappings which use data from entry under cursor ~
    -- Set focused directory as current working directory
    local set_cwd = function()
      local path = (MiniFiles.get_fs_entry() or {}).path
      if path == nil then return vim.notify("Cursor is not on valid entry") end
      vim.fn.chdir(vim.fs.dirname(path))
    end

    -- Yank in register full path of entry under cursor
    local yank_path = function()
      local path = (MiniFiles.get_fs_entry() or {}).path
      if path == nil then return vim.notify("Cursor is not on valid entry") end
      vim.fn.setreg(vim.v.register, path)
    end

    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesBufferCreate",
      callback = function(args)
        local b = args.data.buf_id
        vim.keymap.set("n", "g~", set_cwd, { buffer = b, desc = "Set cwd" })
        vim.keymap.set("n", "gy", yank_path, { buffer = b, desc = "Yank path" })
      end,
    })

    -- Create mapping to toggle file explorer
    -- close() returns false when nothing was open, so open instead - focused
    -- on the current buffer's file, falling back to cwd if it has no name.
    local minifiles_toggle = function()
      if not MiniFiles.close() then
        local ok, res = pcall(function() MiniFiles.open(vim.api.nvim_buf_get_name(0)) end)
        if not ok then MiniFiles.open() end
      end
    end
    vim.keymap.set("n", "<leader>e", minifiles_toggle, { silent = true, desc = "File Explorer" })
  end,
}
