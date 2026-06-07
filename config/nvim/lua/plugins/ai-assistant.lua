-- AI inline completion: neocodeium (Codeium) ghost-text suggestions.
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
        -- Alt+Y: accept a visible suggestion, otherwise cycle/trigger a new one
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
