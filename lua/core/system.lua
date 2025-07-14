-- System-specific configurations, mainly for clipboard integration.
-- Detects OS (WSL, macOS, other Linux/Unix) and sets clipboard provider.

-- Check for Windows Subsystem for Linux (WSL).
if vim.fn.has 'wsl' == 1 then
  -- WSL: Use 'win32yank.exe' for clipboard.
  vim.g.clipboard = {
    name = 'win32yank-wsl',
    copy = {
      ['+'] = 'win32yank.exe -i --crlf', -- Copy with CRLF line endings.
      ['*'] = 'win32yank.exe -i --crlf',
    },
    paste = {
      ['+'] = 'win32yank.exe -o --lf', -- Paste with LF line endings.
      ['*'] = 'win32yank.exe -o --lf',
    },
    cache_enabled = 0, -- Disable clipboard caching.
  }
-- Check for macOS.
elseif vim.fn.has 'macunix' == 1 then
  -- macOS: Use 'pbcopy' and 'pbpaste'.
  vim.g.clipboard = {
    name = 'macOS-clipboard',
    copy = {
      ['+'] = 'pbcopy',
      ['*'] = 'pbcopy',
    },
    paste = {
      ['+'] = 'pbpaste',
      ['*'] = 'pbpaste',
    },
    cache_enabled = 0,
  }
else
  -- Default (Linux/Unix): Use 'xclip'.
  -- Requires 'xclip' to be installed.
  vim.g.clipboard = {
    name = 'default',
    copy = {
      ['+'] = 'xclip -selection clipboard', -- System clipboard.
      ['*'] = 'xclip -selection primary', -- X11 primary selection.
    },
    paste = {
      ['+'] = 'xclip -selection clipboard -o',
      ['*'] = 'xclip -selection primary -o',
    },
    cache_enabled = 0,
  }
end

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = {
    '*/templates/*.yaml',
    'values.yaml',
    'helm.yaml',
    '*.tpl',
    '*.template',
  },
  callback = function()
    vim.bo.filetype = 'helm'
  end,
})
