return function(opts)
  return {
    on_attach = function(client, bufnr)
      opts.on_attach(client, bufnr)

      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
    end,
  }
end
