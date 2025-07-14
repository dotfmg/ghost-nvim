-- LSP configuration using nvim-lspconfig and mason.nvim.

return {
  {
    'neovim/nvim-lspconfig',
    event = 'BufReadPre', -- Load LSP early when a buffer is read.
    dependencies = {
      { 'williamboman/mason.nvim', version = '1.11.0' }, -- LSP server manager.
      { 'williamboman/mason-lspconfig.nvim', version = '1.32.0' }, -- Mason integration with lspconfig.
    },
    config = function()
      -- Enhance LSP capabilities for nvim-cmp.
      local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

      -- Filter diagnostics for specific cases (e.g., Pyright).
      local function filter_diagnostics(diagnostic)
        if diagnostic.source == 'Pyright' then
          return not (
            diagnostic.message:match 'is not accessed'
            or diagnostic.message:match 'could not be resolved'
            or diagnostic.message:match 'Expression value is unused'
          )
        end
        return true
      end

      -- Override diagnostics handler to apply filtering.
      vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(function(_, params, ...)
        params.diagnostics = vim.tbl_filter(filter_diagnostics, params.diagnostics)
        vim.lsp.diagnostic.on_publish_diagnostics(_, params, ...)
      end, {})

      -- Configure diagnostic UI.
      vim.diagnostic.config {
        virtual_text = {
          prefix = '~',
          spacing = 4,
          source = 'if_many',
          format = function(diagnostic)
            return string.format('%s (%s: %s)', diagnostic.message, diagnostic.source or 'unknown', diagnostic.code or '')
          end,
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '',
          },
        },
        underline = { severity = { min = vim.diagnostic.severity.WARN } },
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = 'rounded',
          source = 'always',
          format = function(diagnostic)
            return string.format('%s\n\n%s: %s', diagnostic.message, diagnostic.source or 'unknown', diagnostic.code or '')
          end,
          header = { ' Diagnostics:', 'DiagnosticHeader' },
          prefix = function(diagnostic)
            local icons = {
              [vim.diagnostic.severity.ERROR] = ' ',
              [vim.diagnostic.severity.WARN] = ' ',
              [vim.diagnostic.severity.INFO] = ' ',
              [vim.diagnostic.severity.HINT] = ' ',
            }
            return icons[diagnostic.severity] or ''
          end,
        },
      }

      -- Set diagnostic highlight colors.
      local diagnostic_colors = {
        DiagnosticError = '#F44747',
        DiagnosticWarn = '#FFCC00',
        DiagnosticInfo = '#75BEFF',
        DiagnosticHint = '#4EC9B0',
      }
      for group, color in pairs(diagnostic_colors) do
        vim.api.nvim_set_hl(0, group, { fg = color })
      end

      -- Set diagnostic underline styles.
      local diagnostic_underline = {
        DiagnosticUnderlineError = { undercurl = true, sp = '#F44747' },
        DiagnosticUnderlineWarn = { undercurl = true, sp = '#FFCC00' },
        DiagnosticUnderlineInfo = { undercurl = true, sp = '#75BEFF' },
        DiagnosticUnderlineHint = { undercurl = true, sp = '#4EC9B0' },
      }
      for group, attrs in pairs(diagnostic_underline) do
        vim.api.nvim_set_hl(0, group, attrs)
      end

      -- Configure LSP keymaps and options on attach.
      local function on_attach(client, bufnr)
        if client.name == 'sqls' then
          client.server_capabilities.documentFormattingProvider = false
        end

        local map = vim.keymap.set
        local bufopts = { noremap = true, silent = true, buffer = bufnr }

        map('n', 'gd', vim.lsp.buf.definition, bufopts)
        map('n', 'gr', vim.lsp.buf.references, bufopts)
        map('n', 'K', vim.lsp.buf.hover, bufopts)
        map('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
        map('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)

        if client.server_capabilities.documentSymbolProvider then
          if pcall(require, 'nvim-navic') then
            require('nvim-navic').attach(client, bufnr)
          end
        end
      end

      -- Setup Mason and Mason-LSPconfig.
      require('mason').setup()
      require('mason-lspconfig').setup {
        ensure_installed = {
          'lua_ls', -- Lua
          'pyright', -- Python
          'ruff', -- Python (Linter)
          'yamlls', -- YAML
          'helm_ls', -- Helm
          'ts_ls', -- TypeScript and Javascript
          'bashls', -- Bash
          'sqls', -- SQL
        },
        automatic_installation = true,
      }

      -- Default handler for LSP servers.
      require('mason-lspconfig').setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
          }
        end,
      }

      -- Load server-specific configurations.
      require 'plugins.lsp.servers.lua'
      require 'plugins.lsp.servers.pyright'
      require 'plugins.lsp.servers.ruff'
      require 'plugins.lsp.servers.yamlls'
      require 'plugins.lsp.servers.helm_ls'
      require 'plugins.lsp.servers.bash'

      -- Auto-format on save.
      local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        pattern = '*',
        callback = function()
          vim.lsp.buf.format { async = false }
        end,
      })
    end,
  },
}
