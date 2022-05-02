return function(opts)
  opts.capabilities.textDocument.completion.completionItem.snippetSupport = true

  return {
    capabilities = opts.capabilities,
    filetypes = { "html", "css", "typescriptreact", "javascriptreact" },
  }
end
