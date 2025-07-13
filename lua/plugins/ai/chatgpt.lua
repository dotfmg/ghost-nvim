local setup_chatgpt = function()
  require('chatgpt').setup {
    openai_params = {
      model = 'gpt-4-1106-preview', -- Or 'gpt-4o' if you prefer
      temperature = 0.7,
      max_tokens = 2000,
    },
  }
end

return {
  'jackMort/ChatGPT.nvim',
  event = 'VeryLazy',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    setup_chatgpt()

    -- Modern keymap method
    vim.keymap.set('n', '<Leader>ag', '<cmd>ChatGPT<CR>', { noremap = true, silent = true, desc = 'Open ChatGPT' })
    vim.keymap.set('n', '<Leader>as', '<cmd>ChatGPTEditWithInstructions<CR>', { noremap = true, silent = true, desc = 'ChatGPT edit code with Instructions' })
  end,
}
