return {
  {
    'dotfmg/ghost-theme',
    enable = false,
    disable = true,
    lazy = true,
    priority = 1000,
    config = function()
      require('ghost').setup()
    end,
  },
}
