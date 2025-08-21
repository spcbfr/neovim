return {
  cmd = { 'phpactor', 'language-server' },
  filetypes = { 'php' },
  root_markers = { '.git', 'composer.json', '.phpactor.json', '.phpactor.yml' },
  workspace_required = true,
  settings = {
    language_server_worse_reflection = {
      inlay_hints = {
        enable = true,
      },
    },
  },
}
