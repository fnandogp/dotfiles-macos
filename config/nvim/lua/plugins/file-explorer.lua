-- File explorer: mini.files with preview pane.
-- Adds custom buffer-local mappings: dotfile toggle, open-in-split,
-- set cwd / yank name/path / OS open / reveal in Finder from entry under
-- cursor, plus a global toggle.
local later = MiniDeps.later

later(function()
  local MiniFiles = require("mini.files")

  MiniFiles.setup({
    windows = { preview = true, width_preview = 80 },
    -- Sync filesystem changes with <leader>w (matches the global save key)
    mappings = { synchronize = "<leader>w" },
  })

  -- Toggle dot-files visibility with g.
  local show_dotfiles = true
  local filter_show = function(fs_entry) return true end
  local filter_hide = function(fs_entry) return not vim.startswith(fs_entry.name, ".") end
  local toggle_dotfiles = function()
    show_dotfiles = not show_dotfiles
    local new_filter = show_dotfiles and filter_show or filter_hide
    MiniFiles.refresh({ content = { filter = new_filter } })
  end

  -- Open the entry under cursor in a new split: create the split in the
  -- current target window, make it the new target, then go into the entry.
  local map_split = function(buf_id, lhs, direction)
    local rhs = function()
      local cur_target = MiniFiles.get_explorer_state().target_window
      local new_target = vim.api.nvim_win_call(cur_target, function()
        vim.cmd(direction .. " split")
        return vim.api.nvim_get_current_win()
      end)

      MiniFiles.set_target_window(new_target)
      MiniFiles.go_in({ close_on_file = true })
    end

    -- Adding `desc` will result into `show_help` entries
    vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = "Split " .. direction })
  end

  -- Set focused directory as current working directory
  local set_cwd = function()
    local path = (MiniFiles.get_fs_entry() or {}).path
    if path == nil then return vim.notify("Cursor is not on valid entry") end
    vim.fn.chdir(vim.fs.dirname(path))
  end

  -- Yank a value derived from the entry under cursor into the (optionally
  -- prefixed) register, e.g. `"+gy` copies the filename to the clipboard.
  local yank_entry = function(transform, label)
    return function()
      local path = (MiniFiles.get_fs_entry() or {}).path
      if path == nil then return vim.notify("Cursor is not on valid entry") end
      local value = transform(path)
      vim.fn.setreg(vim.v.register, value)
      vim.notify("Yanked " .. label .. ": " .. value)
    end
  end

  local yank_name = yank_entry(function(path) return vim.fs.basename(path) end, "name")
  local yank_full = yank_entry(function(path) return path end, "path")
  local yank_relative = yank_entry(function(path) return vim.fn.fnamemodify(path, ":.") end, "relative path")

  -- Open the entry with the OS default handler (file in its app, directory in Finder)
  local os_open = function()
    local path = (MiniFiles.get_fs_entry() or {}).path
    if path == nil then return vim.notify("Cursor is not on valid entry") end
    vim.ui.open(path)
  end

  -- Reveal the entry in Finder, selected in its parent folder
  local reveal_in_finder = function()
    local path = (MiniFiles.get_fs_entry() or {}).path
    if path == nil then return vim.notify("Cursor is not on valid entry") end
    vim.system({ "open", "-R", path })
  end

  vim.api.nvim_create_autocmd("User", {
    pattern = "MiniFilesBufferCreate",
    callback = function(args)
      local b = args.data.buf_id
      vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = b, desc = "Toggle dotfiles" })
      map_split(b, "<C-s>", "belowright horizontal")
      map_split(b, "<C-v>", "belowright vertical")
      vim.keymap.set("n", "g~", set_cwd, { buffer = b, desc = "Set cwd" })
      vim.keymap.set("n", "gyf", yank_name, { buffer = b, desc = "Yank filename" })
      vim.keymap.set("n", "gyp", yank_full, { buffer = b, desc = "Yank full path" })
      vim.keymap.set("n", "gyr", yank_relative, { buffer = b, desc = "Yank relative path" })
      vim.keymap.set("n", "go", os_open, { buffer = b, desc = "OS open" })
      vim.keymap.set("n", "gf", reveal_in_finder, { buffer = b, desc = "Reveal in Finder" })
    end,
  })

  -- Toggle the explorer. close() returns false when nothing was open, so open
  -- instead - focused on the current buffer's file, falling back to cwd.
  local minifiles_toggle = function()
    if not MiniFiles.close() then
      local ok = pcall(function() MiniFiles.open(vim.api.nvim_buf_get_name(0)) end)
      if not ok then MiniFiles.open() end
    end
  end
  vim.keymap.set("n", "<leader>e", minifiles_toggle, { silent = true, desc = "File Explorer" })
end)
