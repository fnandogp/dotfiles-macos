return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "gn", "<cmd>lua vim.lsp.buf.rename()<cr>" }
    end,
  },
}
