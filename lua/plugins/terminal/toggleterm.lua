-- Configures akinsho/toggleterm.nvim: toggleable terminal windows.

return {
  'akinsho/toggleterm.nvim',
  config = function()
    local toggleterm = require 'toggleterm'
    local Terminal = require('toggleterm.terminal').Terminal -- For custom terminals.

    -- Global toggleterm setup.
    toggleterm.setup {
      shade_terminals = true, -- Dim inactive terminals.
      insert_mappings = true, -- Allow open mappings in Insert mode.
      start_in_insert = true, -- Start terminals in Insert mode.
      persist_mode = true, -- Persist terminal mode across toggles.
      auto_scroll = true, -- Auto-scroll on new output.
      direction = 'horizontal', -- Default direction (bottom split).
      open_mapping = [[<C-/>]], -- Default open mapping (Ctrl+Underscore).
      autochdir = true, -- Terminals `cd` to current buffer's directory.
      winbar = { -- Winbar at top of terminal window.
        enabled = true,
        name_formatter = function(term) -- Format text in winbar.
          return ' terminal | id: ' .. term.id .. ' | cmd: ' .. (term.cmd or 'shell') -- Nerd Font icon.
        end,
      },
      float_opts = { border = 'single', title_pos = 'left' }, -- Default float options.
    }

    local file_runners = {} -- Cache for file runner terminals (by filetype).
    local cmd_map = { -- Map filetype to interpreter command.
      python = 'python3',
      lua = 'lua',
      sh = 'bash',
    }

    -- Runs current file in a dedicated floating terminal (reused by filetype).
    local function run_current_file()
      local ft = vim.bo.filetype
      local interp = cmd_map[ft]
      if not interp then
        vim.notify('Unsupported filetype for execution: ' .. ft, vim.log.levels.WARN)
        return
      end

      local file = vim.fn.expand '%:p' -- Full path of current file.
      local term = file_runners[ft]

      if not term then -- Create new terminal if none exists for filetype.
        term = Terminal:new {
          cmd = interp .. ' ' .. file,
          hidden = true,
          direction = 'float',
          close_on_exit = false, -- Keep terminal open after command exits.
          auto_scroll = true,
          name = 'file_runner_' .. ft,
        }
        file_runners[ft] = term
      else
        term.cmd = interp .. ' ' .. file -- Update command for existing terminal.
      end
      term:toggle() -- Toggle terminal visibility.
    end

    -- Keymaps for toggleterm.
    local keymap = vim.keymap.set
    keymap('n', '<leader>tr', run_current_file, { noremap = true, silent = true, desc = 'Run current file' })
    keymap('n', '<leader>tf', '<cmd>ToggleTerm direction=float<CR>', { noremap = true, silent = true, desc = 'Open floating terminal' })
    keymap('n', '<leader>tv', '<cmd>ToggleTerm direction=vertical size=80<CR>', { noremap = true, silent = true, desc = 'Open Vertical terminal' })
  end,
}
