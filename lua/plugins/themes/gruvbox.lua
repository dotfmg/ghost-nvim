-- Configures Gruvbox theme (ellisonleao/gruvbox.nvim implementation).

return {
  'ellisonleao/gruvbox.nvim',
  lazy = false, -- Load eagerly on startup.
  priority = 1000, -- Load early.
  config = function()
    require('gruvbox').setup {
      contrast = 'soft', -- Contrast level ('hard', 'medium', 'soft').
      transparent_mode = false, -- Use theme's background.
      overrides = { -- Custom highlight group overrides.
        -- SignColumn = { bg = '#ff9900' }, -- Example: Orange background for SignColumn.
      },
      -- Other options (palette, terminal_colors, italics) use defaults.
    }
    --vim.cmd 'colorscheme gruvbox' -- This theme is not set as default here.
  end,
}
