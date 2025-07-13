-- Configures nvim-neo-tree/neo-tree.nvim: file explorer.
-- Displays files, buffers, Git status, document symbols.

return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x', -- Use v3.x branch.
  dependencies = {
    'nvim-lua/plenary.nvim', -- Utilities.
    'nvim-tree/nvim-web-devicons', -- File type icons.
    'MunifTanjim/nui.nvim', -- UI components.
    '3rd/image.nvim', -- Optional image preview.
    { -- Window picker for some 'open_with_window_picker' actions.
      's1n7ax/nvim-window-picker',
      version = '2.*',
      config = function()
        require('window-picker').setup {
          filter_rules = { -- Filter rules for picker.
            include_current_win = false,
            autoselect_one = true,
            bo = { -- Buffer options filter.
              filetype = { 'neo-tree', 'neo-tree-popup', 'notify' }, -- Ignore these filetypes.
              buftype = { 'terminal', 'quickfix' }, -- Ignore these buffer types.
            },
          },
        }
      end,
    },
  },
  config = function()
    -- Define diagnostic signs (Nerd Font needed).
    vim.fn.sign_define('DiagnosticSignError', { text = ' ', texthl = 'DiagnosticSignError' })
    vim.fn.sign_define('DiagnosticSignWarn', { text = ' ', texthl = 'DiagnosticSignWarn' })
    vim.fn.sign_define('DiagnosticSignInfo', { text = ' ', texthl = 'DiagnosticSignInfo' })
    vim.fn.sign_define('DiagnosticSignHint', { text = '󰌵', texthl = 'DiagnosticSignHint' })

    require('neo-tree').setup {
      sources = { 'filesystem', 'buffers', 'git_status', 'document_symbols' }, -- Available tree sources.
      source_selector = { -- UI for switching sources (tabs at top).
        winbar = true, -- Show in Neo-tree winbar.
        content_layout = 'center',
        sources = { -- Display names/icons for sources.
          { source = 'filesystem', display_name = '󰉓 Files' },
          { source = 'buffers', display_name = ' Buffers' },
          { source = 'git_status', display_name = ' Git' },
          { source = 'document_symbols', display_name = '󰈙 Symbols' },
        },
      },
      close_if_last_window = true, -- Close Neo-tree if it's the last window.
      popup_border_style = 'rounded',
      enable_git_status = true,
      enable_diagnostics = true,
      open_files_do_not_replace_types = { 'terminal', 'trouble', 'qf' }, -- Don't replace these window types.
      sort_case_insensitive = false,
      default_component_configs = { -- Default UI component configs.
        container = { enable_character_fade = true },
        indent = {
          indent_size = 2,
          padding = 1,
          with_markers = true,
          indent_marker = '│',
          last_indent_marker = '└',
          highlight = 'NeoTreeIndentMarker',
          with_expanders = nil,
          expander_collapsed = '',
          expander_expanded = '',
          expander_highlight = 'NeoTreeExpander',
        },
        icon = { folder_closed = '', folder_open = '', folder_empty = '󰷏', default = '*' },
        modified = { symbol = '[+]', highlight = 'NeoTreeModified' },
        name = { trailing_slash = false, use_git_status_colors = true, highlight = 'NeoTreeFileName' },
        git_status = { -- Git status symbols.
          symbols = {
            added = '󰝒',
            modified = '',
            deleted = '✖',
            renamed = '󰁕',
            untracked = '',
            ignored = '',
            unstaged = '',
            staged = '',
            conflict = '',
          },
        },
        -- Metadata columns.
        file_size = { enabled = true, required_width = 64 },
        type = { enabled = true, required_width = 122 },
        last_modified = { enabled = true, required_width = 88 },
        created = { enabled = true, required_width = 110 },
        symlink_target = { enabled = false },
      },
      commands = {}, -- Global custom commands.
      window = { -- General Neo-tree window settings.
        position = 'left',
        width = 40,
        mapping_options = { noremap = true, nowait = true },
        mappings = { -- Keymaps when Neo-tree window is active.
          ['<space>'] = { 'toggle_node', nowait = false },
          ['<2-LeftMouse>'] = 'open',
          ['<cr>'] = 'open',
          ['<esc>'] = 'cancel',
          ['P'] = { 'toggle_preview', config = { use_float = true } }, -- Floating preview.
          ['l'] = 'open',
          ['S'] = 'open_split',
          ['s'] = 'open_vsplit',
          ['t'] = 'open_tabnew',
          ['w'] = 'open_with_window_picker',
          ['C'] = 'close_node',
          ['z'] = 'close_all_nodes',
          ['a'] = { 'add', config = { show_path = 'none' } },
          ['A'] = 'add_directory',
          ['d'] = 'delete',
          ['r'] = 'rename',
          ['y'] = 'copy_to_clipboard',
          ['x'] = 'cut_to_clipboard',
          ['p'] = 'paste_from_clipboard',
          ['c'] = 'copy',
          ['m'] = 'move',
          ['q'] = 'close_window',
          ['R'] = 'refresh',
          ['?'] = 'show_help',
          ['<'] = 'prev_source',
          ['>'] = 'next_source',
          ['i'] = 'show_file_details',
        },
      },
      nesting_rules = {}, -- Rules for file nesting.
      filesystem = { -- 'filesystem' source settings.
        filtered_items = { -- Hidden/filtered items.
          visible = false,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
          hide_by_name = { '.DS_Store', 'thumbs.db', 'node_modules', '__pycache__', '.virtual_documents', '.git', '.python-version', '.venv' },
          hide_by_pattern = {},
          always_show = {},
          never_show = {},
          never_show_by_pattern = {},
        },
        follow_current_file = { enabled = false, leave_dirs_open = false }, -- Auto-reveal current file.
        group_empty_dirs = false,
        hijack_netrw_behavior = 'open_default', -- Disable Netrw, open dirs in Neo-tree.
        use_libuv_file_watcher = false, -- Use OS file watchers (experimental).
        window = { -- Filesystem-specific mappings.
          mappings = {
            ['<bs>'] = 'navigate_up',
            ['.'] = 'set_root',
            ['H'] = 'toggle_hidden',
            ['/'] = 'fuzzy_finder',
            ['D'] = 'fuzzy_finder_directory',
            ['#'] = 'fuzzy_sorter',
            ['f'] = 'filter_on_submit',
            ['<c-x>'] = 'clear_filter',
            ['[g'] = 'prev_git_modified',
            [']g'] = 'next_git_modified',
            -- Sorting keymaps (o prefix).
            ['o'] = { 'show_help', nowait = false, config = { title = 'Order by', prefix_key = 'o' } },
            ['oc'] = { 'order_by_created', nowait = false },
            ['od'] = { 'order_by_diagnostics', nowait = false },
            ['og'] = { 'order_by_git_status', nowait = false },
            ['om'] = { 'order_by_modified', nowait = false },
            ['on'] = { 'order_by_name', nowait = false },
            ['os'] = { 'order_by_size', nowait = false },
            ['ot'] = { 'order_by_type', nowait = false },
          },
          fuzzy_finder_mappings = { -- Mappings for fuzzy finder popup.
            ['<down>'] = 'move_cursor_down',
            ['<C-n>'] = 'move_cursor_down',
            ['<up>'] = 'move_cursor_up',
            ['<C-p>'] = 'move_cursor_up',
          },
        },
        commands = {},
      },
      buffers = { -- 'buffers' source settings.
        follow_current_file = { enabled = true, leave_dirs_open = false },
        group_empty_dirs = true,
        show_unloaded = true,
        window = {
          mappings = {
            ['bd'] = 'buffer_delete',
            ['<bs>'] = 'navigate_up',
            ['.'] = 'set_root',
            ['o'] = { 'show_help', nowait = false, config = { title = 'Order by', prefix_key = 'o' } },
            ['oc'] = { 'order_by_created', nowait = false },
            ['od'] = { 'order_by_diagnostics', nowait = false },
            ['om'] = { 'order_by_modified', nowait = false },
            ['on'] = { 'order_by_name', nowait = false },
            ['os'] = { 'order_by_size', nowait = false },
            ['ot'] = { 'order_by_type', nowait = false },
          },
        },
      },
      git_status = { -- 'git_status' source settings.
        window = {
          position = 'left',
          mappings = {
            ['A'] = 'git_add_all',
            ['gu'] = 'git_unstage_file',
            ['ga'] = 'git_add_file',
            ['gr'] = 'git_revert_file',
            ['gc'] = 'git_commit',
            ['gp'] = 'git_push',
            ['gg'] = 'git_commit_and_push',
            ['o'] = { 'show_help', nowait = false, config = { title = 'Order by', prefix_key = 'o' } },
            ['oc'] = { 'order_by_created', nowait = false },
            ['od'] = { 'order_by_diagnostics', nowait = false },
            ['om'] = { 'order_by_modified', nowait = false },
            ['on'] = { 'order_by_name', nowait = false },
            ['os'] = { 'order_by_size', nowait = false },
            ['ot'] = { 'order_by_type', nowait = false },
          },
        },
      },
    }

    -- General Neo-tree keymaps.
    local keymap = vim.keymap.set
    keymap('n', '<leader>e', ':Neotree toggle <CR>', { noremap = true, silent = true }) -- Toggle Neo-tree.
    keymap('n', '<leader>ngs', ':Neotree float git_status<CR>', { noremap = true, silent = true, desc = 'Git status float' })
  end,
}
