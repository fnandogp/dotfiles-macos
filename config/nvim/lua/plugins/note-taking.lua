return {
  "zk-org/zk-nvim",
  config = function()
    require("zk").setup({
      picker = "minipick",
    })
  end,
  keys = {
    { "<leader>zn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", desc = "Create new note", mode = "n" },
    { "<leader>zi", "<Cmd>ZkIndex { title = vim.fn.input('Title: ') }<CR>", desc = "Create new note", mode = "n" },
    { "<leader>zp", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", desc = "Open notes" },
    { "<leader>zt", "<Cmd>ZkTags<CR>", desc = "Open notes by tag" },
    { "<leader>zb", "<Cmd>ZkBackLinks<CR>", desc = "Alternative for backlinks using pure LSP and showing the source context" },
    { "<leader>zl", "<Cmd>ZkLinks<CR>", desc = "Open notes linked by the current buffer" },
    { "<leader>zf", "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>", desc = "Search notes" },
    { "<leader>zf", ":'<,'>ZkMatch<CR>", desc = "Search notes (visual)", mode = "v" },
  },
}
