-- Configures Catppuccin theme (soothing pastel theme).
return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  config = function()
    require('catppuccin').setup {
      flavour = 'frappe',
      transparent_background = false,
      term_colors = true,
      color_overrides = {
        frappe = {
          base = '#25272d', -- Main background color
        },
      },
      highlight_overrides = {
        frappe = function(colors)
          return {
            Comment = { fg = colors.overlay0, italic = true }, -- Comments in code, e.g. "# comment"
            Function = { fg = colors.blue, bold = true }, -- Function names
            Keyword = { fg = colors.red, bold = true }, -- Keywords, e.g. "if"
            String = { fg = colors.yellow }, -- String literals
            ['@Keyword.function'] = { fg = colors.red, bold = true }, -- Function keywords, e.g. "def"
            ['@String.documentation'] = { fg = '#556E53', italic = true }, -- Documentation strings
          }
        end,
      },

      integrations = {
        cmp = true,
        gitsigns = true,
        telescope = true,
        treesitter = true,
        nvimtree = true,
        notify = true,
        which_key = true,
        lsp_trouble = true,
        lsp_saga = true,
        markdown = true,
        neotree = true,
        copilot_vim = true,
      },
    }
    vim.cmd [[colorscheme catppuccin]]
  end,
}
