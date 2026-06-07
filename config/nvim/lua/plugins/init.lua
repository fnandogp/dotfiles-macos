-- Core/baseline plugins loaded by lazy.nvim. Most config lives in sibling
-- modules; this file holds project config, Lua dev support and sane defaults.

return {
  { "folke/neoconf.nvim", cmd = "Neoconf" }, -- Per-project settings (.neoconf.json)
  { "folke/neodev.nvim" }, -- LSP completions/types for the Neovim Lua API
  {
    -- mini.basics: a bundle of common options, mappings and autocommands
    "nvim-mini/mini.basics",
    opts = {
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
    },
  },
}
