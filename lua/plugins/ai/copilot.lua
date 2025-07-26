-- Configures zbirenbaum/copilot.lua for GitHub Copilot suggestions.

return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot', -- Load on :Copilot command.
    event = 'InsertEnter', -- Load on entering Insert mode.
    config = function()
      require('copilot').setup {
        suggestion = { -- Inline code suggestions.
          enabled = true, -- Disabled here; likely triggered manually or by cmp.
          auto_trigger = false, -- No automatic suggestions.
          debounce = 75, -- Delay before suggesting (ms).
          keymap = { -- Keymaps for suggestions.
            accept = '<Tab>',
            next = '<C-j>',
            prev = '<C-k>',
            dismiss = '<C-c>',
          },
        },
        panel = { -- Copilot panel for multiple suggestions.
          enabled = false, -- Panel disabled.
          auto_refresh = true,
          keymap = {
            jump_next = '<C-n>',
            jump_prev = '<C-p>',
            refresh = '<C-r>',
            accept = '<CR>',
          },
          layout = {
            position = 'left', -- Panel position ("bottom", "top", "left", "right").
            ratio = 0.2, -- Relative size of panel.
          },
        },
        filetypes = { -- Enable/disable Copilot for specific filetypes.
          yaml = false,
          markdown = true,
          python = true,
          lua = true,
          ['*'] = true, -- Enabled for all other files by default.
        },
      }
    end,
  },
}
