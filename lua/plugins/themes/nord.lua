-- Configures Nord theme (shaunsingh/nord.nvim implementation).
-- Nord is an arctic, north-bluish color palette.

return {
  'shaunsingh/nord.nvim',
  lazy = false, -- Load on startup
  priority = 1000,
  config = function()
    --vim.cmd.colorscheme 'nord'
    -- Change background color (replace with your preferred color)
    -- vim.cmd [[highlight Normal guibg=#25272d]]
    -- -- Optionally, change other backgrounds for consistency:
    -- vim.cmd [[highlight NormalNC guibg=#25272d]]
    -- vim.cmd [[highlight SignColumn guibg=#25272d]]
    -- vim.cmd [[highlight VertSplit guibg=#25272d]]
    -- vim.cmd [[highlight StatusLine guibg=#25272d]]
    -- vim.cmd [[highlight EndOfBuffer guibg=#25272d]]
  end,
}
