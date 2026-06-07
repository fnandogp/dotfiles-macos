-- Custom filetype detection for files Neovim doesn't recognise by default.

-- Treat env files as shell so they get sh syntax highlighting and comments
-- if a file is a .env or .envrc file, set the filetype to sh
vim.filetype.add({
  filename = {
    [".env"] = "sh",
    [".env.*"] = "sh",
    [".envrc"] = "sh",
    ["*.env"] = "sh",
    ["*.envrc"] = "sh",
  },
})

-- Map *.http files to the http filetype (REST client request files)
vim.filetype.add({
  extension = {
    ["http"] = "http",
  },
})
