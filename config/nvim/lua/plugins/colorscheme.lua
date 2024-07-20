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
          telescope = true,
          notify = true,
          mini = true,
          noice = true,
          lsp_trouble = true,
        },
      })
      vim.cmd([[colorscheme catppuccin-latte]])
    end,
  },
}
