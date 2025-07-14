-- Configures yamlls (YAML Language Server) for YAML LSP features.

local lspconfig = require 'lspconfig'

lspconfig.yamlls.setup {
  settings = {
    yaml = {
      validate = true,
      hover = true,
      completion = true,
      format = {
        enable = true,
        singleQuote = true,
      },
      schemaStore = {
        enable = true,
      },
      schemas = {
        ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*',
        ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = '*compose*.yaml',
        ['https://www.schemastore.org/chart.json'] = 'Chart.yaml',
        ['https://www.schemastore.org/helmfile.json'] = 'helmfile*.yaml',
      },
      customTags = { '!Ref', '!GetAtt', '!Sub', '!If' },
    },
  },
}
