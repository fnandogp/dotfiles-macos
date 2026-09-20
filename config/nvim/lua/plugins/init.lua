-- Baseline: mini.basics gives sane options, mappings and autocommands.
-- Runs in now() so 'completeopt', window mappings etc. exist before other modules.
local now = MiniDeps.now

now(function()
  require("mini.basics").setup({
    options = {
      basic = true, -- Sensible defaults (number, ignorecase, undofile, etc.)
      extra_ui = true, -- Nicer UI options (termguicolors, pumheight, ...)
      win_borders = "single", -- Default border style for floating windows
    },
    mappings = {
      basic = true, -- Common mappings (e.g. better gx, j/k by visual line)
      option_toggle_prefix = [[\]], -- Prefix for toggle mappings, e.g. \s spell
      windows = true, -- <C-hjkl> window navigation, <C-arrows> resize
      move_with_alt = true, -- Alt+hjkl to move characters/lines
    },
    autocommands = {
      basic = true, -- Highlight on yank, auto-resize splits, etc.
      relnum_in_visual_mode = true, -- Show relative line numbers in visual mode
    },
  })
end)
