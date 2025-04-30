return {
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
        integrations = {
          blink_cmp = true,
          neogit = true,
          grug_far = true,
          mason = true,
          notify = true,
          noice = true,
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
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
      })
      -- vim.cmd([[colorscheme tokyonight-day]])
    end,
  },
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
      })

      vim.cmd("colorscheme rose-pine")
    end,
  },
}
