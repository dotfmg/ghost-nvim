-- Configures Gruvbox theme (ellisonleao/gruvbox.nvim implementation).

return {
  'ellisonleao/gruvbox.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('gruvbox').setup {
      contrast = 'soft',
      transparent_mode = false,
      overrides = {
        Normal = { bg = '#25272d' }, -- Cambia el fondo principal
        NormalNC = { bg = '#25272d' }, -- Fondo para ventanas no activas
        SignColumn = { bg = '#25272d' }, -- Fondo columna de signos
        NvimTreeNormal = { bg = '#25272d' }, -- Si usas NvimTree o Neo-tree
        -- Puedes añadir otros grupos si quieres consistencia total
      },
    }
    --vim.cmd 'colorscheme gruvbox'
  end,
}
