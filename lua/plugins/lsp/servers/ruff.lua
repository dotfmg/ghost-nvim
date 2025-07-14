-- Configures Ruff (Python linter & formatter) as an LSP server (ruff-lsp).

local lspconfig = require 'lspconfig'

lspconfig.ruff.setup {
  cmd = { 'ruff', 'server' }, -- Command to start ruff LSP.
  filetypes = { 'python' },
  init_options = { -- Options passed to ruff-lsp on initialization.
    settings = {
      configurationPreference = 'editorOnly', -- Prioritize editor settings.
      exclude = { '**/tests/**', '.venv', 'venv', 'env', '__pycache__', 'migrations', '.pytest_cache', '.git' },
      lineLength = 125,
      organizeImports = false, -- Disable ruff's import organization (use isort via none-ls).
      showSyntaxErrors = true,
      logFile = '~/ruff.log', -- Log file path.
      logLevel = 'debug', -- Log verbosity.
      pylintMaxArgs = 7,

      -- Ruff lint/format rules (mirrors pyproject.toml structure).
      configuration = {
        lint = {
          select = { 'E', 'F', 'B', 'Q', 'I', 'PL', 'D', 'AIR', 'PL', 'ARG', 'ERA', 'FAST', 'DJ', 'ANN' },
          ignore = { 'I001', 'ANN204', 'D107', 'PLR0913', 'PLR204', 'D100' }, -- Ignore specific docstring rules.
        },
        pydocstyle = {
          convention = 'google', -- Use Google style guide for docstrings.
        },
        format = {
          ['quote-style'] = 'double',
          ['docstring-code-format'] = true, -- Format code in docstrings.
        },
      },
    },
  },
  -- on_attach and capabilities are inherited from global LSP setup.
}
