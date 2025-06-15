-- Custom key mappings.

-- Set leader and localleader to Space.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable spacebar's default action (move cursor right) in Normal/Visual modes.
-- Allows <Space> to be used as leader. <Nop> = no operation.
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

local keymap = vim.keymap.set -- Shorthand for vim.keymap.set.
-- Common options: noremap=true (non-recursive), silent=true (no command display).
local opts = { noremap = true, silent = true }

-- Save & Quit
keymap({ 'n', 'i' }, '<C-s>', "<Esc><cmd>w<CR><cmd>echo 'File Saved! 💾'<CR>", opts) -- <C-s>: Save file.
keymap('n', '<C-q>', '<cmd> q <CR>', opts) -- <C-q>: Quit window.
keymap('n', '<leader>sn', '<cmd>noautocmd w <CR>', opts) -- <leader>sn: Save without auto-formatting.

-- Select all (ggVG).
keymap('n', '<C-a>', 'ggVG', opts) -- <C-a>: Select entire buffer.

-- Line navigation
keymap('n', 'H', 'g^', opts) -- H: Go to first non-blank character.
keymap('n', 'L', 'g$', opts) -- L: Go to end of line.

-- Delete single character without yanking.
keymap('n', 'x', '"_x', opts) -- x: Delete to black hole register.

-- Vertical scroll, keeping cursor centered.
keymap('n', '<C-d>', '<C-d>zz', opts) -- <C-d>: Scroll down half screen, center.
keymap('n', '<C-u>', '<C-u>zz', opts) -- <C-u>: Scroll up half screen, center.

-- Search result navigation, keeping current match centered.
keymap('n', 'n', 'nzzzv', opts) -- n: Next match, center.
keymap('n', 'N', 'Nzzzv', opts) -- N: Previous match, center.

-- Window resizing with Alt + Arrow keys.
keymap('n', '<M-Up>', ':resize -2<CR>', opts) -- Alt+Up: Decrease window height.
keymap('n', '<M-Down>', ':resize +2<CR>', opts) -- Alt+Down: Increase window height.
keymap('n', '<M-Left>', ':vertical resize -2<CR>', opts) -- Alt+Left: Decrease window width.
keymap('n', '<M-Right>', ':vertical resize +2<CR>', opts) -- Alt+Right: Increase window width.

-- Buffer management
keymap('n', '<Tab>', ':bnext<CR>', opts) -- Tab: Next buffer.
keymap('n', '<S-Tab>', ':bprevious<CR>', opts) -- Shift+Tab: Previous buffer.
keymap('n', '<leader>x', ':bdelete!<CR>', { desc = 'Close Buffer' }) -- <leader>x: Close current buffer.
keymap('n', '<leader>b', '<cmd> enew <CR>', { desc = 'New Buffer' }) -- <leader>b: New empty buffer.

-- Window management
keymap('n', '<leader>v', '<C-w>v', { desc = 'Split Window vertically' }) -- <leader>v: Vertical split.
keymap('n', '<leader>h', '<C-w>s', { desc = 'Split Window horizontally' }) -- <leader>h: Horizontal split.
keymap('n', '<leader>se', '<C-w>=', { desc = 'Make split windows iqual width & height' }) -- <leader>se: Equalize splits.
keymap('n', '<leader>xs', ':close<CR>', { desc = 'Close current split window' }) -- <leader>xs: Close current split.
keymap('n', '<leader>l', '<C-w>w', { desc = 'Switch to next split window' }) -- <leader>l: Next split.

-- Navigate splits with Ctrl + H/J/K/L.
keymap('n', '<C-k>', ':wincmd k<CR>', opts) -- Ctrl+k: Focus window above.
keymap('n', '<C-j>', ':wincmd j<CR>', opts) -- Ctrl+j: Focus window below.
keymap('n', '<C-h>', ':wincmd h<CR>', opts) -- Ctrl+h: Focus window left.
keymap('n', '<C-l>', ':wincmd l<CR>', opts) -- Ctrl+l: Focus window right.

-- Toggle line wrapping.
keymap('n', '<leader>lw', '<cmd>set wrap!<CR>', opts) -- <leader>lw: Toggle 'wrap' option.

-- Indent/unindent in Visual mode, keeping selection.
keymap('v', '<', '<gv', opts) -- <: Unindent selected lines.
keymap('v', '>', '>gv', opts) -- >: Indent selected lines.

-- Paste in Visual mode without losing last yank (replaces selection).
keymap('v', 'p', '"_dP', opts) -- p: Delete selected to black hole, then paste.

-- Diagnostic navigation/viewing.
keymap('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' }) -- [d: Previous diagnostic.
keymap('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' }) -- ]d: Next diagnostic.
keymap('n', '<leader>dd', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' }) -- <leader>dd: Show diagnostic float.

-- Note: Other keymaps are defined in plugin-specific files.
-- e.g., /lua/plugins/lsp/cmp.lua, /lua/plugins/telescope.lua etc.
