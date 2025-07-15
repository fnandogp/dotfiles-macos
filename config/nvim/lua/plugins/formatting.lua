return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "ConformInfo" },
  config = function()
    local conform = require("conform")
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false

    -- Helper function to conditionally select a formatter
    local function get_js_ts_formatters(bufnr)
      local file_path = vim.api.nvim_buf_get_name(bufnr)
      -- Search for a biome config file upward from the current buffer's path
      local biome_config = vim.fs.find({ "biome.json", "biome.jsonc" }, {
        upward = true,
        path = file_path,
        stop = vim.loop.os_homedir(),
      })

      if #biome_config > 0 then
        vim.notify("Using formatter: biome")
        return { "biome" }
      else
        vim.notify("Using formatter: prettier")
        return { "prettier" }
      end
    end

    conform.setup({
      formatters_by_ft = {
        javascript = get_js_ts_formatters,
        typescript = get_js_ts_formatters,
        javascriptreact = get_js_ts_formatters,
        typescriptreact = get_js_ts_formatters,
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
        http = { "kulala-fmt" },
      },
      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end
        return { timeout_ms = 2500, lsp_fallback = true }
      end,
    })

    vim.api.nvim_create_user_command("Format", function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = { start = { args.line1, 0 }, ["end"] = { args.line2, end_line:len() } }
      end
      conform.format({ async = true, lsp_format = "fallback", range = range })
    end, { range = true })

    vim.api.nvim_create_user_command("FormatDisable", function(args)
      -- FormatDisable! will disable formatting just for this buffer
      if args.bang then
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, { desc = "Disable autoformat-on-save", bang = true })

    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, { desc = "Re-enable autoformat-on-save" })

    vim.keymap.set("", "<leader>Ff", function()
      conform.format({ async = true }, function(err)
        if not err then
          local mode = vim.api.nvim_get_mode().mode
          if vim.startswith(string.lower(mode), "v") then vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true) end
        end
      end)
    end, { desc = "Format code" })
  end,
  keys = {
    { "<Leader>Fd", "<cmd>FormatDisable<CR>", desc = "Disable formatting" },
    { "<Leader>Fe", "<cmd>FormatEnable<CR>", desc = "Enable formatting" },
  },
}
