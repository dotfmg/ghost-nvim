-- Configures Catppuccin theme (soothing pastel theme).

return {
  'catppuccin/nvim',
  name = 'catppuccin', -- Optional custom name.
  lazy = false, -- Load eagerly on startup.
  priority = 1000, -- Load early.
  config = function()
    require('catppuccin').setup {
      flavour = 'frappe', -- Theme variant (e.g., 'latte', 'macchiato', 'mocha').
      transparent_background = false, -- Use theme's background, not terminal's.
      term_colors = true, -- Set Neovim terminal colors to match.
      -- Other options (styles, overrides, integrations) use defaults.
    }
    -- vim.cmd [[colorscheme catppuccin]] -- Apply the theme.
  end,
}
