return {
  { "preservim/nerdcommenter" },
  { "echasnovski/mini.pairs", opts = {} },
  { "echasnovski/mini.surround", opts = {} },
  { "echasnovski/mini.bufremove", version = false, opts = {} },
  { "echasnovski/mini.move", version = false, opts = {} },
  { "echasnovski/mini.ai", version = false, opts = {} },
  { "tpope/vim-fugitive" },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      { "sindrets/diffview.nvim", opts = {} }, -- optional - Diff integration
      -- Only one of these is needed.
      "nvim-telescope/telescope.nvim", -- optional
    },
    opts = {
      kind = "auto",
      telescope_sorter = function()
        return require("telescope").extensions.fzf.native_fzf_sorter()
      end,
      signs = {
        --{ CLOSED, OPENED }
        hunk = { "", "" },
        item = { "▸", "▾" },
        section = { "▸", "▾" },
      },
      integrations = {
        -- If enabled, use telescope for menu selection rather than vim.ui.select.
        -- Allows multi-select and some things that vim.ui.select doesn't.
        telescope = true,
      },
    },
    keys = {
      { "<leader>G", ":Neogit<CR>", desc = "Open Neogit", mode = "n" },
    },
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = { accept = "<M-y>" },
        },
      })
    end,
  },
}
