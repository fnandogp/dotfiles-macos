return {
  {
    "monkoose/neocodeium",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      filetypes = {},
    },
    keys = {
      {
        "<A-y>",
        function()
          local neocodeium = require("neocodeium")
          if neocodeium.visible() then return neocodeium.accept() end
          return neocodeium.cycle_or_complete()
        end,
        desc = "Smart Accept or Trigger",
        mode = "i",
      },
    },
  },
}
