local myprompts = require 'plugins.ai.prompts.copilot-prompts'

return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = { { 'nvim-lua/plenary.nvim' } },
    opts = {
      question_header = ' Me ',
      answer_header = ' Copilot ',
      error_header = ' Error ',
      model = 'gpt-4o',
      prompts = myprompts,
      window = {
        layout = 'vertical',
        border = 'double',
        title = 'Copilot Chat  ',
        width = 0.4,
        height = 1,
        relative = 'editor',
        row = 0.5,
        col = 0.5,
        footer = 'Type your question and press Enter to ask Copilot.',
      },
    },
    cmd = {
      'CopilotChatCommitSmart',
      'CopilotChatVisualPrompt',
      'CopilotChatBufferPrompt',
      'CopilotChatReset',
      'CopilotChatModels',
      'CopilotChatAgents',
    },
    keys = {
      {
        '<leader>ac',
        '<cmd>CopilotChatCommitSmart<cr>',
        desc = 'CopilotChat - Smart Commit message',
      },
      {
        '<leader>av',
        ':CopilotChatVisualPrompt<cr>',
        mode = 'x',
        desc = 'CopilotChat - Select prompt for visual selection',
      },
      {
        '<leader>ab',
        ':CopilotChatBufferPrompt<cr>',
        mode = 'n',
        desc = 'CopilotChat - Select prompt for entire buffer',
      },
      {
        '<leader>al',
        '<cmd>CopilotChatReset<cr>',
        desc = 'CopilotChat - Clear buffer and chat history',
      },
      {
        '<leader>a?',
        '<cmd>CopilotChatModels<cr>',
        desc = 'CopilotChat - Select Models',
      },
      {
        '<leader>aa',
        '<cmd>CopilotChatAgents<cr>',
        desc = 'CopilotChat - Select Agents',
      },
      {
        '<leader>ao',
        '<cmd>CopilotChat<cr>',
        desc = 'CopilotChat - Open chat window',
      },
      {
        '<leader>ai',
        function()
          local mode = vim.fn.mode()
          local prompt = mode == 'v' and 'Ask Copilot   (visual): ' or 'Ask Copilot   (buffer): '
          local context = mode == 'v' and { 'visual' } or { 'buffer' }
          local input = vim.fn.input(prompt)
          if input ~= '' then
            require('CopilotChat').ask(input, { context = context })
          end
        end,
        mode = { 'n', 'x' },
        desc = 'CopilotChat - Ask with manual prompt',
      },
      {
        '<leader>aB',
        function()
          local input = vim.fn.input 'Ask Copilot   (buffers): '
          if input ~= '' then
            require('CopilotChat').ask(input, { context = { 'buffers' } })
          end
        end,
        mode = 'n',
        desc = 'CopilotChat - Ask with manual prompt (buffers)',
      },
    },
    config = function(_, opts)
      local chat = require 'CopilotChat'
      chat.setup(opts)

      -- Disable line numbers and relative numbers in CopilotChat window
      vim.api.nvim_create_autocmd({ 'FileType', 'WinEnter' }, {
        pattern = 'copilot-chat',
        callback = function()
          vim.opt_local.number = false
          vim.opt_local.relativenumber = false
          vim.opt_local.signcolumn = 'no'
          vim.opt_local.foldcolumn = '0'
        end,
      })

      local select = require 'CopilotChat.select'

      vim.api.nvim_create_user_command('CopilotChatCommitSmart', function()
        chat.ask('/Commit', { context = { 'git:staged' } })
      end, {})

      vim.api.nvim_create_user_command('CopilotChatVisualPrompt', function()
        chat.select_prompt { context = { 'visual' } }
      end, { nargs = '*', range = true })

      vim.api.nvim_create_user_command('CopilotChatBufferPrompt', function()
        chat.select_prompt { selection = select.buffer }
      end, {})
    end,
  },
}
