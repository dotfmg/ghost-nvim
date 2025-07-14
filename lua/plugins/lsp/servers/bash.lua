-- Configures bash-language-server (bashls) for shell scripting support.
local lspconfig = require 'lspconfig'
local util = require 'lspconfig.util'

lspconfig.bashls.setup {
  cmd = { 'bash-language-server', 'start' },
  filetypes = { 'sh', 'bash' }, -- exclude .env here
  on_new_config = function(new_config, new_root_dir)
    local fname = vim.api.nvim_buf_get_name(0)
    if fname:match '%.env$' then
      -- Prevent attaching bashls to .env files
      new_config.enabled = false
    end
  end,
  root_dir = util.find_git_ancestor or util.path.dirname,
  settings = {
    bashIde = {
      globPattern = '*@(.sh|.inc|.bash|.command)',
    },
  },
  flags = {
    debounce_text_changes = 150,
  },
}
