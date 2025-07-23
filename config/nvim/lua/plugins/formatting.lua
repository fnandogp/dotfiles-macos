return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "ConformInfo" },
  config = function()
    local conform = require("conform")
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false

    local config_detection = require("plugins.utils.config_detection")

    conform.setup({
      formatters_by_ft = {
        javascript = { "deno_fmt", "biome", "prettier" },
        typescript = { "deno_fmt", "biome", "prettier" },
        javascriptreact = { "deno_fmt", "biome", "prettier" },
        typescriptreact = { "deno_fmt", "biome", "prettier" },
        svelte = { "biome", "prettier" },
        css = { "biome", "prettier" },
        html = { "biome", "prettier" },
        json = { "biome", "prettier" },
        yaml = { "biome", "prettier" },
        markdown = { "biome", "prettier" },
        graphql = { "biome", "prettier" },
        lua = { "stylua" },
        python = { "isort", "black" },
        go = { "gofmt" },
        http = { "kulala-fmt" },
      },
      formatters = {
        injected = { options = { ignore_errors = true } },
        prettier = {
          condition = function(ctx)
            local bufnr = vim.fn.bufnr(ctx.filename, false)
            if bufnr == -1 then return false end
            if config_detection.has_biome_config(bufnr) then return false end
            return config_detection.has_prettier_config(bufnr)
          end,
        },
        deno_fmt = {
          condition = function(ctx)
            local bufnr = vim.fn.bufnr(ctx.filename, false)
            if bufnr == -1 then return false end
            return config_detection.has_deno_config(bufnr)
          end,
        },
        biome = {
          condition = function(ctx)
            local bufnr = vim.fn.bufnr(ctx.filename, false)
            if bufnr == -1 then return false end
            return config_detection.has_biome_config(bufnr)
          end,
        },
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
