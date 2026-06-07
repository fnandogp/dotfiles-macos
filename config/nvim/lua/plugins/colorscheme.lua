-- Colourschemes. catppuccin configured with plugin integrations; rose-pine is the
-- one actually applied (its config calls `colorscheme rose-pine`).
return {
  -- Catppuccin: configured but not activated (its colorscheme line is commented out below)
  {
    "catppuccin/nvim",
    name = "catppuccin-nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("catppuccin").setup({
        show_end_of_buffer = true,
        dim_inactive = {
          enabled = true,
          shade = "dark",
          percentage = 0.15,
        },
        custom_highlights = function(colors)
          return {
            NormalFloat = { bg = colors.base },
            TelescopeNormal = { bg = colors.mantle },
          }
        end,
        -- Per-plugin highlight integrations
        integrations = {
          neogit = true,
          grug_far = true,
          mason = true,
          notify = true,
          lsp_trouble = true,
          mini = {
            enabled = true,
            indentscope_color = "",
          },
          navic = {
            enabled = true,
            custom_bg = "NONE", -- "lualine" will set background to mantle
          },
        },
      })
      -- vim.cmd([[colorscheme catppuccin-latte]])
    end,
  },
  -- Rose Pine: the active theme (light "dawn" variant), applied at the end of config
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        variant = "dawn", -- auto, main, moon, or dawn
        dark_variant = "main", -- main, moon, or dawn
        dim_inactive_windows = false,
        extend_background_behind_borders = true,

        enable = {
          terminal = true,
          legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
          migrations = true, -- Handle deprecated options automatically
        },

        styles = {
          bold = true,
          italic = true,
          transparency = false,
        },

        -- Completion popup (mini.completion / native pum) styled with rose-pine palette roles
        highlight_groups = {
          Pmenu = { fg = "text", bg = "surface" }, -- item rows
          PmenuSel = { fg = "text", bg = "overlay", bold = true }, -- selected row
          PmenuKind = { bg = "surface" }, -- kind/icon column (per-item colour set via mini.icons)
          PmenuKindSel = { bg = "overlay" },
          PmenuExtra = { fg = "muted", bg = "surface" }, -- menu/detail column
          PmenuExtraSel = { fg = "subtle", bg = "overlay" },
          PmenuMatch = { fg = "rose", bg = "surface", bold = true }, -- fuzzy-matched chars
          PmenuMatchSel = { fg = "rose", bg = "overlay", bold = true },
          PmenuSbar = { bg = "surface" }, -- scrollbar track
          PmenuThumb = { bg = "muted" }, -- scrollbar thumb
        },
      })

      vim.cmd("colorscheme rose-pine")
    end,
  },
}
