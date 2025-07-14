local lspconfig = require 'lspconfig'

lspconfig.helm_ls.setup {
  filetypes = { 'helm', 'helmfile' },
  settings = {
    ['helm-ls'] = {
      yamlls = {
        enabled = true,
        enabledForFilesGlob = '*.{yaml,yml}',
        diagnosticsLimit = 50,
        showDiagnosticsDirectly = false,
        path = 'yaml-language-server',
        initTimeoutSeconds = 3,
        config = {
          schemas = {
            kubernetes = 'templates/**',
          },
          completion = true,
          hover = true,
        },
      },
      valuesFiles = {
        mainValuesFile = 'values.yaml',
        additionalValuesFilesGlobPattern = 'values*.yaml',
      },
      helmLint = {
        enabled = true,
        ignoredMessages = {},
      },
      diagnostics = {
        enabled = true,
        severity = 'warning',
      },
      logLevel = 'info',
      defaultReleaseName = 'my-release',
      defaultNamespace = 'default',
    },
  },
}
