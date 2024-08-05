return {
  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    config = function()
      require("grug-far").setup({})
    end,
    keys = {
      { "<leader>ss", "<cmd>GrugFar<CR>", desc = "Open GrugFar", mode = "n" },
    },
  },
  { "natecraddock/workspaces.nvim", opts = {} },
}
