return {
  "echasnovski/mini.files",
  version = false,
  config = function()
    local MiniFiles = require("mini.files")

    MiniFiles.setup()

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

    local add_path_to_codecompanion_chat = function()
      local path = MiniFiles.get_fs_entry().path
      if path == nil then return vim.notify("Cursor is not on valid entry", vim.log.levels.WARN) end

      local utils = require("plugins.utils.ai-assistant")
      local file_paths = utils.list_file_paths(path)

      if #file_paths == 0 then return print("No files found") end

      local codecompanion = require("codecompanion")
      local chat = codecompanion.last_chat()
      if chat == nil then --if no chat, create one
        chat = codecompanion.chat()
      end

      for _, file_path in ipairs(file_paths) do
        utils.add_file_path_to_chat(file_path, chat)
      end
    end

    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesBufferCreate",
      callback = function(args)
        local b = args.data.buf_id
        vim.keymap.set("n", "g~", set_cwd, { buffer = b, desc = "Set cwd" })
        vim.keymap.set("n", "gy", yank_path, { buffer = b, desc = "Yank path" })
        vim.keymap.set("n", "ga", add_path_to_codecompanion_chat, { buffer = b, desc = "Add to CodeCompanion" })
      end,
    })

    -- Create mapping to toggle file explorer
    local minifiles_toggle = function()
      if not MiniFiles.close() then
        local ok, res = pcall(function() MiniFiles.open(vim.api.nvim_buf_get_name(0)) end)
        if not ok then MiniFiles.open() end
      end
    end
    vim.keymap.set("n", "<leader>e", minifiles_toggle, { silent = true, desc = "File Explorer" })
  end,
}
