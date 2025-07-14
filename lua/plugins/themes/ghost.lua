return {
  {
    'dotfmg/ghost-theme',
    lazy = false,
    priority = 1000,
    config = function()
      require('ghost').setup()
    end,
  },
}
