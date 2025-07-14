-- Configures akinsho/bufferline.nvim: improved buffer line (tabs).

return {
  'akinsho/bufferline.nvim',
  dependencies = {
    'moll/vim-bbye', -- For robust buffer closing.
    'nvim-tree/nvim-web-devicons', -- File type icons.
  },
  config = function()
    require('bufferline').setup {
      options = {
        offsets = { -- Offset for the buffer line.}
          {
            filetype = 'neo-tree', -- Offset for NvimTree.
            text = '󰙅 Explorer', -- Text to display.
            text_align = 'center', -- Align text to the left.
            separator = true, -- Add a separator.
            highlight = 'Directory', -- Use Normal highlight group.
          },
          {
            filetype = 'copilot-chat', -- Usa el filetype correcto aquí
            text = ' Copilot Chat',
            text_align = 'center',
            separator = true,
            highlight = 'Directory', -- Use Normal highlight group.
          },
        },
        mode = 'buffers', -- Show open buffers (not Neovim tabs).
        themable = true, -- Allow themes to override highlights.
        numbers = 'none', -- No buffer numbers.
        close_command = 'Bdelete! %d', -- Use Bdelete to close buffers.
        buffer_close_icon = '✗',
        close_icon = '✗',
        path_components = 1, -- Show only filename (not full path).
        modified_icon = '●', -- Icon for modified buffers.
        left_trunc_marker = '', -- Truncation marker (Nerd Font).
        right_trunc_marker = '', -- Truncation marker (Nerd Font).
        max_name_length = 30,
        max_prefix_length = 30, -- For de-duplicated buffer names.
        tab_size = 21, -- Width for each buffer tab.
        diagnostics = false, -- Disable diagnostic indicators (handled by lualine).
        diagnostics_update_in_insert = false,
        color_icons = true, -- Color file type icons.
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        persist_buffer_sort = true, -- Keep custom buffer sort order.
        separator_style = { '│', '│' }, -- Separator style.
        enforce_regular_tabs = true,
        always_show_bufferline = true, -- Always show, even with one buffer.
        show_tab_indicators = false,
        indicator = { -- Active buffer indicator.
          icon = '▍', -- Indicator icon (Nerd Font).
          style = 'icon',
        },
        icon_pinned = '󰐃', -- Pinned buffer icon (Nerd Font).
        minimum_padding = 1,
        maximum_padding = 5,
        maximum_length = 15, -- Max length of displayed buffer name.
        sort_by = 'insert_at_end', -- How new buffers are sorted.
      },
      highlights = { -- Custom highlight overrides.
        separator = { fg = '#434C5E' },
        buffer_selected = { bold = true, italic = false },
        -- Other highlights can be customized here.
      },
    }
  end,
}
