local function check_formatting_enabled() return not vim.g.disable_autoformat and not vim.b.disable_autoformat end

return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "ConformInfo" },
  config = function()
    local conform = require("conform")
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false

    conform.setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        svelte = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        lua = { "stylua" },
        python = { "isort", "black" },
        go = { "gofmt" },
      },
      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        print("Formatting enabled: " .. tostring(check_formatting_enabled()))
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end
        return { timeout_ms = 2500, lsp_fallback = true }
      end,
    })

    vim.api.nvim_create_user_command("Format", function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ["end"] = { args.line2, end_line:len() },
        }
      end
      require("conform").format({ async = true, lsp_format = "fallback", range = range })
    end, { range = true })

    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        print("Disabling buffer formatting... (current value:" .. tostring(vim.b.disable_autoformat) .. ")")
        vim.b.disable_autoformat = true
        print("Buffer formatting disabled:", vim.b.disable_autoformat)
      else
        print("Disabling global formatting... (current value:" .. tostring(vim.b.disable_autoformat) .. ")")
        vim.g.disable_autoformat = true
        print("Global formatting disabled: ", vim.g.disable_autoformat)
      end
    end, { desc = "Disable autoformat-on-save", bang = true })

    vim.api.nvim_create_user_command("FormatEnable", function()
      print("Enabling formatting... (current value: " .. tostring(check_formatting_enabled()) .. ")")
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
      print("Formatting enabled: " .. tostring(check_formatting_enabled()))
    end, { desc = "Re-enable autoformat-on-save" })
  end,
  keys = {
    { "<leader>f", desc = "Format file or range (in visual mode)" },
  },
}
