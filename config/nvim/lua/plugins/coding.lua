return {
  { "preservim/nerdcommenter" },
  { "echasnovski/mini.pairs", opts = {} },
  { "echasnovski/mini.surround", opts = {} },
  { "echasnovski/mini.bufremove", version = false, opts = {} },
  { "echasnovski/mini.move", version = false, opts = {} },
  { "echasnovski/mini.ai", version = false, opts = {} },
  { "tpope/vim-fugitive" },
  --{
  --"zbirenbaum/copilot.lua",
  --cmd = "Copilot",
  --event = "InsertEnter",
  --config = function()
  --require("copilot").setup({
  --suggestion = {
  --enabled = true,
  --auto_trigger = true,
  --keymap = { accept = "<M-y>" },
  --},
  --})
  --end,
  --},
  {
    "codota/tabnine-nvim",
    build = "./dl_binaries.sh",
    config = function()
      require("tabnine").setup({
        disable_auto_comment = true,
        accept_keymap = "<M-y>",
        dismiss_keymap = "<M-n>",
        debounce_ms = 800,
        exclude_filetypes = { "TelescopePrompt", "NvimTree" },
        log_file_path = nil, -- absolute path to Tabnine log file
        ignore_certificate_errors = false,
      })
    end,
  },
}
