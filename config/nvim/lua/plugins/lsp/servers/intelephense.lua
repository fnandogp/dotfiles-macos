return function(opts)
  return {
    on_attach = function(client, bufnr)
      opts.on_attach(client, bufnr)

      client.server_capabilities.document_formatting = false
      client.server_capabilities.document_range_formatting = false
    end,
  }
end
