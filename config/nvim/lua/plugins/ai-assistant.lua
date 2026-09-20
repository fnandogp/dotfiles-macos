-- AI inline completion: neocodeium (Codeium) ghost-text suggestions.
local add, later = MiniDeps.add, MiniDeps.later

later(function()
  add({ source = "monkoose/neocodeium", depends = { "nvim-lua/plenary.nvim" } })
  local neocodeium = require("neocodeium")
  neocodeium.setup({ filetypes = {} })

  -- Alt+Y: accept a visible suggestion, otherwise cycle/trigger a new one
  vim.keymap.set("i", "<A-y>", function()
    if neocodeium.visible() then return neocodeium.accept() end
    return neocodeium.cycle_or_complete()
  end, { desc = "Smart Accept or Trigger" })
end)
