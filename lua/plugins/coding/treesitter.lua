-- Configures nvim-treesitter for advanced syntax parsing and highlighting.

return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate', -- Updates all installed parsers.
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects', -- Adds text object support.
  },
  opts = {
    ensure_installed = { -- List of parsers to install.
      'lua',
      'python',
      'javascript',
      'typescript',
      'vimdoc',
      'vim',
      'regex',
      'terraform',
      'sql',
      'dockerfile',
      'toml',
      'json',
      'java',
      'groovy',
      'go',
      'gitignore',
      'graphql',
      'yaml',
      'make',
      'cmake',
      'markdown',
      'markdown_inline',
      'bash',
      'tsx',
      'css',
      'html',
      'terraform',
      'hcl',
    },
    auto_install = true, -- Automatically install missing parsers.

    highlight = {
      enable = true, -- Enables Tree-sitter based syntax highlighting.
      additional_vim_regex_highlighting = { 'ruby' }, -- Use Vim regex highlighting for Ruby.
    },
    indent = {
      enable = true, -- Enables Tree-sitter based indentation.
      disable = { 'ruby' }, -- Disable indentation for Ruby.
    },

    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Improves text object selection accuracy.
        keymaps = {
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['ab'] = '@block.outer',
          ['ib'] = '@block.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- Adds movements to the jump list.
        goto_next_start = {
          [']f'] = '@function.outer',
          [']c'] = '@class.outer',
          [']a'] = '@parameter.outer',
        },
        goto_previous_start = {
          ['[f'] = '@function.outer',
          ['[c'] = '@class.outer',
          ['[a'] = '@parameter.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>sa'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>sA'] = '@parameter.inner',
        },
      },
      lsp_interop = {
        enable = true,
        peek_definition_code = {
          ['<leader>sf'] = '@function.outer',
          ['<leader>sc'] = '@class.outer',
        },
      },
    },
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)

    local ts_repeat_move = require 'nvim-treesitter.textobjects.repeatable_move'
    vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move_next)
    vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_previous)

    vim.api.nvim_create_user_command('DebugTextobjects', function()
      print(vim.inspect(require 'nvim-treesitter.textobjects.move'))
    end, {})
  end,
}
